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
    func searchLocation() {
        cancelSearchQueryTask()
        resetSearchResults()
        setIsSearching(true)
        
        searchQueryTask = Task { @MainActor in
            guard let region = position.region else { return }
            let request = MKLocalSearch.Request()
            request.region = region
            request.naturalLanguageQuery = searchText
            
            guard let response = try? await MKLocalSearch(request: request).start() else {
                setSearchResults([])
                setIsSearching(false)
                return
            }
            
            setIsSearching(false)
            let results: [MKMapItem] = response.mapItems.compactMap({ $0 })
            setSearchResults(results)
            cancelSearchQueryTask()
        }
    }
    
    func onSearchResultsListRowTap(_ item: MKMapItem) {
        isMarkerCoordinateNil()
        ? setSelectedSearchResultCoordinate(item)
        : stopAlertOnSearchResultListRowTapConfirmation(item)
    }
    
    func showSearchResultsList() -> Bool {
        let condition1: Bool = showSearchResults()
        let condition2: Bool = showNoSearchResultsText()
        let condition3: Bool = showSearchingCircularProgress()
        
        return condition1 || condition2 || condition3
    }
    
    func onSearchTextChange() {
        guard searchText.isEmpty else { return }
        resetSearchResults()
        cancelSearchQueryTask()
    }
    
    func setSelectedSearchResultCoordinate(_ item: MKMapItem) {
        resetSearchResults()
        resetSearchText()
        
        Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            let boundsMeters: CLLocationDistance = mapValues.initialUserLocationBoundsMeters
            withAnimation {
                position = .region(.init(center: item.placemark.coordinate, latitudinalMeters: boundsMeters, longitudinalMeters: boundsMeters))
            }
        }
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func setIsSearching(_ boolean: Bool)  {
        isSearching = boolean
    }
    
    private func cancelSearchQueryTask() {
        searchQueryTask?.cancel()
        searchQueryTask = nil
    }
    
    private func resetSearchText() {
        searchText = ""
    }
    
    private func setSearchResults(_ value: [MKMapItem]?) {
        searchResults = value
    }
    
    private func resetSearchResults() {
        setSearchResults(nil)
        setIsSearching(false)
    }
}
