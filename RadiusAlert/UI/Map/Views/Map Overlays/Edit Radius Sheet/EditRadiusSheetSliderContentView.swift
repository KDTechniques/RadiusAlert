//
//  EditRadiusSheetSliderContentView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2026-03-07.
//

import SwiftUI
import CoreLocation

struct EditRadiusSheetSliderContentView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    @Environment(\.dismiss) private var dismiss
    let marker: MarkerModel
    @State private var radius: CLLocationDistance
    
    // MARK: - INITIALIZER
    init(_ marker: MarkerModel) {
        self.marker = marker
        _radius = State(initialValue: marker.radius)
    }
    
    // MARK: - BODY
    var body: some View {
        Form {
            title
            slider
        }
        .scrollDisabled(true)
        .navigationTitle(.init("Edit Radius"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { ToolbarItem(placement: .confirmationAction) { doneButton } }
    }
}

#Preview("EditRadiusSheetSliderContentView") {
    NavigationStack {
        EditRadiusSheetSliderContentView(.mock.first!)
    }
    .previewModifier()
}

// MARK: - EXTENSIONS
extension EditRadiusSheetSliderContentView {
    private var title: some View {
        Text(marker.title ?? MapValues.nilTitleText)
            .fontWeight(.medium)
            .listRowBackground(Color.clear)
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
            Text("Radius: \(mapVM.getRadiusTextString(radius, title: nil, withAlertRadiusText: false))")
                .padding(.top)
        }
        .listRowBackground(Color.clear)
    }
    
    private func onUpdateDoneTap() {
        mapVM.OnEditingRadius(currentMarkerID: marker.id, newRadius: radius)
        dismiss()
    }
    
    private var doneButton: some View {
        Button("Done") {
            onUpdateDoneTap()
        }
        .foregroundStyle(isSameRadius() ? Color.secondary : Color.accentColor)
        .disabled(isSameRadius())
    }
    
    private func isSameRadius() -> Bool {
        return radius == marker.radius
    }
}
