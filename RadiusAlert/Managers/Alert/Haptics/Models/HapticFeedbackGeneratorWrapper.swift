//
//  HapticFeedbackGeneratorWrapper.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-17.
//

import UIKit

struct HapticFeedbackGeneratorWrapper {
    private let generator = UINotificationFeedbackGenerator()
    
    /// Triggers a notification haptic feedback.
    func notificationOccurred(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
    
    /// Triggers an impact haptic feedback with the specified style.
    func impactOccurred(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
}
