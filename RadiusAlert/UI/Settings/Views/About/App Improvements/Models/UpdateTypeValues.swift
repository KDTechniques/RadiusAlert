//
//  UpdateTypeValues.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-09.
//

import Foundation

struct UpdateTypeValues: Identifiable {
    let id: UUID = .init()
    let emoji: String
    let description: String
    
    static let whatsNew: [Self] = [
        .init(emoji: "➕", description: "Add multiple stops"),
        .init(emoji: "🔍", description: "Recent location searches for faster access"),
        .init(emoji: "🙊", description: "Text-to-Speech for your set destinations in the popup"),
        .init(emoji: "📍", description: "Saved pins for quick access to frequent stops"),
        .init(emoji: "🎚️", description: "After the selected duration, the alert tone automatically fades to 50% of the iPhone’s volume"),
        .init(emoji: "🌍", description: "Location-based search filtering (results relevant to your region only)")
    ]
    
    static let futureUpdates: [Self] = [
        .init(emoji: "📖", description: "Past activity history"),
        .init(emoji: "📊", description: "SwiftUI Charts to track daily routines and trips"),
        .init(emoji: "🤖", description: "Automation for trip tracking and smart notifications"),
        .init(emoji: "⏱️", description: "Trip waiting time tracking with history"),
        .init(emoji: "📜", description: "Activity History with basic details."),
        .init(emoji: "👨‍👩‍👧‍👦", description: "Real-time location tracking for loved ones"),
        .init(emoji: "🎵", description: "Option to pick from pre-packaged tones"),
    ]
}
