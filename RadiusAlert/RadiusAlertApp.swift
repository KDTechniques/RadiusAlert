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
    @State private var locationManager: LocationManager
    @State private var contentVM: ContentViewModel
    
    // MARK: - INITIALIZER
    init() {
        let locationManagerInstance: LocationManager = .init()
        locationManager = locationManagerInstance
        
        contentVM = .init(locationManager: locationManagerInstance)
    }
    
    // MARK: - BODY
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(locationManager)
                .environment(contentVM)
        }
    }
}
