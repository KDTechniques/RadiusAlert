//
//  LocationSearchModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-16.
//

import MapKit

struct LocationSearchModel: Identifiable,Equatable {
    let id: String
    let result: MKLocalSearchCompletion
    let title: String
    let subtitle: String
    
    init(result: MKLocalSearchCompletion) {
        self.id = result.title + result.subtitle
        self.result = result
        title = result.title
        subtitle = result.subtitle
    }
}
