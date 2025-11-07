//
//  AddLocationPinSheetContentView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-05.
//

import SwiftUI
import CoreLocation

struct AddLocationPinSheetContentView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(LocationPinsViewModel.self) private var locationPinsVM
    @Environment(MapViewModel.self) private var mapVM
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            Form {
                textField
                slider
            }
            .scrollDisabled(true)
            .navigationTitle(.init("Pin a New Location"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) { saveButton }
            }
        }
    }
}

// MARK: - PREVIEWS
#Preview("AddLocationPinSheetContentView") {
    AddLocationPinSheetContentView()
        .previewModifier()
}

// MARK: - EXTENSIONS
extension AddLocationPinSheetContentView {
    private var textField: some View {
        Section {
            TextField("", text: locationPinsVM.newLocationPinTextFieldTextBinding(), prompt: .init("Title"))
        } footer: {
            Text("This title appears as a button under the search bar. You may use emojis for easier identification, e.g. 💼 Work.")
        }
    }
    
    private var slider: some View {
        Section {
            Slider(
                value: locationPinsVM.newLocationPinRadiusBinding(),
                in: MapValues.minimumRadius...MapValues.maximumRadius,
                step: 100) { } minimumValueLabel: {
                    Text(MapValues.minimumRadiusString)
                } maximumValueLabel: {
                    Text(MapValues.maximumRadiusString)
                }
        } header: {
            Text("Radius: \(mapVM.getRadiusTextString(locationPinsVM.newLocationPinRadius, withAlertRadiusText: false))")
                .padding(.top)
        }
        .listRowBackground(Color.clear)
    }
    
    private var saveButton: some View {
        Button {
            Task {
                locationPinsVM.setCreateNewLocationPinState(.inProgress)
                
                do {
                    try await locationPinsVM.createNewLocationPin()
                } catch {
                    locationPinsVM.setCreateNewLocationPinState(.failed)
                }
                
                locationPinsVM.setCreateNewLocationPinState(.success)
                
                try? await Task.sleep(nanoseconds: 500_000_000)
                locationPinsVM.setIsPresentedLocationSavingSheet(false)
            }
        } label: {
            buttonLabelOnStateChange
        }
        .disabled(locationPinsVM.newLocationPinTextFieldText.isEmpty)
    }
    
    @ViewBuilder
    private var buttonLabelOnStateChange: some View {
        switch locationPinsVM.createNewLocationPinState {
        case .none:
            Text("Save")
            
        case .inProgress:
            Image(systemName: "progress.indicator")
                .symbolEffect(.variableColor.iterative.dimInactiveLayers)
                .font(.footnote.weight(.semibold))
            
        case .success:
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.green.gradient)
            
        case .failed:
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundStyle(.yellow)
        }
    }
}
