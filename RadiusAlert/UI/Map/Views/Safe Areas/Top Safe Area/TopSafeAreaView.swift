//
//  TopSafeAreaView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-27.
//

import SwiftUI

struct TopSafeAreaView: View {
    // MARK: - INNJECTED PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    @Environment(MapViewModel.self) private var mapVM
    @Environment(LocationPinsViewModel.self) private var locationPinsVM
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 0) {
            SearchBarSwiftUIView()
            horizontalLocationPins
            divider
        }
        .background(MapValues.safeAreaBackgroundColor(colorScheme))
    }
}

// MARK: - PREVIEWS
#Preview("TopSafeAreaView") {
    NavigationStack {
        VStack {
            TopSafeAreaView()
            Spacer()
        }
    }
    .previewModifier()
}

// MARK: - EXTENSIONS
extension TopSafeAreaView {
    @ViewBuilder
    private var horizontalLocationPins: some View {
        if locationPinsVM.showScrollableHorizontalLocationPins() {
            HorizontalLocationPinsView(type: .primary)
        }
    }
    
    private var divider: some View {
        Divider()
            .opacity(mapVM.showTopSafeAreaDivider() ? 1 : 0)
            .overlay {
                GeometryReader { geo in
                    Color.clear
                        .preference(key: DividerMaxYPreferenceKey.self, value: geo.frame(in: .global).maxY)
                }
                .onPreferenceChange(DividerMaxYPreferenceKey.self) { maxY in
                    let height: CGFloat = Utilities.screenHeight - maxY
                    mapVM.setSearchResultBackgroundHeight(height)
                }
            }
    }
}

private struct DividerMaxYPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
