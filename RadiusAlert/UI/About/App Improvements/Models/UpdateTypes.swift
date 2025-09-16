//
//  UpdateTypes.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-19.
//

import Foundation

struct UpdateTypes: Identifiable {
    let id: UUID = .init()
    let emoji: String
    let description: String
    
    static let whatsNew: [String] = [
        
    ]
    
    static let futureUpdates: [Self] = [
        .init(emoji: "🌍", description: "Location-based search filtering (results relevant to your region only)"),
        .init(emoji: "📍", description: "Saved pins for quick access to frequent stops"),
        .init(emoji: "🗺️", description: "Smarter map handling with static snapshots to save memory"),
        .init(emoji: "➕", description: "Add multiple stops and view distances between them"),
        .init(emoji: "🔍", description: "Improved search bar with suggestions before results"),
        .init(emoji: "⚡", description: "Optimized background performance"),
        .init(emoji: "📖", description: "Past activity history"),
        .init(emoji: "📊", description: "SwiftUI Charts to track daily routines and trips"),
        .init(emoji: "🤖", description: "Automation for trip tracking and smart notifications"),
        .init(emoji: "👨‍👩‍👧‍👦", description: "Real-time location tracking for loved ones"),
        .init(emoji: "✍️", description: "Quick feedback provider for easy suggestions"),
        .init(emoji: "🎵", description: "Option to pick from pre-packaged tones"),
        .init(emoji: "🧠", description: "AI-powered journey insights and smart route suggestions"),
        .init(emoji: "⏱️", description: "Trip waiting time tracking with history"),
        .init(emoji: "📜", description: "Activity History with basic details.")
    ]
}
