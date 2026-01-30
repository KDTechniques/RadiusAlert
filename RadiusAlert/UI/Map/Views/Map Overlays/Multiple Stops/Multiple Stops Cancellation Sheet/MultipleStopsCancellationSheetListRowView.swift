//
//  MultipleStopsCancellationSheetListRowView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2026-01-30.
//

import SwiftUI

struct MultipleStopsCancellationSheetListRowView: View {
    // MARK: - INJECTED PROPERTIES
    let color: Color
    let title: String?
    let radius: String
    
    // MARK: - INITIALIZER
    init(color: Color, title: String?, radius: String) {
        self.color = color
        self.title = title
        self.radius = radius
    }
    
    // MARK: - ASSIGNED PROPERTIES
    let nilTitleText: String = "Unknown Location"
    
    // MARK: - BODY
    var body: some View {
        HStack {
            markerCircle(color: color)
            markerText(title: title ?? nilTitleText, radius: radius)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - PREVIEWS
#Preview("MultipleStopsCancellationSheetListRowView") {
    let mapVM: MapViewModel = .init(settingsVM: .init())
    let randomRadius: Double = Double.random(in: 700...3000)
    
    MultipleStopsCancellationSheetListRowView(
        color: .debug,
        title: UUID().uuidString,
        radius: mapVM.getRadiusTextString(randomRadius, withAlertRadiusText: false)
    )
    .padding(.horizontal)
    .previewModifier()
}

// MARK: - EXTENSIONS
extension MultipleStopsCancellationSheetListRowView {
    private func markerCircle(color: Color) -> some View {
        Circle()
            .fill(color.opacity(0.2))
            .frame(width: 60, height: 60)
            .overlay {
                Image(systemName: "mappin")
                    .foregroundStyle(.red)
            }
    }
    
    private func markerText(title: String, radius: String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .fontWeight(.medium)
            
            Text(radius)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}
