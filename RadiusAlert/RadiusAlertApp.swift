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
    @State private var contentVM: ContentViewModel
    let locationManager: LocationManager
    
    init() {
        let locationManagerInstance: LocationManager = .init()
        locationManager = locationManagerInstance
        
        contentVM = .init(locationManager: locationManagerInstance)
    }
    
    
    // MARK: - BODY
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(contentVM)
        }
    }
}
