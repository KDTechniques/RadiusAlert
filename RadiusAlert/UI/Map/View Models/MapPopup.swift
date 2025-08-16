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
        
        let coordinate1: CLLocation = .init(
            latitude: item.firstUserLocation.latitude,
            longitude: item.firstUserLocation.longitude
        )
        
        let coordinate2: CLLocation = .init(
            latitude: item.markerCoordinate.latitude,
            longitude: item.markerCoordinate.longitude
        )
        
        let actualDistance: CLLocationDistance = coordinate1.distance(from: coordinate2) - item.setRadius
        let distanceText: String = getRadiusTextString(actualDistance, withAlertRadiusText: false)
        
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
    
    func playHapticsInForeground(by scenePhase: ScenePhase)  {
        guard scenePhase == .active else { return }
        
        Task {
            try? await Task.sleep(nanoseconds: 500_000_000)
            alertManager.playHaptic()
        }
    }
    
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
