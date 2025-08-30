//
//  AppearanceListRowView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-08-24.
//

import SwiftUI

struct AppearanceListRowView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(SettingsViewModel.self) private var settingsVM
    let type: ColorSchemeTypes
    
    // MARK: - INITIALIZER
    init(_ type: ColorSchemeTypes) {
        self.type = type
    }
    
    // MARK: - BODY
    var body: some View {
        let condition: Bool = settingsVM.selectedColorScheme == type
        
        RadioButtonListRowView(isSelected: condition) {
            content(type)
        } action: {
            settingsVM.setColorScheme(type)
        }
    }
}

// MARK: - PREVIEWS
#Preview("Appearance List Row") {
    List {
        AppearanceListRowView(.allCases.randomElement()!)
    }
    .previewModifier()
}

// MARK: - EXTENSIONS
extension AppearanceListRowView {
    private func content(_ type: ColorSchemeTypes) -> some View {
        VStack(alignment: .leading) {
            Text(type.text)
                .tint(.primary)
            
            if let description: String = type.description {
                Text(description)
                    .font(.footnote)
                    .tint(.secondary)
            }
        }
    }
}

