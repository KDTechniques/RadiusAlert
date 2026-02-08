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
    let number: Int?
    let title: String?
    let radius: String
    
    // MARK: - INITIALIZER
    init(color: Color, number: Int?, title: String?, radius: String) {
        self.color = color
        self.number = number
        self.title = title
        self.radius = radius
    }
    
    // MARK: - ASSIGNED PROPERTIES
    let nilTitleText: String = "Unknown Location"
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: 12) {
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
        number: Int.random(in: 0...10),
        title: "Unknown Location",
        radius: mapVM.getRadiusTextString(randomRadius, title: nil, withAlertRadiusText: false)
    )
    .padding(.horizontal)
    .previewModifier()
}

// MARK: - EXTENSIONS
extension MultipleStopsCancellationSheetListRowView {
    @ViewBuilder
    private func markerCircle(color: Color) -> some View {
        let size: CGFloat = 50
        
        Circle()
            .fill(color.opacity(0.2))
            .frame(width: size, height: size)
            .overlay {
                if let number {
                    Text("\(number)")
                        .bold()
                } else {
                    Image(systemName: "bell.and.waves.left.and.right.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.red)
                        .padding(12)
                }
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
