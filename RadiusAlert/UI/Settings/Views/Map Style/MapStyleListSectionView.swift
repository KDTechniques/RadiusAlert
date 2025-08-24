//
//  MapStyleListSectionView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-24.
//

import SwiftUI

struct MapStyleListSectionView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(SettingsViewModel.self) private var settingsVM
    
    // MARK: - BODY
    var body: some View {
        mapStyles
        mapStyleButtonVisibility
    }
}

// MARK: - PREVIEWS
#Preview("Map Style Section") {
    NavigationStack {
        List {
            MapStyleListSectionView()
        }
    }
    .previewModifier()
}

// MARK: - EXTENSIONS
extension MapStyleListSectionView {
    private var mapStyles: some View {
        Section {
            ForEach(MapStyleTypes.allCases, id: \.self) {
                MapStyleListRowView($0)
            }
        } header: {
            Text("Map Styles")
        }
    }
    
    private var mapStyleButtonVisibility: some View {
        Section {
            Toggle("Hide Map Style Button", isOn: settingsVM.mapStyleButtonVisibilityBinding())
        }
    }
}
