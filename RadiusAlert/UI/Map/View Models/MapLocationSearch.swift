//
//  MapLocationSearch.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-08.
//

import MapKit
import SwiftUI

extension MapViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    /// Returns a `Binding<String>` that keeps the search bar text in sync with the view model's `searchText`.
    /// Useful for connecting the SwiftUI TextField directly to the view model.
    func searchTextBinding() -> Binding<String> {
        Binding { [weak self] in
            self?.searchText ?? ""
        } set: { [weak self] in
            self?.setSearchText($0)
        }
    }
    
    /// Called when the user presses return/submit on the search bar.
    /// If there are no `MKLocalSearchCompleter` results, clear the search field.
    func onSearchTextSubmit() {
        locationSearchManager.results.isEmpty ? setSearchText("") : ()
    }
    
    /// Handles tapping a search result from the list.
    /// - If no marker coordinate is set, select the location directly.
    /// - If a marker already exists, show a confirmation to stop the ongoing alert before changing location.
    func onSearchResultsListRowTap(_ item: MKLocalSearchCompletion) {
        isMarkerCoordinateNil()
        ? onSearchResultsListRowTap_WhenMarkerCoordinateIsNil(item: item)
        : stopAlertOnSearchResultListRowTapConfirmation(item)
    }
    
    /// Called whenever the search text changes.
    /// - If the text is empty, reset results.
    /// - Otherwise, update results with the `MKLocalSearchCompleter`.
    func onSearchTextChange(_ text: String) {
        searchText.isEmpty ? onEmptySearchText() : locationSearchManager.update(searchText: text)
    }
    
    /// Clears the current search results.
    func onEmptySearchText() {
        resetSearchResults()
    }
    
    /// Sets the selected search result’s coordinate and updates the map.
    /// Also resets search text and results, then animates map to the new location.
    func setSelectedSearchResultCoordinate(_ item: MKLocalSearchCompletion) {
        setSelectedMapItem(item)
        resetSearchResults()
        resetSearchText()
        
        Task {
            // Delay to ensure state updates propagate before moving the map
            try? await Task.sleep(nanoseconds: 500_000_000)
            
            let boundsMeters: CLLocationDistance = mapValues.initialUserLocationBoundsMeters
            
            guard let mapItem: MKMapItem = try? await locationSearchManager.getMKMapItem(for: item) else { return }
            
            let region: MKCoordinateRegion = .init(
                center: mapItem.placemark.coordinate,
                latitudinalMeters: boundsMeters,
                longitudinalMeters: boundsMeters
            )
            
            setPosition(region: region, animate: true)
        }
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
    /// Handles search result selection when there’s no existing marker.
    private func onSearchResultsListRowTap_WhenMarkerCoordinateIsNil(item: MKLocalSearchCompletion) {
        setSelectedSearchResultCoordinate(item)
        setSearchFieldFocused(false)
    }
    
    /// Clears the search text field.
    private func resetSearchText() {
        setSearchText("")
    }
    
    /// Clears all search results from the list.
    private func resetSearchResults() {
        locationSearchManager.clearResults()
    }
    
    /// Handles failures in location search by clearing results.
    private func handleLocationSearchFailure() {
        locationSearchManager.clearResults()
    }
    
    /// Retrieves a full `MKMapItem` from a completion result and sets it as the selected location.
    /// If retrieval fails, the selected search result is cleared.
    private func setSelectedMapItem(_ item: MKLocalSearchCompletion) {
        Task {
            do {
                guard let mapItem: MKMapItem = try await locationSearchManager.getMKMapItem(for: item) else {
                    setSelectedSearchResult(nil)
                    return
                }
                
                setSelectedSearchResult(mapItem)
            } catch {
                setSelectedSearchResult(nil)
            }
        }
    }
}
