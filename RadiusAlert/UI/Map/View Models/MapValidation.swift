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
    func isBeyondMinimumDistance() -> Bool {
        guard let currentLocation = locationManager.currentUserLocation,
              let centerCoordinate else { return false }
        
        let distance: CLLocationDistance = Utilities.getDistance(
            from: centerCoordinate,
            to: currentLocation
        )
        
        return distance > mapValues.minimumDistance
    }
    
    /// Determines whether to show the radius circle on the map based on marker presence, distance, slider activity, and camera dragging state.
    func showRadiusCircle() -> Bool {
        // If marker coordinate is nil, check minimum distance; otherwise, default to true
        let condition1: Bool = isMarkerCoordinateNil() ? isBeyondMinimumDistance() : true
        
        // If radius slider active, true; otherwise, if marker coordinate is nil, then show only if camera is not dragging, else true
        let condition2: Bool = isRadiusSliderActive
        ? true
        : isMarkerCoordinateNil() ? !isCameraDragging : true
        
        let condition3: Bool = (multipleStopsMedium == .manual) && isBeyondMinimumDistance() && !isCameraDragging
        // MARK: NOTE: We need another condition to control the visibility of the radius circle when the medium is equal to manual just to hide the circle when the camera is moving. For now it's mainly controlled by the `isCameraDragging` property. so when in initial state the camera is not dragging so it stops there and when the map start moving again it just stops where the isCameraDragging was false. For example is we could hide the radius circle whenever the map camera starts moving and show when it stops just like it does when we try to set the map pin for the first time.
        
        return (condition1 && condition2) || (condition3)
    }
    
    /// Returns true if the user's distance is beyond minimum and no marker coordinate is set, to determine if map pin should be shown.
    func showMapPin() -> Bool {
        let condition1: Bool = isBeyondMinimumDistance()
        let condition2: Bool = isMarkerCoordinateNil()
        let condition3: Bool = multipleStopsMedium == .manual
        
        return (condition1 && condition2) || (condition1 && condition3)
    }
    
    /// Returns true if the radius slider should be visible, based on marker coordinate and user distance. Also triggers slider visibility change callback.
    func showRadiusSliderOrDistanceText() -> RadiusSliderOrDistanceTextTypes? {
        let condition1: Bool = isMarkerCoordinateNil()
        let condition2: Bool = isBeyondMinimumDistance()
        let condition3: Bool = multipleStopsMedium == .manual
        let condition4: Bool = distanceText == .zero
        
        let boolean: Bool = (condition1 && condition2) || condition3
        onRadiusSliderVisibilityChange(boolean)
        
        return boolean
        ? .radiusSlider
        : condition4 ? nil : .distanceText
    }
    
    /// Returns true if the floating alert radius text should be shown, based on radius circle visibility and marker coordinate state.
    func showFloatingAlertRadiusText() -> Bool {
        let condition1: Bool = showRadiusCircle()
        let condition2: Bool = isMarkerCoordinateNil()
        
        return condition1 && condition2
    }
    
    /// Returns true if the "no search results" text should be displayed, i.e., when search text is not empty, results are empty, and not currently searching.
    func showNoSearchResultsText() -> Bool {
        let condition1: Bool = searchText.isEmpty
        let condition2: Bool = locationSearchManager.results.isEmpty
        let condition3: Bool = locationSearchManager.isSearching
        
        // Show "no results" if search text is not empty, no results found, and not searching currently
        return !condition1 && condition2 && !condition3
    }
    
    /// Returns true if the call-to-action button should be shown, which is when search results are empty and the search field is not focused.
    func showCTAButton() -> Bool {
        // condition1: true if there are results or the no search results text is shown
        let condition1: Bool = !locationSearchManager.results.isEmpty || showNoSearchResultsText()
        
        // condition2: true if search field is focused
        let condition2: Bool = isSearchFieldFocused
        
        // CTA button visible only if no results/no texts and search field is not focused
        return !condition1 && !condition2
    }
    
    /// Checks if the selected radius is less than a given distance. Shows alert and returns false if not.
    func isSelectedRadiusLessThanDistance(distance: CLLocationDistance) -> Bool {
        guard selectedRadius < distance else {
            alertManager.showAlert(.alreadyInRadius)
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
    
    func showMapControls() -> Bool {
        let condition1: Bool = isMarkerCoordinateNil()
        let condition2: Bool = multipleStopsMedium == .manual
        
        return condition1 || condition2
    }
}
