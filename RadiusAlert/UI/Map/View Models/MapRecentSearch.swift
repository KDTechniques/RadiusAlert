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
    
    func fetchNAssignRecentSearches() {
        Task {
            let fetchedRecentSearches: [RecentSearchModel]? = try? await recentSearchManager.fetchRecentSearches()
            setRecentSearches(fetchedRecentSearches ?? [])
        }
    }
}
