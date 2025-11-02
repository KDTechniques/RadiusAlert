//
//  MapStyleListRowView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-08-24.
//

import SwiftUI

struct MapStyleListRowView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(SettingsViewModel.self) private var settingsVM
    let style: MapStyleTypes
    
    // MARK: - INITIALIZER
    init(_ style: MapStyleTypes) {
        self.style = style
    }
    // MARK: - BODY
    var body: some View {
        let condition: Bool = settingsVM.selectedMapStyle == style
        
        Custom_RadioButtonListRowView(isSelected: condition) {
            Text(style.rawValue.capitalized)
                .tint(.primary)
        } action: {
            settingsVM.setSelectedMapStyle(style)
        }
    }
}

// MARK: - PREVIEWS
#Preview("MapStyleListRowView") {
    List {
        MapStyleListRowView(.random())
    }
    .previewModifier()
}
