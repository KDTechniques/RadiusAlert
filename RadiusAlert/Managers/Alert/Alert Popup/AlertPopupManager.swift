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
    private var isAlertPresented: Bool = false { didSet { print(isAlertPresented) } }
    
    // MARK: - SETTERS
    private func setIsPresented(_ boolean: Bool) {
        isAlertPresented = boolean
    }
    
    func alertIsPresentedBinding() -> Binding<Bool> {
        Binding {
            return !self.alertItems.isEmpty
        } set: { newValue in
            guard newValue != self.isAlertPresented else { return }
            
            self.setIsPresented(newValue)
            
            // Once the user dissmiss the current alert the following get excecuted
            guard !newValue else { return }
            self.removeFirstNPresentNextAlert()
        }
    }
    
    // MARK: - PUBLIC FUNCTIONS
    
    /// This function simplifies the process of displaying an alert item, eliminating the need to use `isPresented` for each alert we create.
    func showAlert(_ type: AlertTypes) {
        /// If the functon get called more than once
        /// we can't show all of them at once.
        /// So we add them to the queue
        /// and later we can show one after another
        /// when each alert get dismissed by the user.
        appendAlertItem(type.alert)
        
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
