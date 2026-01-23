//
//  DistanceTextView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-29.
//

import SwiftUI
import CoreLocation

struct DistanceTextView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    @Environment(MapViewModel.self) private var mapVM
    let distance: CLLocationDistance
    
    // MARK: - INITIALIZER
    init(_ distance: CLLocationDistance) {
        self.distance = distance
    }
    
    // MARK: - BODY
    var body: some View {
        let distanceString: String = mapVM.getRadiusTextString(distance, withAlertRadiusText: false)
        
        Text("Distance: \(distanceString)")
            .fontDesign(.monospaced)
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundStyle(Color(uiColor: colorScheme == .dark ? .white : .darkGray))
            .shadow(
                color: .getNotPrimary(colorScheme: colorScheme),
                radius: 0.3,
                y: -0.5
            )
            .contentTransition(.numericText(countsDown: true))
            .animation(.default, value: distance)
    }
}

// MARK: - PREVIEWS
#Preview("DistanceTextView") {
    Color.yellow
        .overlay {
            DistanceTextView(300)
        }
        .previewModifier()
}
