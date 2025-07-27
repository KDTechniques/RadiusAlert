//
//  RadiusAlertApp.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-07-27.
//

import SwiftUI

@main
struct RadiusAlertApp: App {
    // MARK: - PROPERTIES
    @StateObject private var contentVM: ContentViewModel = .init()
    
    // MARK: - BODY
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(contentVM)
        }
    }
}
