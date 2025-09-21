//
//  MapPopup.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-09.
//

import CoreLocation
import SwiftUI

extension MapViewModel {
    // MARK: - PUBLIC FUNCTIONS
    func clearPopupCardItem() {
        setPopupCardItem(nil)
    }
    
    func generateNSetPopupCardItem() {
        guard let item: RadiusAlertModel = radiusAlertItem else { return }
        
        let radiusText: String = getRadiusTextString(item.setRadius, withAlertRadiusText: false)
        let duration: String = generateDurationText(item.firstDate)
        
        let distanceToRadius: CLLocationDistance = Utilities.getDistanceToRadius(
            userCoordinate: item.firstUserLocation,
            markerCoordinate: item.markerCoordinate,
            radius: item.setRadius)
        
        let temp: CLLocationDistance = Utilities.getDistance(from: item.firstUserLocation, to: locationManager.currentUserLocation!)
        
        var errorDistanceText: String = ""
        
#if DEBUG
        errorDistanceText = "error: \(String(format: "%.0f", temp - distanceToRadius))m"
#endif
        
        let distanceText: String = getRadiusTextString(distanceToRadius, withAlertRadiusText: false)
        + "\n"
        + errorDistanceText
        
        let popupCardItem: PopupCardModel = .init(
            typeNValue: [
                (.radius, radiusText),
                (.duration, duration),
                (.distance, distanceText)
            ],
            locationTitle: item.locationTitle
        )
        
        setPopupCardItem(popupCardItem)
    }
    
    func reduceAlertToneVolumeOnScenePhaseChange() {
        guard popupCardItem != nil else { return }
        
        // set the player volume to absolute 50%. That means the total volume of both system and the player must equal to 50%.
        // To do so: if system volume is 80%, we set the player volume to 30%.
        // So player volume = system volume - Absolute Volume
        let absoluteVolume: Float = 0.5
        let systemVolume: Float = Utilities.getSystemVolume()
        let playerVolume: Float = systemVolume - absoluteVolume
        
        alertManager.setToneVolume(playerVolume)
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func generateDurationText(_ date: Date) -> String {
        let interval = Date.now.timeIntervalSince(date)
        let totalMinutes = Int(interval / 60)
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        
        var duration: String {
            if hours > 0 {
                if minutes > 0 {
                    return "\(hours)h \(minutes)min."
                } else {
                    return "\(hours)h"
                }
            } else {
                return "\(minutes)min."
            }
        }
        
        return duration
    }
}
