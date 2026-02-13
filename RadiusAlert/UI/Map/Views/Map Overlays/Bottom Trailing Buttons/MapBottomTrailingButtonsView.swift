//
//  MapBottomTrailingButtonsView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-04.
//

import SwiftUI

struct MapBottomTrailingButtonsView: View {
    @Environment(LocationPinsViewModel.self) private var locationPinsVM
    @Environment(MapViewModel.self) private var mapVM
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 10) {
            AddPinOrAddMultipleStopsMapBottomTrailingButtonView(type: mapVM.getAddPinOrMultipleStopsType())
            MapStyleButtonView()
        }
        .mapBottomTrailingButtonsViewModifier
    }
}

// MARK: - PREVIEWS
#Preview("MapBottomTrailingButtonsView") {
    MapBottomTrailingButtonsView()
        .previewModifier()
}
