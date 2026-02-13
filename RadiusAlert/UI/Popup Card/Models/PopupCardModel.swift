//
//  PopupCardModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-09.
//

import CoreLocation

struct PopupCardModel: Identifiable {
    var id: String { markerID }
    let markerID: String
    let typeNValue: [(type: PopupCardDetailTypes, value: String)]
    let locationTitle: String?
    
    static let mockValues: Self = .init(
        markerID: UUID().uuidString,
        typeNValue: [(.radius, "700m"), (.duration, "41 min."), (.distance, "37km")],
        locationTitle: "Pettah Market"
    )
}
