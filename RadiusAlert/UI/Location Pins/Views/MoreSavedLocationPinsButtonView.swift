//
//  MoreSavedLocationPinsButtonView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-03.
//

import SwiftUI

struct MoreSavedLocationPinsButtonView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(LocationPinsViewModel.self) private var savedPinsVM
    @Environment(\.colorScheme) private var colorScheme
    let type: MapTypes
    
    // MARK: - INITIAILIZER
    init(type: MapTypes) {
        self.type = type
    }
    
    // MARK: - BODY
    var body: some View {
        Button {
            savedPinsVM.setIsPresentedSavedLocationsSheet(true)
        } label: {
            Group {
                if #available(iOS 26.0, *) {
                    let size: CGFloat? = savedPinsVM.horizontalPinButtonsHeight
                    
                    Image(systemName: "ellipsis")
                        .foregroundStyle(.primary)
                        .frame(width: size, height: size)
                        .savedLocationPinButtonBackgroundViewModifier(type: type)
                        .clipShape(.circle)
                        .savedLocationPinButtonGlassEffect(type: type, colorScheme: colorScheme)
                } else {
                    Label("More", systemImage: "ellipsis")
                        .foregroundStyle(Color.accentColor)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                        .savedLocationPinButtonBackgroundViewModifier(type: type)
                        .clipShape(.capsule)
                        .savedLocationPinButtonGlassEffect(type: type, colorScheme: colorScheme)
                }
            }
            .font(.subheadline)
        }
        .buttonStyle(.plain)
        .sheet(isPresented: savedPinsVM.isPresentedSavedLocationsSheetBinding()) {
            LocationPinsListView()
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
                .presentationBackground(Color.init(uiColor: .systemGray6))
        }
    }
}

// MARK: - PREVIEWS
#Preview("MoreSavedLocationPinsButtonView") {
    @Previewable @State var savedPinsVM: LocationPinsViewModel = .init(mapVM: .init(settingsVM: .init()))
    
    MoreSavedLocationPinsButtonView(type: .random())
        .environment(savedPinsVM)
        .onAppear {
            savedPinsVM.setHorizontalPinButtonsHeight(40)
        }
        .previewModifier()
}
