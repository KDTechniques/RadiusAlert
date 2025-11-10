//
//  MapRadius.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-08.
//

import CoreLocation
import SwiftUI

extension MapViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    func selectedRadiusBinding() -> Binding<CLLocationDistance> {
        return .init(get: { self.selectedRadius }, set: withAnimation { setSelectedRadius })
    }
    
    /// Formats the radius value as a string, optionally including alert text and a name.
    func getRadiusTextString(_ radius: CLLocationDistance, withAlertRadiusText: Bool) -> String {
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
        guard withAlertRadiusText, let name: String = selectedSearchResult?.result.name else { return text }
        
        /// Returns text with the name included
        let textWithName: String = "(\(name))\n\(text)"
        return textWithName
    }
    
    func getRadiusCircleCoordinate() -> CLLocationCoordinate2D? {
        guard let centerCoordinate else { return nil }
        return isMarkerCoordinateNil() ? centerCoordinate : markerCoordinate!
    }
    
    func onRadiusChange(_ radius: CLLocationDistance) {
        setRegionBoundsOnRadius()
        locationManager.selectedRadius = radius
    }
    
    func setRegionBoundsOnRadius() {
        guard let centerCoordinate else { return }
        
        let regionBoundMeters: CLLocationDistance = selectedRadius*mapValues.radiusToRegionBoundsMetersFactor
        setRegionBoundMeters(center: centerCoordinate, meters: regionBoundMeters)
    }
    
    func handleOnRegionEntryAlertFailure() {
        // Ensure current distance mode is close, marker coordinate exists, and user location is available
        guard
            locationManager.currentDistanceMode == .close,
            let markerCoordinate,
            let userLocation: CLLocationCoordinate2D = locationManager.currentUserLocation else { return }
        
        // Calculate the distance from the user to the marker coordinate
        let distance: CLLocationDistance = Utilities.getDistance(from: userLocation, to: markerCoordinate)
        // Proceed only if the distance is less than the selected radius
        guard distance < selectedRadius else { return }
        
        onRegionEntry()
    }
    
    /// Animates and randomizes the radius slider, then invalidates the tip.
    func onRadiusSliderTipAction() {
        withAnimation {
            setSelectedRadius(Array(stride(from: 1000, through: 2000, by: 100)).randomElement()!)
        } completion: {
            self.radiusSliderTip.invalidate(reason: .actionPerformed)
        }
    }
    
    func onRadiusSliderEditingChanged(_ isEditing: Bool) {
        setRadiusSliderActiveState(isEditing)
        invalidateRadiusSliderTip()
    }
    
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
}

