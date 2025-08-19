//
//  AppearanceListSectionView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-19.
//

import SwiftUI

struct AppearanceListSectionView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(SettingsViewModel.self) private var settingsVM
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - BODY
    var body: some View {
        List {
            Section {
                ForEach(ColorSchemeTypes.allCases, id: \.self) { type in
                    Button { settingsVM.setColorScheme(type) } label: { listRow(type) }
                        .buttonStyle(.plain)
                }
            } header: {
                Text("Dark Mode")
            }
        }
    }
}

// MARK: - PREVIEWS
#Preview("Appearance List Section") {
    AppearanceListSectionView()
        .previewModifier()
}

// MARK: - EXTENSIONS
extension AppearanceListSectionView {
    @ViewBuilder
    private func radioButton(_ type: ColorSchemeTypes) -> some View {
        let imageCondition: Bool =  settingsVM.selectedColorScheme == type
        let imageName: String = imageCondition ? "inset.filled.circle" : "circle"
        
        Image(systemName: imageName)
            .foregroundStyle(Color.accentColor)
    }
    
    private func labelNDescription(_ type: ColorSchemeTypes) -> some View {
        VStack(alignment: .leading) {
            Text(type.text)
            
            if let description: String = type.description {
                Text(description)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    private func listRow(_ type: ColorSchemeTypes) -> some View {
        HStack {
            labelNDescription(type)
            Spacer()
            radioButton(type)
        }
        .background(Color.getNotPrimary(colorScheme: colorScheme).opacity(0.001))
    }
}
