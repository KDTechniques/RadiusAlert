//
//  MapStyleButtonView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-08-03.
//

import SwiftUI

struct MapStyleButtonView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(SettingsViewModel.self) private var settingsVM
    @Environment(MapViewModel.self) private var mapVM
    
    // MARK: - BODY
    var body: some View {
        if settingsVM.showMapStyleButton {
            MapOverlayButtonView(systemImage: settingsVM.selectedMapStyle.mapStyleSystemImageName) {
                mapVM.setNextMapStyle()
                settingsVM.invalidateMapStyleButtonTip()
            }
            .popoverTip(settingsVM.mapStyleButtonTip)
        }
    }
}

// MARK: - PREVIEWS
#Preview("MapStyleButtonView") {
    MapStyleButtonView()
        .previewModifier()
}

#Preview("ContentView") {
    ContentView()
        .previewModifier()
}
