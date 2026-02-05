//
//  MapRoute.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-08.
//

import MapKit

// MARK: ROUTE

extension MapViewModel {
    // MARK: -  PUBLIC FUNCTIONS
    func assignRoute(to id: String) {
        let tempMarker: MarkerModel? = markers.first(where: { $0.id == id })
        
        Task {
            guard
                let userLocation: CLLocationCoordinate2D = locationManager.currentUserLocation,
                var marker: MarkerModel = tempMarker,
                let route: MKRoute = await locationManager.getRoute(pointA: userLocation, pointB: marker.coordinate) else {
                onRouteFailure(marker: tempMarker)
                return
            }
            
            marker.route = route
            updateMarker(at: id, value: marker)
        }
    }
    
    func recoverRoutes(networkStatus: ConnectionStates) {
        guard
            !self.failedRouteMarkers.isEmpty,
            networkStatus == .connected,
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
    
    // MARK: - PRIVATE FUNCTIONS
    
    private func onRouteFailure(marker: MarkerModel?) {
        guard let marker else { return }
        insertFailedRouteMarker(marker)
    }
}
