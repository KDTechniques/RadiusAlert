//
//  LocationSearchModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-16.
//

import MapKit

/// A model that represents a location search result from `MKLocalSearchCompletion`.
/// Conforms to `Identifiable` and `Equatable` for easy use in SwiftUI lists.
///
/// Example usage:
/// ```swift
/// let completion = MKLocalSearchCompletion()
/// completion.title = "Central Park"
/// completion.subtitle = "New York, NY"
///
/// let model = LocationSearchModel(result: completion)
/// print(model.title)    // "Central Park"
/// print(model.subtitle) // "New York, NY"
/// ```
struct LocationSearchModel: Identifiable,Equatable {
    let id: String
    let result: MKLocalSearchCompletion
    let title: String
    let subtitle: String
    
    init(result: MKLocalSearchCompletion) {
        self.id = result.title + (result.subtitle.isEmpty ? UUID().uuidString : result.subtitle)
        self.result = result
        title = result.title
        subtitle = result.subtitle
    }
}
