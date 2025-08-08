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
    @State private var mapVM: MapViewModel = .init()
    
    init() { }
    
    // MARK: - BODY
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
                .environment(mapVM)
        }
    }
}
