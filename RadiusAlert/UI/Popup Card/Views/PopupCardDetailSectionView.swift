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
            heading
            label
        }
    }
}

// MARK: - PREVIEWS
#Preview("PopupCardDetailSectionView") {
    PopupCardDetailSectionView(
        title: "Radius",
        systemImageName: "circle.circle.fill",
        value: "700m",
        foregroundColor: .red
    )
    .previewModifier()
}

// MARK: - EXTENSIONS
extension PopupCardDetailSectionView {
    private var heading: some View {
        Text(title.uppercased())
            .font(.caption2)
            .fontWeight(.semibold)
            .foregroundStyle(.secondary)
    }
    
    private var label: some View {
        HStack(spacing: 5) {
            Image(systemName: systemImageName)
            
            Text(value)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .font(.footnote)
        .foregroundStyle(foregroundColor)
    }
}
