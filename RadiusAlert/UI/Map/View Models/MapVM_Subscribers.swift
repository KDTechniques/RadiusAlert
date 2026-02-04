//
//  MapVM_Subscribers.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-02.
//

import Foundation

extension MapViewModel {
    /// Subscribes to changes in the location authorization status and repositions the map if authorized.
    func authorizationStatusSubscriber() {
        locationManager.$authorizationStatus$
            .dropFirst()
            .removeDuplicates()
            // Updates authorization state and may reposition the map if authorized.
            .sink {
                // Updates internal state based on current authorization status.
                self.setIsAuthorizedToGetMapCameraUpdate($0 == .authorizedAlways || $0 == .authorizedWhenInUse)
                
                // Skips map update if not authorized.
                guard self.isAuthorizedToGetMapCameraUpdate else { return }
                
                // Delays then repositions the map to the initial user location on the main actor.
                Task { @MainActor in
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                    self.positionToInitialUserLocation()
                }
            }
            .store(in: &cancellables)
    }
}
