//
//  AddLocationPinSheetContentView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-05.
//

import SwiftUI
import CoreLocation

struct AddLocationPinSheetContentView: View {
    @Environment(LocationPinsViewModel.self) private var savedPinsVM
    @State var titleText: String = ""
    @State var radius: CLLocationDistance = MapValues.minimumRadius
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("", text: $titleText, prompt: .init("Title"))
                } footer: {
                    Text("This title appears as a button under the search bar. You may use emojis for easier identification, e.g. 💼 Work.")
                }
                
                Section {
                    Slider(
                        value: $radius,
                        in: MapValues.minimumRadius...MapValues.maximumRadius,
                        step: 100) { } minimumValueLabel: {
                            Text("700m")
                        } maximumValueLabel: {
                            Text("3km")
                        }
                } header: {
                    Text("Radius: \(radius.int())m")
                        .padding(.top)
                }
                .listRowBackground(Color.clear)
            }
            .scrollDisabled(true)
            .navigationTitle(.init("Pin a New Location"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        // action goes here...
                    }
                    .disabled(titleText.isEmpty)
                    
                    //                        Image(systemName: "checkmark.circle.fill")
                    //                            .foregroundStyle(.green.gradient)
                    
                    //                        Image(systemName: "progress.indicator")
                    //                            .symbolEffect(.variableColor.iterative.dimInactiveLayers)
                    //                            .font(.footnote.weight(.semibold))
                    //
                }
            }
        }
        
    }
}

// MARK: - PREVIEWS
#Preview("AddLocationPinSheetContentView") {
    AddLocationPinSheetContentView()
        .previewModifier()
}
