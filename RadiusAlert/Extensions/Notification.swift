//
//  Notification.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-09-24.
//

import Foundation

// Extension to `Tip` related notifications used throughout the app.
/// Provides notification names for tip actions to be observed.
/// When adding a new action to a tip model, define its notification name here
/// to keep all related notifications organized and consistent.
extension Notification.Name {
    static let radiusSliderTipDidTrigger = Notification.Name("radiusSliderTipDidTrigger")
    static let navigationTitleTipDidTrigger = Notification.Name("navigationTitleTipDidTrigger")
}
