//
//  HorizontalPinView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-03.
//

import SwiftUI

struct HorizontalPinView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(SavedPinsViewModel.self) private var savedPinsVM
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(PinModel.mock) {
                    PinButtonView(title: $0.getLabel(), action: { })
                }
                .onPreferenceChange(savedPinsVM)
                
                moreButton
            }
            .padding([.horizontal, .bottom])
            .padding(.top, 1)
        }
        .scrollIndicators(.never)
    }
}

// MARK: - PREVIEWS
#Preview("HorizontalPinView") {
    HorizontalPinView()
        .previewModifier()
}

// MARK: - EXTENSIONS
fileprivate extension View {
    func onPreferenceChange(_ savedPinsVM: SavedPinsViewModel) -> some View {
        self
            .background {
                GeometryReader { geo in
                    Color.clear
                        .preference(key: PinButtonPreferenceKey.self, value: geo.size.height)
                        .onPreferenceChange(PinButtonPreferenceKey.self) {
                            savedPinsVM.setHorizontalPinButtonsHeight($0)
                        }
                }
            }
    }
}

extension HorizontalPinView {
    private var moreButton: some View {
        Button {
            /// present the sheet here...
        } label: {
            if #available(iOS 26.0, *) {
                Image(systemName: "ellipsis")
                    .frame(width: savedPinsVM.horizontalPinButtonsHeight, height: savedPinsVM.horizontalPinButtonsHeight)
                    .background(.regularMaterial)
                    .clipShape(.circle)
                    .font(.subheadline)
                    .foregroundStyle(.primary)
                    .glassEffect()
            } else {
                Label("More", systemImage: "ellipsis")
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(.regularMaterial)
                    .clipShape(.capsule)
                    .font(.subheadline)
                    .foregroundStyle(.primary)
                    .overlay {
                        Capsule()
                            .strokeBorder(.primary.opacity(0.2), lineWidth: 0.6)
                    }
            }
        }
        .buttonStyle(.plain)
    }
}
