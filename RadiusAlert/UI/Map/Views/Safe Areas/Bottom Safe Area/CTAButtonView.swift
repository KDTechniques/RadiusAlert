//
//  CTAButtonView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-27.
//

import SwiftUI

struct CTAButtonView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    
    // MARK: - BODY
    var body: some View {
        Button {
            mapVM.triggerCTAButtonAction()
        } label: {
            Text(mapVM.isMarkerCoordinateNil() ? "Alert Me Here" : "Stop Alert")
                .fontWeight(.semibold)
                .foregroundStyle(mapVM.getCTAButtonForegroundColor())
                .padding(.vertical)
                .frame(width: Utilities.screenWidth * 0.7)
                .buttonBackgroundViewModifier(mapVM)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 20)
    }
}

// MARK: - PREVIEWS
#Preview("Call to Action Button View") {
    CTAButtonView()
        .previewModifier()
}

// MARK: - EXTENSIONS
fileprivate extension View {
    @ViewBuilder
    func buttonBackgroundViewModifier(_ vm: MapViewModel) -> some View {
        if #available(iOS 26.0, *) {
            self
                .glassEffect(.regular.tint(vm.getCTAButtonBackgroundColor()), in: .capsule)
        } else {
            self
                .background(vm.getCTAButtonBackgroundColor(), in: .rect(cornerRadius: 12))
        }
    }
}
