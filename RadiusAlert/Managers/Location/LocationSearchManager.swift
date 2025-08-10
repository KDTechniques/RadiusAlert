//
//  LocationSearchManager.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-10.
//

import MapKit

@Observable
final class LocationSearchManager: NSObject, MKLocalSearchCompleterDelegate {
    // MARK: - ASSIGNED PROPERTIES
    private let completer = MKLocalSearchCompleter()
    private(set) var results: [MKLocalSearchCompletion] = []
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
        results = completer.results
        isSearching = false
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // we can show an alert here, if needed...
        print("Completer error:", error.localizedDescription)
    }
}
