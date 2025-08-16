//
//  LocationSearchManager.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-10.
//

import MapKit
import SwiftUI

@Observable
final class LocationSearchManager: NSObject, MKLocalSearchCompleterDelegate {
    // MARK: - ASSIGNED PROPERTIES
    private let completer = MKLocalSearchCompleter()
    private let resultListingAnimationDuration: Double = 0.3
    private(set) var results: [LocationSearchModel] = []
    private(set) var isSearching: Bool = false
    
    // MARK: - INITIALIZER
    override init() {
        super.init()
        completer.delegate = self
        completer.resultTypes = .pointOfInterest
    }
    
    // MARK: - PUBLIC FUNCTIONS
    func update(searchText query: String) {
        isSearching = true
        completer.queryFragment = query
    }
    
    func getMKMapItem(for completion: MKLocalSearchCompletion) async throws -> MKMapItem? {
        let request = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: request)
        let response = try await search.start()
        return response.mapItems.first
    }
    
    func clearResults() {
        results = []
    }
    
    // MARK: - DELEGATE  FUNCTIONS
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        var tempArray: [LocationSearchModel] = []
        
        for item in completer.results {
            tempArray.append(.init(result: item))
        }
        
        withAnimation(.smooth(duration: resultListingAnimationDuration)) {
            results.sync(with: tempArray)
        }
        
        Task {
            try? await Task.sleep(nanoseconds: UInt64(resultListingAnimationDuration))
            isSearching = false
        }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // we can show an alert here, if needed...
        print("Completer error:", error.localizedDescription)
    }
}

extension Array where Element: Equatable {
    mutating func sync(with other: [Element]) {
        // 1. Remove items that are not in `other`
        self.removeAll { !other.contains($0) }
        
        // 2. Add items that are missing from `self`
        for item in other where !self.contains(item) {
            self.append(item)
        }
    }
}
