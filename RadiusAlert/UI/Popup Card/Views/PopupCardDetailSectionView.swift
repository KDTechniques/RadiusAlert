//
//  PopupCardDetailSectionView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-09.
//

import SwiftUI

struct PopupCardDetailSectionView: View {
    // MARK: - INJECTED PROPERTIES
    let title: String
    let systemImageName: String
    let value: String
    let foregroundColor: Color
    
    // MARK: - INITIALIZER
    init(title: String, systemImageName: String, value: String, foregroundColor: Color = .primary) {
        self.title = title
        self.systemImageName = systemImageName
        self.value = value
        self.foregroundColor = foregroundColor
    }
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading) {
            Text(title.uppercased())
                .font(.caption2)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
            
            HStack(spacing: 5) {
                Image(systemName: systemImageName)
                
                Text(value)
                    .font(.footnote)
                    .bold()
                    .lineLimitDebugViewModifier
                    .minimumScaleFactor(0.8)
                
            }
            .foregroundStyle(foregroundColor)
        }
    }
}

// MARK: - PREVIEWS
#Preview("Popup Card Detail Section") {
    PopupCardDetailSectionView(
        title: "Radius",
        systemImageName: "circle.circle.fill",
        value: "700m",
        foregroundColor: .red
    )
    .previewModifier()
}

// MARK: - EXTENSIONS
fileprivate extension Text {
    @ViewBuilder
    var lineLimitDebugViewModifier: some View {
#if DEBUG
        self
            .lineLimit(3)
#else
        self
            .lineLimit(1)
#endif
    }
}
