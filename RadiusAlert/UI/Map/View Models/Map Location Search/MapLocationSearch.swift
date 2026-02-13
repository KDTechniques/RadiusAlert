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
        resetSearchable()
        
        if markers.isEmpty {
            Task {
                await prepareSelectedSearchResultCoordinate(on: .primary, item: item)
            }
        } else {
            let nanoSeconds: UInt64 = isPresentedMultipleStopsMapSheet ? 0 : 500_000_000
            
            /// present the multiple stops map sheet and set coordinate on secondary map type.
            /// then when user tap on add button, prepare the marker just like we do normally!
            setIsPresentedMultipleStopsMapSheet(true)
            
            Task {
                try? await Task.sleep(nanoseconds: nanoSeconds)
                await prepareSelectedSearchResultCoordinate(on: .secondary, item: item)
            }
        }
    }
    
    /// Handles a tap on an item from the recent searches list.
    ///
    /// - If there is no existing marker/selection, proceeds to select and focus the map on the recent item.
    /// - If there is an existing marker/selection (an active alert), presents a confirmation to stop it before switching.
    ///
    /// - Parameter item: The `RecentSearchModel` the user tapped.
    func onRecentSearchListRowTap(_ item: RecentSearchModel) {
        resetSearchable()
        
        if markers.isEmpty {
            Task {
                await prepareSelectedRecentSearchCoordinateOnMap(type: .primary, item: item)
            }
        } else {
            let nanoSeconds: UInt64 = isPresentedMultipleStopsMapSheet ? 0 : 500_000_000
            
            /// present the multiple stops map sheet and set coordinate on secondary map type.
            /// then when user tap on add button, prepare the marker just like we do normally!
            setIsPresentedMultipleStopsMapSheet(true)
            
            Task {
                try? await Task.sleep(nanoseconds: nanoSeconds)
                await prepareSelectedRecentSearchCoordinateOnMap(type: .secondary, item: item)
            }
        }
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
    func prepareSelectedSearchResultCoordinate(on type: MapTypes, item: MKLocalSearchCompletion) async {
        setSelectedSearchResult(from: item)
        
        // Clear any existing search UI state
        resetSearchable() // NOTE: we need to manually get rid of the cancel button forcefully. So implement that on the third party Searchable API we made.
        
        guard let mapItem: MKMapItem = try? await locationSearchManager.getMKMapItem(for: item) else { return }
        await prepareMapPositionNRegion(on: type, mapItem: mapItem, itemRadius: mapValues.minimumRadius)
    }
    
    func prepareSelectedLocationPinCoordinate(on type: MapTypes, item: LocationPinsModel) async {
        // Clear any existing search UI state
        resetSearchable()
        
        setSelectedSearchResult(nil)
        
        let mkMapItem: MKMapItem = .init(placemark: .init(coordinate: item.coordinate))
        mkMapItem.name = item.title
        
        await prepareMapPositionNRegion(on: type, mapItem: mkMapItem, itemRadius: item.radius)
    }
    
    /// Focuses the map on a location picked from recent searches.
    ///
    /// - Clears the search UI (results, text, focus) to dismiss the keyboard/cancel button.
    /// - Creates an `MKMapItem` from the recent search coordinate and optimistically updates the selection.
    /// - Animates and bounds the map around the chosen location.
    ///
    /// - Parameter item: The recent search to focus on.
    func prepareSelectedRecentSearchCoordinateOnMap(type: MapTypes, item: RecentSearchModel) async {
        // Clear any existing search UI state
        resetSearchable()
        
        setSelectedSearchResult(nil)
        
        let mkMapItem: MKMapItem = .init(placemark: .init(coordinate: item.coordinate))
        mkMapItem.name = item.title
        
        await prepareMapPositionNRegion(on: type, mapItem: mkMapItem, itemRadius: mapValues.minimumRadius)
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
    private func setSelectedSearchResult(from item: MKLocalSearchCompletion) {
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
}
