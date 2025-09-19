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
    @Environment(MapViewModel.self) private var mapVM
    
    // MARK: - BODY
    var body: some View {
        if let markerCoordinate: CLLocationCoordinate2D = mapVM.markerCoordinate,
           let userLocation: CLLocationCoordinate2D = mapVM.locationManager.currentUserLocation {
            Content(getDistanceToRadius(from: markerCoordinate, and: userLocation))
        }
    }
}

// MARK: - PREVIEWS
#Preview("Distance Text") {
    Color.yellow
        .overlay {
            Content(300)
        }
        .previewModifier()
}

// MARK: - EXTENSIONS
extension DistanceTextView  {
    private func getDistanceToRadius(
        from coordinate1: CLLocationCoordinate2D,
        and coordinate2: CLLocationCoordinate2D) -> CLLocationDistance {
            let distance: CLLocationDistance = Utilities
                .getDistance(from: coordinate1, to: coordinate2)
            let distanceToRadius: CLLocationDistance = distance - mapVM.selectedRadius
            
            return distanceToRadius
        }
}

// MARK: - SUB VIEWS
fileprivate struct Content:  View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(MapViewModel.self) private var mapVM
    let distance: CLLocationDistance
    
    init(_ distance: CLLocationDistance) {
        self.distance = distance
    }
    
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
