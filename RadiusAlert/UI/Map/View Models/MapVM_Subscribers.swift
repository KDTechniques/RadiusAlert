//
//  MapVM_Subscribers.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-02.
//

import Foundation
import Combine
import CoreLocation
import MapKit

// MARK: SUBSCRIBERS

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
                    self.positionToInitialUserLocation(on: .primary, animate: true)
                }
            }
            .store(in: &cancellables)
    }
    
    func currentUserLocationSubscriber() {
        locationManager.$currentUserLocation$
            .combineLatest($distanceText$)
            .throttle(for: .nanoseconds(500_000_000), scheduler: DispatchQueue.main, latest: true)
            .compactMap { $0 }
            .sink { _ in
                self.updateDistanceText()
            }
            .store(in: &cancellables)
    }
    
    func primarySelectedRadiusSubscriber() {
        $primarySelectedRadius$
            .dropFirst()
            .map { $0.rounded() }
            .debounce(for: .nanoseconds(100_000_000), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { radius in
                self.setRegionBoundsOnRadius()
            }
            .store(in: &cancellables)
    }
    
    func networkStatusSubscriber() {
        networkManager.$connectionState$
            .removeDuplicates()
            .sink { status in
                guard
                    !self.failedRouteMarkers.isEmpty,
                    status == .connected,
                    let userLocation: CLLocationCoordinate2D = self.locationManager.currentUserLocation else { return }
                
                Utilities.log("⚠️: Retrieving routes again.")
                
                Task {
                    await withTaskGroup(of: MarkerModel?.self) { [weak self] group in
                        guard let self else { return }
                        
                        for marker in failedRouteMarkers {
                            group.addTask {
                                guard
                                    let route = await self.locationManager.getRoute(
                                        pointA: userLocation,
                                        pointB: marker.coordinate
                                    ) else { return nil }
                                
                                var updatedMarker: MarkerModel = marker
                                updatedMarker.route = route
                                return updatedMarker
                            }
                        }
                        
                        for await updatedMarker in group.compactMap({ $0 }) {
                            await MainActor.run {
                                self.updateMarker(at: updatedMarker.id, value: updatedMarker)
                                self.removeFailedRouteMarker(by: updatedMarker.id)
                            }
                        }
                    }
                    Utilities.log("✅: Tried retrieving routes.")
                }
            }
            .store(in: &cancellables)
    }
}
