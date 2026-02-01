//
//  MapControlButtonBackgroundView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2026-01-08.
//

import SwiftUI

struct MapControlButtonBackgroundView<T: View>: View {
    // MARK: - INJECTED PROPERTIES
    let size: CGSize
    let content: T
    
    // MARK: - INITIALIZER
    init(size: CGSize, @ViewBuilder _ content: () -> T) {
        self.size = size
        self.content = content()
    }
    
    // MARK: - BODY
    var body: some View {
        Group {
            if #available(iOS 26.0, *) {
                Circle()
                    .foregroundStyle(.primary.opacity(0.001))
                    .frame(width: size.width, height: size.height)
                    .overlay(content.clipped())
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(Color.custom.Map.mapControlButtonBackground.color)
                    .frame(width: size.width, height: size.height)
                    .shadow(color: .black.opacity(0.05), radius: 5, x: -1, y: 1)
                    .overlay(content.clipped())
            }
        }
    }
}

// MARK: - PREVIEWS
#Preview("MapControlButtonBackgroundView") {
    @Previewable @State var toggle: Bool = .random()
    
    MapControlButtonBackgroundView(size: .init(width: 44, height: 44)) {
        Group {
            if toggle {
                Image(systemName: "plus")
                    .frame(width: 44, height: 44)
                    .transition(.slide)
            } else {
                Image(systemName: "pin")
                    .frame(width: 44, height: 44)
                    .transition(.slide)
            }
        }
        .onTapGesture {
            withAnimation(.bouncy) {
                toggle.toggle()
            }
        }
    }
}
