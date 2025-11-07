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
        searchText.isEmpty ? resetSearchResults() : onNotEmptySearchText(text)
    }
    
    /// Sets the selected search result’s coordinate and updates the map.
    /// Also resets search text and results, then animates map to the new location.
    func prepareSelectedSearchResultCoordinateOnMap(_ item: MKLocalSearchCompletion) {
        setSelectedMapItem(item)
        resetSearchResults()
        resetSearchText()
        
        Task {
            // Delay to ensure state updates propagate before moving the map
            try? await Task.sleep(nanoseconds: 500_000_000) // 0.5s
            
            let boundsMeters: CLLocationDistance = mapValues.initialUserLocationBoundsMeters
            
            guard let mapItem: MKMapItem = try? await locationSearchManager.getMKMapItem(for: item) else { return }
            
            let region: MKCoordinateRegion = .init(
                center: mapItem.placemark.coordinate,
                latitudinalMeters: boundsMeters,
                longitudinalMeters: boundsMeters
            )
            
            // Set the marker coordinate position
            setPosition(region: region, animate: true)
            
            // Wait for the default animation on setting marker position above
            try? await Task.sleep(nanoseconds: 800_000_000)
            
            // Once the position animation is over, set the region bound for better user experience
            setRegionBoundsOnRadius()
            
            // Wait for the default animation on setting region bounds above and set it's done.
            try? await Task.sleep(nanoseconds: 500_000_000)
            setSelectedSearchResult(.init(result: mapItem, doneSetting: true))
        }
    }
    
    /// Prepares the map for a user-selected `MKMapItem` comes from a location pin.
    ///
    /// - Sets the selected search result immediately for UI feedback.
    /// - Clears search results and text.
    /// - Animates the map to center on the item's coordinate with a sensible default span.
    /// - After animations complete, marks the selection as fully set (`doneSetting = true`).
    ///
    /// This method uses small delays to allow state changes and default map animations
    /// to complete in sequence, improving perceived smoothness.
    ///
    /// - Parameter item: The `MKMapItem` representing the location to focus on.
    func prepareSelectedSearchResultCoordinateOnMap(_ item: LocationPinsModel) {
        setSelectedRadius(item.radius)
        
        let mkMapItem: MKMapItem = .init(placemark: .init(coordinate: item.getCoordinate()))
        mkMapItem.name = item.title
        
        // Optimistically set the selection so the UI can reflect the choice right away
        setSelectedSearchResult(.init(result: mkMapItem))
        
        // Clear any existing search UI state
        resetSearchResults()
        resetSearchText()
        
        Task {
            // Allow state updates to propagate before moving the map
            try? await Task.sleep(nanoseconds: 500_000_000) // ~0.5s
            
            let boundsMeters: CLLocationDistance = mapValues.initialUserLocationBoundsMeters
            
            // Define a region centered on the selected item using our default bounds
            let region: MKCoordinateRegion = .init(
                center: mkMapItem.placemark.coordinate,
                latitudinalMeters: boundsMeters,
                longitudinalMeters: boundsMeters
            )
            
            // Move the marker/viewport to the new region with animation
            setPosition(region: region, animate: true)
            
            // Wait for the default position animation to complete
            try? await Task.sleep(nanoseconds: 800_000_000)
            
            // Tighten the visible region around the current radius for a better UX
            setRegionBoundsOnRadius()
            
            // Wait for the bounds animation to complete, then mark as fully set
            try? await Task.sleep(nanoseconds: 500_000_000)
            setSelectedSearchResult(.init(result: mkMapItem, doneSetting: true))
        }
    }
    
    /// Called when the selected search result changes.
    /// Updates the radius slider tip rule based on the new selection.
    func onSelectedSearchResultChange(_ result: SearchResultModel?) {
        setRadiusSliderTipRule_IsSetRadius(result)
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
    /// Handle when there's text in the search bar
    private func onNotEmptySearchText(_ text: String) {
        locationSearchManager.setIsSearching(true)
        locationSearchManager.setQueryText(searchText: text)
    }
    
    /// Handles search result selection when there’s no existing marker.
    private func onSearchResultsListRowTap_WhenMarkerCoordinateIsNil(item: MKLocalSearchCompletion) {
        prepareSelectedSearchResultCoordinateOnMap(item)
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
                
                setSelectedSearchResult(.init(result: mapItem))
            } catch {
                setSelectedSearchResult(nil)
            }
        }
    }
}

