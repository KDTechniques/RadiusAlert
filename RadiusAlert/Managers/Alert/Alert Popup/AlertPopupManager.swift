//
//  AlertPopupManager.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-31.
//

import SwiftUI

@Observable
final class AlertPopupManager {
    // MARK: - ASSIGNED PROPERTIES
    static let shared = AlertPopupManager()
    private let hapticManager: HapticManager = .shared
    private(set) var alertItems: [AlertModel] = []
    private var isAlertPresented: Bool = false
    
    // MARK: - SETTERS
    private func setIsPresented(_ boolean: Bool) {
        isAlertPresented = boolean
    }
    
    /// Returns a `Binding<Bool>` representing whether an alert is currently presented.
    ///
    /// Automatically updates the alert queue when the current alert is dismissed.
    func alertIsPresentedBinding() -> Binding<Bool> {
        Binding {
            return !self.alertItems.isEmpty
        } set: { newValue in
            guard newValue != self.isAlertPresented else { return }
            
            self.setIsPresented(newValue)
            
            // Once the user dismiss the current alert the following get executed
            guard !newValue else { return }
            self.removeFirstNPresentNextAlert()
        }
    }
    
    // MARK: - PUBLIC FUNCTIONS
    
    /// Displays an alert of the specified type.
    ///
    /// Alerts are queued if multiple alerts are triggered simultaneously,
    /// and are presented one by one as previous alerts are dismissed.
    /// - Parameter type: The `AlertTypes` value representing the alert to show.
    func showAlert(_ type: AlertTypes) {
        /// If this function is called multiple times, alerts cannot be displayed simultaneously.
        /// Therefore, each alert is added to a queue and presented one by one.
        /// Each subsequent alert is shown only after the previous one is dismissed by the user.
        appendAlertItem(type.alert)
        
        // If this is the only alert in the queue, vibrate and present immediately
        guard alertItems.count == 1,
              let firstItemHaptic: HapticTypes = alertItems.first?.hapticType else { return }
        
        vibrateNPresent(firstItemHaptic)
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func appendAlertItem(_ alertItem: AlertModel) {
        self.alertItems.append(alertItem)
    }
    
    private func removeFirstAlert() {
        guard !alertItems.isEmpty else { return }
        alertItems.removeFirst()
    }
    
    private func removeFirstNPresentNextAlert() {
        removeFirstAlert()
        
        guard !alertItems.isEmpty,
              let nextItemHaptic: HapticTypes = alertItems.first?.hapticType else { return }
        
        vibrateNPresent(nextItemHaptic)
    }
    
    private func vibrateNPresent(_ haptic: HapticTypes) {
        Task {
            await hapticManager.vibrate(type: haptic)
            setIsPresented(true)
        }
    }
}
