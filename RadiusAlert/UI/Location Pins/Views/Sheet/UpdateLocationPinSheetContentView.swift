//
//  UpdateLocationPinSheetContentView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-06.
//

import SwiftUI
import CoreLocation

struct UpdateLocationPinSheetContentView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    @Environment(LocationPinsViewModel.self) private var locationPinsVM
    @Environment(\.dismiss) private var dismiss
    
    let item: LocationPinsModel
    @State private var renameText: String
    @State private var radius: CLLocationDistance
    
    // MARK: - INITIALIZER
    init(_ item: LocationPinsModel) {
        self.item = item
        _renameText = State(initialValue: item.title)
        _radius = State(initialValue: item.radius)
    }
    
    // MARK: - ASSIGNED PROPERTIES
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
        .toolbar { ToolbarItem(placement: .confirmationAction) { doneButton } }
    }
}

// MARK: - PREVIEWS
#Preview("UpdateLocationPinSheetContentView") {
    NavigationStack {
        UpdateLocationPinSheetContentView(.mock.first!)
    }
    .previewModifier()
}

// MARK: - EXTENSIONS
extension UpdateLocationPinSheetContentView {
    private var textfield: some View {
        Section {
            TextField("", text: $renameText, prompt: .init("Title"))
                .limitInputLength(
                    $renameText,
                    to: locationPinsVM.locationPinTitleMaxCharacterCount
                )
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
    
    private func onUpdateDoneTap() {
        Task {
            await locationPinsVM.onLocationPinUpdateDoneButtonAction(
                item,
                title: renameText,
                radius: radius
            )
            
            dismiss()
        }
    }
    
    private var doneButton: some View {
        Button("Done") {
            onUpdateDoneTap()
        }
        .foregroundStyle(Color.accentColor)
        .disabled(renameText.isEmpty)
    }
}
