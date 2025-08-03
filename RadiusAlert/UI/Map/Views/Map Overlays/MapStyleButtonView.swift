//
//  MapStyleButtonView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-08-03.
//

import SwiftUI

struct MapStyleButtonView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    
    // MARK: - BODY
    var body: some View {
        Button {
            mapVM.nextMapStyle()
        } label: {
            Image(systemName: mapVM.selectedMapStyle.mapStyleSystemImageName)
                .foregroundStyle(Color.accentColor)
        }
        .padding(11.5)
        .background(.mapControlButtonBackground, in: .rect(cornerRadius: 7))
        .frame(maxWidth: .infinity, maxHeight: .infinity,  alignment: .bottomTrailing)
        .padding(.trailing, 5)
        .padding(.bottom, 30)
        .buttonStyle(.plain)
    }
}

// MARK: - PREVIEWS
#Preview("Map Style Button View") {
    MapStyleButtonView()
        .previewModifier()
}
