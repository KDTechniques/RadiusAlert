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
    
    func primarySelectedRadiusBinding() -> Binding<CLLocationDistance> {
        return .init(get: { self.primarySelectedRadius }, set: setPrimarySelectedRadius)
    }
    
    func secondarySelectedRadiusBinding() -> Binding<CLLocationDistance> {
        return .init(get: { self.secondarySelectedRadius }, set: setSecondarySelectedRadius)
    }
    
    /// Formats the radius value as a string, optionally including alert text and a name.
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
    
    func getRegionBoundsMetersOnRadius(for radius: CLLocationDistance) ->  CLLocationDistance {
        return radius * mapValues.radiusToRegionBoundsMetersFactor
    }
    
    /// Animates and randomizes the radius slider, then invalidates the tip.
    func onRadiusSliderTipAction() {
        withAnimation {
            setPrimarySelectedRadius(Array(stride(from: 1000, through: 2000, by: 100)).randomElement()!)
        } completion: {
            self.radiusSliderTip.invalidate(reason: .actionPerformed)
        }
    }
    
    func onRadiusSliderSlidingEnded(on type: MapTypes) {
        invalidateRadiusSliderTip()
        Task { await setRegionBoundsOnRadius(for: type) }
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
    
    func updateDistanceText() {
        guard
            let userCoordinate: CLLocationCoordinate2D = locationManager.currentUserLocation,
            markers.count == 1,
            let markerCoordinate: CLLocationCoordinate2D = markers.first?.coordinate else { return }
        
        let distance: CLLocationDistance = Utilities.getDistanceToRadius(
            userCoordinate: userCoordinate,
            markerCoordinate: markerCoordinate,
            radius: primarySelectedRadius
        )
        
        setDistanceText(distance)
    }
    
    func resetDistanceText() {
        setDistanceText(.zero)
    }
}
