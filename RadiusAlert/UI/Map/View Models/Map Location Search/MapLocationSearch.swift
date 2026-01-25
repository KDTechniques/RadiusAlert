//
//  MapLocationSearch.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-08.
//

import MapKit

// MARK: LOCATION SEARCH

extension MapViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    /// Handles a tap on a search completion result from the results list.
    ///
    /// - Creates a recent-search entry for the tapped completion.
    /// - If there is no existing marker/selection, proceeds to select and focus the map on the item.
    /// - If there is an existing marker/selection (an active alert), presents a confirmation to stop it before switching.
    ///
    /// - Parameter item: The `MKLocalSearchCompletion` the user tapped.
    func onSearchResultsListRowTap(_ item: MKLocalSearchCompletion) {
        createRecentSearch(on: item)
        
//        if multipleStopsMedium == .search {
//            prepareSelectedSearchResultCoordinateOnMap(item)
//        } else {
//            isMarkerCoordinateNil()
//            ? prepareSelectedSearchResultCoordinateOnMap(item)
//            : stopAlertOnSearchResultListRowTapConfirmation(item)
//        }
    }
    
    /// Handles a tap on an item from the recent searches list.
    ///
    /// - If there is no existing marker/selection, proceeds to select and focus the map on the recent item.
    /// - If there is an existing marker/selection (an active alert), presents a confirmation to stop it before switching.
    ///
    /// - Parameter item: The `RecentSearchModel` the user tapped.
    func onRecentSearchListRowTap(_ item: RecentSearchModel) {
//        if multipleStopsMedium == .search {
//            prepareSelectedRecentSearchCoordinateOnMap(item)
//        } else {
//            isMarkerCoordinateNil()
//            ? prepareSelectedRecentSearchCoordinateOnMap(item)
//            : stopAlertOnRecentSearchListRowTapConfirmation(item)
//        }
    }
    
    /// Responds to changes in the search bar text.
    ///
    /// - If the text becomes empty, clears any existing search results and resets the search state.
    /// - Otherwise, forwards the query to the search completer to fetch new suggestions.
    ///
    /// - Parameter text: The latest text entered by the user.
    func onSearchTextChange(_ text: String) {
        searchText.isEmpty ? resetSearchResults() : onNotEmptySearchText(text)
    }
    
    /// Resolves a tapped search completion to a full `MKMapItem`, updates selection, and repositions the map.
    ///
    /// - Sets the selected search result as soon as resolution begins for responsive UI.
    /// - Clears the search UI (results, text, focus) to dismiss the keyboard and cancel button.
    /// - Asynchronously fetches the full `MKMapItem` and animates the map to the new location.
    ///
    /// - Parameter item: The completion result to resolve and focus.
    func prepareSelectedSearchResultCoordinateOnMap(_ item: MKLocalSearchCompletion) {
        setSelectedMapItem(item)
        
        // Clear any existing search UI state
        resetSearchable() // NOTE: we need to manually get rid of the cancel button forcefully. So implement that on the third party Searchable API we made.
        
        Task {
            guard let mapItem: MKMapItem = try? await locationSearchManager.getMKMapItem(for: item) else { return }
            await prepareMapPositionNRegion(mapItem)
        }
    }
    
    /// Prepares the map for a user-selected location pin from the predefined pins list.
    ///
    /// - Sets the radius from the pin, applies the selection immediately for UI feedback, and clears search UI state.
    /// - Animates the map to center on the pin's coordinate with a sensible default span.
    /// - Marks the selection as fully set (`doneSetting = true`) after the map finishes animating.
    ///
    /// - Parameter item: The location pin the user selected.
    func prepareSelectedLocationPinCoordinateOnMap(_ item: LocationPinsModel) {
        // Clear any existing search UI state
        resetSearchable()
        
        setPrimarySelectedRadius(item.radius)
        
        let mkMapItem: MKMapItem = .init(placemark: .init(coordinate: item.coordinate))
        mkMapItem.name = item.title
        
        // Optimistically set the selection so the UI can reflect the choice right away
        setSelectedSearchResult(.init(result: mkMapItem))
        
        Task { await prepareMapPositionNRegion(mkMapItem) }
    }
    
    /// Focuses the map on a location picked from recent searches.
    ///
    /// - Clears the search UI (results, text, focus) to dismiss the keyboard/cancel button.
    /// - Creates an `MKMapItem` from the recent search coordinate and optimistically updates the selection.
    /// - Animates and bounds the map around the chosen location.
    ///
    /// - Parameter item: The recent search to focus on.
    func prepareSelectedRecentSearchCoordinateOnMap(_ item: RecentSearchModel) {
        // Clear any existing search UI state
        resetSearchable()
        
        let mkMapItem: MKMapItem = .init(placemark: .init(coordinate: item.coordinate))
        mkMapItem.name = item.title
        
        // Optimistically set the selection so the UI can reflect the choice right away
        setSelectedSearchResult(.init(result: mkMapItem))
        
        Task { await prepareMapPositionNRegion(mkMapItem) }
    }
    
    /// Reacts to changes in the currently selected search result.
    ///
    /// Updates the radius slider tip/validation rule to reflect whether a radius is already set for the selection.
    ///
    /// - Parameter result: The newly selected result, or `nil` if cleared.
    func onSelectedSearchResultChange(_ result: SearchResultModel?) {
        setRadiusSliderTipRule_IsSetRadius(result)
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
    /// Resets the search UI state to a clean slate.
    ///
    /// - Clears results and text, and removes focus from the search field (hiding keyboard/cancel button).
    private func resetSearchable() {
        resetSearchResults()
        resetSearchText()
        setSearchFieldFocused(false)
    }
    
    /// Handles the case where the search text is non-empty.
    ///
    /// - Sets the searching flag and forwards the query to the internal search manager/completer.
    ///
    /// - Parameter text: The non-empty query string.
    private func onNotEmptySearchText(_ text: String) {
        locationSearchManager.setIsSearching(true)
        locationSearchManager.setQueryText(searchText: text)
    }
    
    /// Clears the search text field and any bound UI state.
    private func resetSearchText() {
        setSearchText("")
    }
    
    /// Removes all search results from the list.
    private func resetSearchResults() {
        locationSearchManager.clearResults()
    }
    
    /// Handles failures from the location search pipeline by clearing stale results.
    private func handleLocationSearchFailure() {
        locationSearchManager.clearResults()
    }
    
    /// Resolves a search completion into a full `MKMapItem` and updates the selected result.
    ///
    /// - If resolution fails or returns `nil`, clears the current selection.
    ///
    /// - Parameter item: The completion to resolve.
    private func setSelectedMapItem(_ item: MKLocalSearchCompletion) {
        Task {
            do {
                guard let mapItem: MKMapItem = try await locationSearchManager.getMKMapItem(for: item) else {
                    setSelectedSearchResult(nil)
                    return
                }
                
                setSelectedSearchResult(.init(result: mapItem))
            } catch {
                setSelectedSearchResult(nil)
            }
        }
    }
    
    /// Animates the map to the provided item and finalizes selection state.
    ///
    /// This method introduces small delays to allow SwiftUI/MapKit state changes and default animations
    /// to complete in sequence, improving perceived smoothness:
    /// 1) Wait for state propagation, 2) animate to position, 3) apply region bounds, 4) mark selection as done.
    ///
    /// - Parameter mapItem: The item whose coordinate should be centered and bounded.
    private func prepareMapPositionNRegion(_ mapItem: MKMapItem) async {
        guard let primaryCenterCoordinate else { return }
        
        // 1) Zoom out to Initial Region Bounds
        let boundsMeters: CLLocationDistance = mapValues.initialUserLocationBoundsMeters
        let initialRegion: MKCoordinateRegion = .init(
            center: primaryCenterCoordinate,
            latitudinalMeters: boundsMeters,
            longitudinalMeters: boundsMeters
        )
        await setPrimaryPosition(region: initialRegion, animate: true)
        
        // 2) Position Camera to New Coordinates
        let newRegion: MKCoordinateRegion = .init(
            center: mapItem.placemark.coordinate,
            latitudinalMeters: boundsMeters,
            longitudinalMeters: boundsMeters
        )
       
        await setPrimaryPosition(region: newRegion, animate: true)
        
        // 3) Zoom in or out to region bounds based on radius
        setRegionBoundsOnRadius()
        try? await Task.sleep(nanoseconds: 800_000_000)
        
        setSelectedSearchResult(.init(result: mapItem, doneSetting: true))
    }
}
