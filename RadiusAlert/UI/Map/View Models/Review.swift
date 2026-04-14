//
//  Review.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2026-04-12.
//

import Foundation
import StoreKit

extension MapViewModel {
    func requestAppleReview() {
        guard canRequestAppleReview(),
              let scene = UIApplication.shared
            .connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else { return }
        
        Task { @MainActor in
            AppStore.requestReview(in: scene)
        }
    }
    
    func requestCustomReview() {
        guard canRequestCustomReview() else { return }
        setIsPresentedCustomReviewSheet(true)
    }
    
    func increaseStartAlertCount() {
        guard !isPresentedMultipleStopsMapSheet else { return }
        userDefaultsManager.saveStartAlertCount()
    }
}
