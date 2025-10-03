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
        return Binding { [weak self] in
            self?.selectedRadius ?? MapValues.minimumRadius
        } set: { newValue in
            withAnimation { [weak self] in
                self?.setSelectedRadius(newValue)
            }
        }
    }
    
    func getRadiusTextString(_ radius: CLLocationDistance, withAlertRadiusText: Bool) -> String {
        let radius: Double = radius.rounded()
        let radiusInkilo: Double = radius/1000
        let hasDecimalPoints: Bool = radiusInkilo.truncatingRemainder(dividingBy: 1) != 0
        let inKiloMeters: String = String(format: hasDecimalPoints ? "%.1fkm" : "%.0fkm", radiusInkilo)
        let inMeters: String = "\(Int(radius))m"
        
        let numberText: String = radius >= 1000 ? inKiloMeters : inMeters
        let text: String = withAlertRadiusText ? ("Alert Radius\n"+numberText) : numberText
        
        // Returns text only
        guard withAlertRadiusText, let name: String = selectedSearchResult?.result.name else { return text }
        
        // Returns text with name
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
        guard
            locationManager.currentDistanceMode == .close,
            let markerCoordinate,
            let userLocation: CLLocationCoordinate2D = locationManager.currentUserLocation else { return }
        
        let distance: CLLocationDistance = Utilities.getDistance(from: userLocation, to: markerCoordinate)
        guard distance < selectedRadius else { return }
        
        onRegionEntry()
    }
    
    func onRadiusSliderTipAction() {
        withAnimation {
            setSelectedRadius(Array(stride(from: 1000, through: 2000, by: 100)).randomElement()!)
        } completion: { [weak self] in
            self?.radiusSliderTip.invalidate(reason: .actionPerformed)
        }
    }
    
    func onRadiusSliderEditingChanged(_ isEditing: Bool) {
        setRadiusSliderActiveState(isEditing)
        invalidateRadiusSliderTip()
    }
    
    func setRadiusSliderTipRule_IsSetRadius(_ item: SearchResultModel?) {
        guard item?.doneSetting ?? false else {
            RadiusSliderTipModel.isSetRadius = false
            return
        }
        
        RadiusSliderTipModel.isSetRadius = true
    }
    
    func invalidateRadiusSliderTip() {
        radiusSliderTip.invalidate(reason: .actionPerformed)
    }
    
    func onRadiusSliderVisibilityChange(_ boolean: Bool) {
        RadiusSliderTipModel.isSliderVisible = boolean
    }
}
