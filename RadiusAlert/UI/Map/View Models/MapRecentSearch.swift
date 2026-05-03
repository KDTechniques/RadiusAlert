//
//  MapRecentSearch.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-29.
//

import MapKit

// MARK: RECENT SEARCH

extension MapViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    /// Creates and saves a recent search item from a search suggestion that conforms to `MKLocalSearchCompletion`.
    ///
    /// Converts a search completion result into a `MKMapItem`, and fetches map item to get coordinates, then stores it in the local database.
    func createRecentSearch(on item: MKLocalSearchCompletion) {
        Task {
            guard let mapItem: MKMapItem = try? await locationSearchManager.getMKMapItem(for: item) else { return }
            
            let newItem: RecentSearchModel = .init(
                title: item.title,
                subtitle: item.subtitle,
                coordinate: mapItem.coordinate
            )
            
            try? await recentSearchManager.addRecentSearch(newItem)
            fetchNAssignRecentSearches()
        }
    }
    
    /// Fetches recent searches and assigns them to the UI state.
    func fetchNAssignRecentSearches() {
        Task {
            let fetchedRecentSearches: [RecentSearchModel]? = try? await recentSearchManager.fetchRecentSearches()
            setRecentSearches(fetchedRecentSearches ?? [])
        }
    }
}
