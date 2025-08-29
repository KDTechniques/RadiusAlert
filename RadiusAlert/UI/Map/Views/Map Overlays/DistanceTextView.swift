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
        if
            let markerCoordinate: CLLocationCoordinate2D = mapVM.markerCoordinate,
            let userLocation: CLLocationCoordinate2D = mapVM.locationManager.currentUserLocation {
            
            let distance: CLLocationDistance = Utilities
                .getDistance(from: markerCoordinate, to: userLocation)
            
            Content(distance)
        }
    }
}

// MARK: - PREVIEWS
#Preview("Distance Text") {
    Content(300)
        .previewModifier()
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
            .animation(.default, value: distance)
            .contentTransition(.numericText(countsDown: true))
            .foregroundStyle(Color(uiColor: colorScheme == .dark ? .white : .darkGray))
            .font(.caption)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding(.trailing, 10)
            .padding(.bottom, 8)
    }
}
