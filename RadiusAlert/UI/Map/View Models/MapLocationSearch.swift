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
    func searchTextBinding() -> Binding<String> {
        Binding { [weak self] in
            self?.searchText ?? ""
        } set: { [weak self] in
            self?.setSearchText($0)
        }
    }
    
    func onSearchResultsListRowTap(_ item: MKLocalSearchCompletion) {
        isMarkerCoordinateNil()
        ? onSearchResultsListRowTap_WhenMarkerCoordinateIsNil(item: item)
        : stopAlertOnSearchResultListRowTapConfirmation(item)
    }
    
    func showSearchResultsList() -> Bool {
        let condition1: Bool = showSearchResults()
        let condition2: Bool = showNoSearchResultsText()
        
        return condition1 || condition2
    }
    
    func onSearchTextChange(_ text: String) {
        searchText.isEmpty ? onEmptySearchText() : locationSearchManager.update(searchText: text)
    }
    
    func onEmptySearchText() {
        resetSearchResults()
    }
    
    func setSelectedSearchResultCoordinate(_ item: MKLocalSearchCompletion) {
        setSelectedMapItem(item)
        resetSearchResults()
        resetSearchText()
        
        Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
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
    private func onSearchResultsListRowTap_WhenMarkerCoordinateIsNil(item: MKLocalSearchCompletion) {
        setSelectedSearchResultCoordinate(item)
        setSearchFieldFocused(false)
    }
    
    private func resetSearchText() {
        setSearchText("")
    }
    
    private func resetSearchResults() {
        locationSearchManager.clearResults()
    }
    
    private func handleLocationSearchFailure() {
        locationSearchManager.clearResults()
    }
    
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
