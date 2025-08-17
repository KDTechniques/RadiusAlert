//
//  MapValidation.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-08.
//

import CoreLocation

extension MapViewModel {
    // MARK: - PUBLIC FUNCTIONS
    func isBeyondMinimumDistance() -> Bool {
        guard let currentLocation = locationManager.currentUserLocation,
              let centerCoordinate else { return false }
        
        let distance: CLLocationDistance = Utilities.getDistance(
            from: centerCoordinate,
            to: currentLocation
        )
        
        return distance > mapValues.minimumDistance
    }
    
    func checkLocationPermissionOnCA() {
        // Check whether the user has still given permission to only when in use and ask them to change it to always ui get triggered here...
        let status: CLAuthorizationStatus = locationManager.manager.authorizationStatus
        if status == .authorizedWhenInUse {
            print("Show a UI to direct user to system settings here...")
        }
    }
    
    func showRadiusCircle() -> Bool {
        let condition1: Bool = isMarkerCoordinateNil() ? isBeyondMinimumDistance() : true
        
        let condition2: Bool = isRadiusSliderActive
        ? true
        : isMarkerCoordinateNil() ? !isCameraDragging : true
        
        return condition1 && condition2
    }
    
    func showMapPin() -> Bool {
        let condition1: Bool = isBeyondMinimumDistance()
        let condition2: Bool = isMarkerCoordinateNil()
        
        return condition1 && condition2
    }
    
    func showRadiusSlider() -> Bool {
        let condition1: Bool = isMarkerCoordinateNil()
        let condition2: Bool = isBeyondMinimumDistance()
        
        return condition1 && condition2
    }
    
    func showFloatingAlertRadiusText() -> Bool {
        let condition1: Bool = showRadiusCircle()
        let condition2: Bool = isMarkerCoordinateNil()
        
        return condition1 && condition2
    }
    
    func showNoSearchResultsText() -> Bool {
        let condition1: Bool = searchText.isEmpty
        let condition2: Bool = locationSearchManager.isSearching
        let condition3: Bool = locationSearchManager.results.isEmpty
        
        return !condition1 && !condition2 && condition3
    }
    
    func showCTAButton() -> Bool {
        let condition1: Bool = !locationSearchManager.results.isEmpty || showNoSearchResultsText()
        let condition2: Bool = isSearchFieldFocused
        
        return !condition1 && !condition2
    }
    
    func isSelectedRadiusLessThanDistance(distance: CLLocationDistance) -> Bool {
        guard selectedRadius < distance else {
            AlertManager.shared.alertItem = AlertTypes.alreadyInRadius
            return false
        }
        
        return true
    }
    
    func showNoInternetConnectionText()  -> Bool {
        let condition1: Bool = networkManager.connectionState == .noConnection
        let condition2: Bool = searchText.isEmpty
        let condition3: Bool = isSearchFieldFocused
        
        return condition1 && (!condition2 || condition3)
    }
}
