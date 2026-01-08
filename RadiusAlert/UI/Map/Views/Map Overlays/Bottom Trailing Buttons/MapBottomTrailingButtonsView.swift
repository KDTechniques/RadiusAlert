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
            AddPinOrAddMultipleStopsMapBottomTrailingButtonView()
            MapStyleButtonView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity,  alignment: .bottomTrailing)
        .padding(.bottom, 40)
        .trailingPadding
    }
}

// MARK: - PREVIEWS
#Preview("MapBottomTrailingButtonsView") {
    MapBottomTrailingButtonsView()
        .previewModifier()
}

// MARK: - EXTENSIONS
fileprivate extension View {
    var trailingPadding: some View {
        if #available(iOS 26.0, *) {
            self
                .padding(.trailing)
        } else {
            self
                .padding(.trailing, 5)
        }
    }
}
