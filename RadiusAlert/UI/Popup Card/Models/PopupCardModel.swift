//
//  PopupCardModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-09.
//

import Foundation

struct PopupCardModel: Identifiable {
    var id: PopupCardDetailTypes { self.type }
    let type: PopupCardDetailTypes
    let value: String
    
    static let mockValues: [Self] = [
        .init(type: .radius, value: "700m"),
        .init(type: .duration, value: "43 min."),
        .init(type: .distance, value: "34km")
    ]
}

