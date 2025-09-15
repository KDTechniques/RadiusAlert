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
    @State private var settingsVM: SettingsViewModel
    @State private var mapVM: MapViewModel
    
    init() {
        let settingsVM: SettingsViewModel =  .init()
        self.settingsVM = settingsVM
        
        let mapVM: MapViewModel = .init(settingsVM: settingsVM)
        self.mapVM = mapVM
    }
    
    // MARK: - BODY
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(settingsVM)
                .environment(mapVM)
                .preferredColorScheme(settingsVM.selectedColorScheme?.colorScheme)
                .dynamicTypeSize(.xSmall ... .large)
        }
    }
}
