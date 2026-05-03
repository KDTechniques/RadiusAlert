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
    
    /// Returns true if the distance between the user and given coordinate is greater than the minimum allowed distance.
    ///
    /// For example, when the user is far enough from the selected location.
    func isBeyondMinimumDistance(coordinate: CLLocationCoordinate2D?) -> Bool {
        guard let currentLocation = locationManager.currentUserLocation,
              let coordinate else { return false }
        
        let distance: CLLocationDistance = Utilities.getDistance(
            from: coordinate,
            to: currentLocation
        )
        
        return distance > MapValues.minimumDistance
    }
    
    /// Returns true if the primary map pin should be shown.
    ///
    /// For example, when distance is valid and no marker exists.
    func showPrimaryMapPin() -> Bool {
        let condition1: Bool = isBeyondMinimumDistance(coordinate: primaryCenterCoordinate)
        let condition2: Bool = isThereAnyMarkerCoordinate()
        
        return condition1 && !condition2
    }
    
    /// Returns true if the floating circle should be shown on the primary map.
    ///
    /// For example, when the map is not being dragged, the distance is valid, and no marker exists.
    func showPrimaryFloatingCircle() -> Bool {
        guard let primaryCenterCoordinate else { return false }
        
        let condition1: Bool = isPrimaryCameraDragging
        let condition2: Bool = isBeyondMinimumDistance(coordinate: primaryCenterCoordinate)
        let condition3: Bool = isThereAnyMarkerCoordinate()
        
        return !condition1 && condition2 && !condition3
    }
    
    /// Returns true if the floating circle should be shown on the secondary map.
    ///
    /// For example, when overlays are allowed and the map is not being dragged.
    func showSecondaryFloatingCircle() -> Bool {
        let condition1: Bool = showSecondaryMapOverlays()
        let condition2: Bool = isSecondaryCameraDragging
        
        return condition1 && !condition2
    }
    
    /// Returns true if overlays should be shown on the secondary map.
    ///
    /// For example, when the selected location is beyond the minimum distance.
    func showSecondaryMapOverlays() -> Bool {
        return isBeyondMinimumDistance(coordinate: secondaryCenterCoordinate)
    }
    
    /// Returns the UI type for the primary map.
    ///
    /// For example, shows radius slider when no marker exists, or distance text when exactly one marker exists.
    func showPrimaryRadiusSliderOrDistanceText() -> RadiusSliderOrDistanceTextTypes? {
        let condition1: Bool = isBeyondMinimumDistance(coordinate: primaryCenterCoordinate)
        let condition2: Bool = isThereAnyMarkerCoordinate()
        let condition3: Bool = markers.count == 1
        
        let condition4: Bool = condition1 && !condition2 // For Radius Slider
        let condition5: Bool = condition2 && condition3 // For Distance Text
        
        return (condition4 ? .radiusSlider : (condition5 ? .distanceText : nil))
    }
    
    /// Returns true if the floating alert radius text should be shown.
    ///
    /// For example, when the primary floating circle is visible.
    func showFloatingAlertRadiusText() -> Bool {
        let condition1: Bool = showPrimaryFloatingCircle()
        
        return condition1
    }
    
    /// Returns true if the "no search results" text should be displayed.
    ///
    /// For example, when search text is not empty, results are empty, and not currently searching.
    func showNoSearchResultsText() -> Bool {
        let condition1: Bool = searchText.isEmpty
        let condition2: Bool = locationSearchManager.results.isEmpty
        let condition3: Bool = locationSearchManager.isSearching
        
        return !condition1 && condition2 && !condition3
    }
    
    /// Returns true if the selected radius is less than the given distance.
    ///
    /// For example, prevents setting a radius when the user is already inside it.
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
    
    /// Returns true if the "no internet connection" text should be shown.
    ///
    /// For example, when there is no connection and the user is interacting with search.
    func showNoInternetConnectionText()  -> Bool {
        let condition1: Bool = networkManager.connectionState == .noConnection
        let condition2: Bool = searchText.isEmpty
        let condition3: Bool = isSearchFieldFocused
        
        return condition1 && (!condition2 || condition3)
    }
    
    /// Returns true if the search list background should be shown.
    ///
    /// For example, when search text is not empty or the search field is focused.
    func showSearchListBackground() -> Bool {
        let condition1: Bool = searchText.isEmpty
        let condition2: Bool = isSearchFieldFocused
        
        return !condition1 || condition2
    }
    
    /// Returns the current search type.
    ///
    /// For example, recent searches when search text is empty and field is focused, otherwise search results.
    func getMapSearchType() -> MapSearchTypes {
        return searchText.isEmpty && isSearchFieldFocused ? .recentSearches : .searchResults
    }
    
    /// Returns true if the top safe area divider should be shown.
    ///
    /// For example, when displaying search results.
    func showTopSafeAreaDivider() -> Bool {
        return getMapSearchType() == .searchResults
    }
    
    /// Returns true if primary map controls should be shown.
    ///
    /// For example, when no markers exist.
    func showPrimaryMapControls() -> Bool {
        let condition1: Bool = isThereAnyMarkerCoordinate()
        
        return !condition1
    }
    
    /// Returns the current add action type.
    ///
    /// For example, add pin when no markers exist or add multiple stops otherwise.
    func getAddPinOrMultipleStopsType() -> AddPinOrAddMultipleStops {
        markers.isEmpty ? .addPin : .addMultipleStops
    }
    
    /// Returns true if Apple review can be requested.
    ///
    /// For example, when alert count is a multiple of 5.
    func canRequestAppleReview() -> Bool {
        let count: Int = userDefaultsManager.getStartAlertCount()
        let condition: Bool = count % 5 == 0
        
        return condition
    }
    
    /// Returns true if custom review can be requested.
    ///
    /// For example, when alert count is a multiple of 10 and user has not been asked before.
    func canRequestCustomReview() -> Bool {
        let count: Int = userDefaultsManager.getStartAlertCount()
        let condition1: Bool = count % 10 == 0
        let condition2: Bool = userDefaultsManager.getDidAskForReview()
        
        return condition1 && !condition2
    }
}
