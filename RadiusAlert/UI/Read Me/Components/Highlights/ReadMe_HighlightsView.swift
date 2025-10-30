//
//  ReadMe_HighlightsView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-09-13.
//

import SwiftUI

struct ReadMe_HighlightsView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    let values: ReadMe_Highlights_ImageResourceValues
    let animate: Bool
    
    // MARK: - ASSIGNED PROPERTIES
    let screenWidth: CGFloat = UIScreen.main.bounds.width
    
    // MARK: - INITIALIZER
    init(hPadding: CGFloat, animate: Bool) {
        values = ReadMe_Highlights_ImageResourceValues(hPadding: hPadding)
        self.animate = animate
    }
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: 0) {
            ForEach(ReadMe_Highlights_ImageResourceTypes.allCases, id: \.self) { type in
                type.imageResource(colorScheme)
                    .resizable()
                    .scaledToFit()
                    .frame(width: type.width(values))
                    .offset(x: animate ? type.secondaryOffsetX(values) : type.initialOffsetX(values))
                    .zIndex(type.zIndex)
                    .animation(.smooth(duration: 1), value: animate)
            }
        }
        .frame(maxWidth: screenWidth)
        .padding(.vertical, 20)
    }
}

// MARK: - PREVIEWS
#Preview("ReadMe_HighlightsView") {
    @Previewable @State var animate: Bool = false
    
    ReadMe_HighlightsView(hPadding: 20, animate: animate)
        .onAppear {
            animate.toggle()
        }
        .previewModifier()
}
