//
//  SpokenAlertModel.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-18.
//

import Foundation

struct SpokenAlertModel: Equatable, Codable {
    var userName: String
    var voice: String
    var speakingRate: CGFloat
    var pitchRate: CGFloat
    var isOnSpokenAlert: Bool
    
    static let initialValues: Self = .init(
        userName: "",
        voice: "Samantha",
        speakingRate: 0.5,
        pitchRate: 0.5,
        isOnSpokenAlert: false
    )
}
