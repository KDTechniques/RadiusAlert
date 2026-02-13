//
//  MapRadiusAlert.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2026-01-28.
//

import Foundation

extension MapViewModel {
    func getRadiusAlertItem(markerID: String) -> RadiusAlertModel? {
        return radiusAlertItems.first(where: { $0.markerID == markerID })
    }
}
