//
//  RecentsModel.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-22.
//

import Foundation

struct RecentsModel: Identifiable, Codable {
    var id: String = UUID().uuidString
    let title: String
    
    static var mock: [Self] {
        return [
            .init(title: "Pettah Market"),
            .init(title: "Katunayake Highway Exit"),
            .init(title: "OneMac")
        ]
    }
}
