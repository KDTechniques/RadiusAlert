//
//  MapValidation.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-08.
//

import CoreLocation

// MARK: VALIDATION

extension MapViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    /// Returns true if the distance between the user's location and center is above the minimum threshold.
    func isBeyondMinimumDistance(coordinate: CLLocationCoordinate2D?) -> Bool {
        guard let currentLocation = locationManager.currentUserLocation,
              let coordinate else { return false }
        
        let distance: CLLocationDistance = Utilities.getDistance(
            from: coordinate,
            to: currentLocation
        )
        
        return distance > MapValues.minimumDistance
    }
    
    /// Returns true if the user's distance is beyond minimum and no marker coordinate is set, to determine if map pin should be shown.
    func showPrimaryMapPin() -> Bool {
        let condition1: Bool = isBeyondMinimumDistance(coordinate: primaryCenterCoordinate)
        let condition2: Bool = isThereAnyMarkerCoordinate()
        
        return condition1 && !condition2
    }
    
    func showSecondaryMapPin() -> Bool {
        false // add logic here later......
    }
    
    func showPrimaryFloatingCircle() -> Bool {
        guard let primaryCenterCoordinate else { return false }
        
        let condition1: Bool = isPrimaryCameraDragging
        let condition2: Bool = isBeyondMinimumDistance(coordinate: primaryCenterCoordinate)
        let condition3: Bool = isThereAnyMarkerCoordinate()
        
        return !condition1 && condition2 && !condition3
    }
    
    func showSecondaryFloatingCircle() -> Bool {
        let condition1: Bool = showSecondaryMapOverlays()
        let condition2: Bool = isSecondaryCameraDragging
        
        return condition1 && !condition2
    }
    
    func showSecondaryMapOverlays() -> Bool {
        return isBeyondMinimumDistance(coordinate: secondaryCenterCoordinate)
    }
    
    /// Returns true if the radius slider should be visible, based on marker coordinate and user distance. Also triggers slider visibility change callback.
    func showPrimaryRadiusSliderOrDistanceText() -> RadiusSliderOrDistanceTextTypes? {
        let condition1: Bool = isBeyondMinimumDistance(coordinate: primaryCenterCoordinate)
        let condition2: Bool = isThereAnyMarkerCoordinate()
        let condition3: Bool = markers.count == 1
        
        let condition4: Bool = condition1 && !condition2 // For Radius Slider
        let condition5: Bool = condition2 && condition3 // For Distance Text
        
        return (condition4 ? .radiusSlider : (condition5 ? .distanceText : nil))
    }
    
    /// Returns true if the floating alert radius text should be shown, based on radius circle visibility.
    func showFloatingAlertRadiusText() -> Bool {
        let condition1: Bool = showPrimaryFloatingCircle()
        
        return condition1
    }
    
    /// Returns true if the "no search results" text should be displayed, i.e., when search text is not empty, results are empty, and not currently searching.
    func showNoSearchResultsText() -> Bool {
        let condition1: Bool = searchText.isEmpty
        let condition2: Bool = locationSearchManager.results.isEmpty
        let condition3: Bool = locationSearchManager.isSearching
        
        // Show "no results" if search text is not empty, no results found, and not searching currently
        return !condition1 && condition2 && !condition3
    }
    
    /// Checks if the selected radius is less than a given distance. Shows alert and returns false if not.
    func isSelectedRadiusLessThanDistance(on type: MapTypes, distance: CLLocationDistance) -> Bool {
        let radius: CLLocationDistance = {
            switch type {
            case .primary:
                return primarySelectedRadius
            case .secondary:
                return secondarySelectedRadius
            }
        }()
        
        let viewLevel: AlertViewLevels = {
            switch type {
            case .primary:
                return .content
            case .secondary:
                return .multipleStopsMapSheet
            }
        }()
        
        guard radius < distance else {
            alertManager.showAlert(.alreadyInRadius(viewLevel: viewLevel))
            return false
        }
        
        return true
    }
    
    /// Returns true if no internet connection is detected and either search text is not empty or search field is focused.
    func showNoInternetConnectionText()  -> Bool {
        let condition1: Bool = networkManager.connectionState == .noConnection
        let condition2: Bool = searchText.isEmpty
        let condition3: Bool = isSearchFieldFocused
        
        return condition1 && (!condition2 || condition3)
    }
    
    /// Returns true if the search list background should be shown, i.e., when search text is not empty or search field is focused.
    func showSearchListBackground() -> Bool {
        let condition1: Bool = searchText.isEmpty
        let condition2: Bool = isSearchFieldFocused
        
        return !condition1 || condition2
    }
    
    func getMapSearchType() -> MapSearchTypes {
        return searchText.isEmpty && isSearchFieldFocused ? .recentSearches : .searchResults
    }
    
    func showTopSafeAreaDivider() -> Bool {
        return getMapSearchType() == .searchResults
    }
    
    func showPrimaryMapControls() -> Bool {
        let condition1: Bool = isThereAnyMarkerCoordinate()
        
        return !condition1
    }
    
    func getAddPinOrMultipleStopsType() -> AddPinOrAddMultipleStops {
        markers.isEmpty ? .addPin : .addMultipleStops
    }
    
    func canRequestAppleReview() -> Bool {
        let count: Int = userDefaultsManager.getStartAlertCount()
        let condition: Bool = count % 5 == 0
        
        return condition
    }
    
    func canRequestCustomReview() -> Bool {
        let count: Int = userDefaultsManager.getStartAlertCount()
        let condition1: Bool = count % 10 == 0
        let condition2: Bool = userDefaultsManager.getDidAskForReview()
        
        return condition1 && !condition2
    }
}
