//
//  AlertViewLevels.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2026-02-01.
//

import Foundation

/// As the app maintains a single alert listener, it needs to know where to present alerts.
/// Defines the view hierarchy levels where alerts can be presented.
///
/// When requesting an alert from the alert manager, both the target view level
/// and the specific alert must be identified. Any view that requires its own
/// alert presentation context should be declared here.
///
/// Helps ensure alerts are presented in the correct UI layer consistently.
enum AlertViewLevels {
    case content
    case multipleStopsMapSheet
    case multipleStopsCancellationSheet
    case editRadiusSheet
}
