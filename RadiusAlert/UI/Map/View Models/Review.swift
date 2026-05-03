//
//  Review.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2026-04-12.
//

import Foundation
import StoreKit

extension MapViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    /// Requests an in-app App Store review prompt.
    /// - Important: Only attempts the request if `canRequestAppleReview()` is true and a
    ///   foreground `UIWindowScene` is available. The request must be made on the main actor.
    func requestAppleReview() {
        // Ensure we are allowed to ask for a review and have an active foreground scene.
        guard canRequestAppleReview(),
              let scene = UIApplication.shared
            .connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else { return }
        
        // Perform the review request on the main actor as required by StoreKit.
        Task { @MainActor in
            AppStore.requestReview(in: scene)
        }
    }
    
    /// Presents the app's custom review sheet when eligible.
    /// - Note: Respects `canRequestCustomReview()` to avoid over-prompting users.
    func requestCustomReview() {
        // Only proceed when our own cooldown/eligibility rules allow.
        guard canRequestCustomReview() else { return }
        setIsPresentedCustomReviewSheet(true)
    }
    
    /// Increments the count of times the user started an alert.
    /// - Note: Skips incrementing while the Multiple Stops Map sheet is presented to
    ///   avoid inflating counts during that modal flow.
    func increaseStartAlertCount() {
        // Avoid counting while the Multiple Stops Map sheet is shown.
        guard !isPresentedMultipleStopsMapSheet else { return }
        userDefaultsManager.saveStartAlertCount()
    }
}

