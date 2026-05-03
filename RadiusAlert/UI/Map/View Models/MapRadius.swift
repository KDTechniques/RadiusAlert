//
//  MapRadius.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-08.
//

import CoreLocation
import SwiftUI
import MapKit

// MARK: RADIUS

extension MapViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    /// Formats the radius value into a readable string.
    ///
    /// Shows meters for small values and kilometers for larger values.
    /// Optionally includes "Alert Radius" text and a location name.
    func getRadiusTextString(_ radius: CLLocationDistance, title: String?, withAlertRadiusText: Bool) -> String {
        /// Round the radius to the nearest whole number
        let radius: Double = radius.rounded()
        /// Convert the radius from meters to kilometers
        let radiusInKilo: Double = radius/1000
        /// Determine if the kilometer value has decimal points
        let hasDecimalPoints: Bool = radiusInKilo.truncatingRemainder(dividingBy: 1) != 0
        /// Format the kilometer string with one decimal place if needed, otherwise no decimals
        let inKiloMeters: String = String(format: hasDecimalPoints ? "%.1fkm" : "%.0fkm", radiusInKilo)
        /// Format the radius as meters string
        let inMeters: String = "\(Int(radius))m"
        
        /// Choose between km and m format depending on the radius size
        let numberText: String = radius >= 1000 ? inKiloMeters : inMeters
        /// Compose the text including "Alert Radius" prefix if requested
        let text: String = withAlertRadiusText ? ("Alert Radius\n"+numberText) : numberText
        
        /// Returns text only if no alert text or no selectedSearchResult name
        guard withAlertRadiusText, let title else { return text }
        
        /// Returns text with the name included
        let textWithName: String = "(\(title))\n\(text)"
        return textWithName
    }
    
    /// Updates map bounds based on the selected radius.
    func setRegionBoundsOnRadius(for type: MapTypes) async {
        let centerCoordinate: CLLocationCoordinate2D? = {
            switch type {
            case .primary:
                return primaryCenterCoordinate
            case .secondary:
                return secondaryCenterCoordinate
            }
        }()
        
        let radius: CLLocationDistance = {
            switch type {
            case .primary:
                return primarySelectedRadius
            case .secondary:
                return secondarySelectedRadius
            }
        }()
        
        guard let centerCoordinate else { return }
        
        await setRegionBoundMeters(
            to: centerCoordinate,
            meters: getRegionBoundsMetersOnRadius(for: radius),
            on: type,
            animate: true
        )
    }
    
    /// Returns map bounds size based on radius.
    func getRegionBoundsMetersOnRadius(for radius: CLLocationDistance) ->  CLLocationDistance {
        return radius * MapValues.radiusToRegionBoundsMetersFactor
    }
    
    /// Animates and randomizes the radius slider, then invalidates the tip.
    func onRadiusSliderTipAction() {
        withAnimation {
            setPrimarySelectedRadius(Array(stride(from: 1000, through: 2000, by: 100)).randomElement()!)
        } completion: {  [weak self] in
            guard let self else { return }
            invalidateRadiusSliderTip()
        }
    }
    
    /// Called when user stops sliding the radius slider.
    func onRadiusSliderSlidingEnded(on type: MapTypes) {
        invalidateRadiusSliderTip()
        Task { await setRegionBoundsOnRadius(for: type) }
    }
    
    /// Updates tip state when radius is set.
    func setRadiusSliderTipRule_IsSetRadius(_ item: SearchResultModel?) {
        RadiusSliderTipModel.isSetRadius = (item?.doneSetting ?? false) ? true : false
    }
    
    /// Invalidates the radius slider tip due to user action.
    func invalidateRadiusSliderTip() {
        radiusSliderTip.invalidate(reason: .actionPerformed)
    }
    
    /// Sets the visibility state of the radius slider tip.
    func onRadiusSliderVisibilityChange(_ boolean: Bool) {
        RadiusSliderTipModel.isSliderVisible = boolean
    }
    
    /// Updates distance text between user and marker.
    func updateDistanceText() {
        guard
            let userCoordinate: CLLocationCoordinate2D = locationManager.currentUserLocation,
            markers.count == 1,
            let marker: MarkerModel = markers.first else { return }
        
        let distance: CLLocationDistance = Utilities.getDistanceToRadius(
            userCoordinate: userCoordinate,
            markerCoordinate: marker.coordinate,
            radius: marker.radius
        )
        
        setDistanceText(distance)
    }
    
    func resetDistanceText() {
        setDistanceText(.zero)
    }
    
    /// Handles editing an existing marker radius.
    ///
    /// Validates inputs, updates marker, updates UI, and restarts monitoring.
    func OnEditingRadius(currentMarkerID: String, newRadius: CLLocationDistance) {
        // Validations before editing the radius
        guard
            let currentUserLocation: CLLocationCoordinate2D = locationManager.currentUserLocation,
            var currentMarker: MarkerModel = getMarkerObject(on: currentMarkerID) else {
            alertManager.showAlert(.editRadiusFailure(viewLevel: .editRadiusSheet) { [weak self] in
                guard let self else { return }
                setIsPresentedEditRadiusSheet(false)
            })
            return
        }
        
        guard isBeyondMinimumDistance(coordinate: currentMarker.coordinate) else {
            alertManager.showAlert(.stopNotBeyondMinimumDistance(viewLevel: .editRadiusSheet))
            return
        }
        
        let distanceFromUserToMarkerCoordinates: CLLocationDistance = Utilities.getDistance(from: currentUserLocation, to: currentMarker.coordinate)
        
        guard newRadius < distanceFromUserToMarkerCoordinates else {
            alertManager.showAlert(.alreadyInRadius(viewLevel: .editRadiusSheet))
            Utilities.log(MapCTAButtonErrorModel.userAlreadyInRadius.errorDescription)
            return
        }
        
        guard var currentRadiusAlertItem: RadiusAlertModel = getRadiusAlertItem(markerID: currentMarkerID) else {
            alertManager.showAlert(.editRadiusFailure(viewLevel: .editRadiusSheet) { [weak self] in
                guard let self else { return }
                setIsPresentedEditRadiusSheet(false)
            })
            return
        }
        
        // Edit the exciting references properly.
        
        // 1 - Update marker in markers array
        currentMarker.radius = newRadius
        updateMarker(at: currentMarkerID, value: currentMarker)
        
        // 2 - Update distance text between user location to the marker coordinate
        updateDistanceText()
        
        // 3 - Update radius alert item in radius alert items set
        currentRadiusAlertItem.radius = newRadius
        updateRadiusAlertItem(currentRadiusAlertItem)
        
        // 4 - Finally, update region monitor
        guard locationManager.stopNUpdateMonitorRegion(markerID: currentMarkerID, newRadius: newRadius) else {
            alertManager.showAlert(.editRadiusFailure(viewLevel: .editRadiusSheet) { [weak self] in
                guard let self else { return }
                setIsPresentedEditRadiusSheet(false)
            })
            return
        }
    }
}
