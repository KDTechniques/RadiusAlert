//
//  View+EXT.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-27.
//

import SwiftUI

extension View {
    func previewModifier() ->  some View {
        self
            .environment(LocationManager())
            .environment(ContentViewModel(locationManager: .init()))
            .environment(MapViewModel(locationManager: .init()))
    }
}
