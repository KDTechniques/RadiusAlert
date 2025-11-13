//
//  RadiusAlertApp.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-07-27.
//

import SwiftUI
import TipKit

@main
struct RadiusAlertApp: App {
    // MARK: - PROPERTIES
    @State private var settingsVM: SettingsViewModel
    @State private var mapVM: MapViewModel
    @State private var locationPinsVM: LocationPinsViewModel
    
    init() {
        try? Tips.configure()
        
#if DEBUG
//        try? Tips.resetDatastore()
#endif
        
        let settingsVM: SettingsViewModel =  .init()
        self.settingsVM = settingsVM
        
        let mapVM: MapViewModel = .init(settingsVM: settingsVM)
        self.mapVM = mapVM
        
        let locationPinsVM: LocationPinsViewModel = .init(mapVM: mapVM)
        self.locationPinsVM = locationPinsVM
    }
    
    // MARK: - BODY
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(settingsVM)
                .environment(mapVM)
                .environment(locationPinsVM)
                .preferredColorScheme(settingsVM.selectedColorScheme?.colorScheme)
                .dynamicTypeSizeViewModifier
        }
    }
}
