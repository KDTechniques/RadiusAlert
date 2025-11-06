//
//  UpdateLocationPinSheetContentView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-06.
//

import SwiftUI
import CoreLocation

struct UpdateLocationPinSheetContentView: View {
    @Environment(MapViewModel.self) private var mapVM
    @State var renameTitleText: String
    @State var radius: CLLocationDistance
    
    @FocusState var isFocused: Bool
    
    // MARK: - BODY
    var body: some View {
        Form {
            textfield
            slider
        }
        .scrollDisabled(true)
        .navigationTitle(.init("Update Pined Location"))
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: isFocused) {
            $1 ? renameTitleText = "" : ()
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    
                }
                .foregroundStyle(Color.accentColor)
            }
        }
    }
    
}

// MARK: - PREVIEWS
#Preview("UpdateLocationPinSheetContentView") {
    NavigationStack {
        UpdateLocationPinSheetContentView(renameTitleText: "💼 Work", radius: 1200)
    }
    .previewModifier()
}

// MARK: - EXTENSIONS
extension UpdateLocationPinSheetContentView {
    private var textfield: some View {
        Section {
            TextField("", text: $renameTitleText, prompt: .init("Title"))
                .focused($isFocused)
        }
    }
    
    private var slider: some View  {
        Section {
            Slider(
                value: $radius,
                in: MapValues.minimumRadius...MapValues.maximumRadius,
                step: 100) { } minimumValueLabel: {
                    Text(MapValues.minimumRadiusString)
                } maximumValueLabel: {
                    Text(MapValues.maximumRadiusString)
                }
        } header: {
            Text("Radius: \(mapVM.getRadiusTextString(radius, withAlertRadiusText: false))")
                .padding(.top)
        }
        .listRowBackground(Color.clear)
    }
}
