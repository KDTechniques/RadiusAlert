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
    private let locationManager: LocationManager = .shared
    private let resultListingAnimationDuration: Double = 0.3
    private let errorModel: LocationSearchManagerErrorModel.Type = LocationSearchManagerErrorModel.self
    private(set) var results: [LocationSearchModel] = []
    private(set) var isSearching: Bool = false
    
    // MARK: - INITIALIZER
    override init() {
        super.init()
        completer.delegate = self
        completer.resultTypes = .pointOfInterest
    }
    
    // MARK: - PUBLIC FUNCTIONS
    
    /// Updates the search query for the completer.
    /// - Parameter query: The text input from the user.
    func setQueryText(searchText query: String) {
        completer.queryFragment = query
    }
    
    /// Converts a search completion result into a `MKMapItem`.
    /// - Parameter completion: The selected search completion.
    /// - Returns: The first matching `MKMapItem`, or `nil` if no results found.
    func getMKMapItem(for completion: MKLocalSearchCompletion) async throws -> MKMapItem? {
        let request = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: request)
        let response = try await search.start()
        return response.mapItems.first
    }
    
    func clearResults() {
        completer.cancel()
        results = []
    }
    
    func setIsSearching(_ value: Bool) {
        isSearching = value
    }
    
    // MARK: - DELEGATE  FUNCTIONS
    
    /// Delegate method triggered when the search completer updates its results.
    /// - We map `MKLocalSearchCompletion` into our custom `LocationSearchModel`
    ///   because `MKLocalSearchCompletion` itself does not conform to `Identifiable`.
    /// - By conforming to `Identifiable`, SwiftUI can efficiently animate
    ///   the search result rows as the user types.
    /// - Updates the `results` array with a smooth animation.
    /// - After the animation duration, sets `isSearching` back to `false`.
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        // Convert search completions into our custom `LocationSearchModel`
        let tempArray: [MKLocalSearchCompletion] = completer.results
        var filteredByRegionResults: [MKLocalSearchCompletion] = []
        
        if let country: String = locationManager.currentRegionName {
            filteredByRegionResults = tempArray.filter({ $0.subtitle.contains(country) })
        } else {
            filteredByRegionResults = tempArray
        }
        
        let mappedResults: [LocationSearchModel] = filteredByRegionResults.compactMap({ LocationSearchModel(result: $0) })
        
        // Animate the results update in the UI
        withAnimation(.smooth(duration: resultListingAnimationDuration)) {
            results = mappedResults
        } completion: { [weak self] in
            self?.setIsSearching(false)
        }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        isNetworkFailureError(error) ? clearResults() : ()
        setIsSearching(false)
        Utilities.log(errorModel.failedMKLocalSearchCompleter(error).errorDescription)
    }
    
    private func isNetworkFailureError(_ error: Error) -> Bool {
        // First, try to cast the error to NSError to access error codes
        let nsError = error as NSError
        
        // Check if it's a network-related timeout
        return nsError.domain == NSURLErrorDomain && nsError.code == NSURLErrorTimedOut
    }
}
