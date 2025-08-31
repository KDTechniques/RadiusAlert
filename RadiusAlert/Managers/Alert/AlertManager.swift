//
//  AlertManager.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-31.
//

import SwiftUI

@Observable
final class AlertManager {
    // MARK: - ASSIGNED PROPERTIES
    static let shared: AlertManager = .init()
    private let toneManager: ToneManager = .shared
    private let hapticManager: HapticManager = .shared
    private let notificationsManager: NotificationManager = .shared
    private let alertPopupmanager: AlertPopupManager = .shared
    
    //  MARK: -  INITIALIZER
    private  init() { }
    
    // 1 - Local Push Notifications
    // 2 - Tone
    // 3 - Haptic Feedback
    // 4 - Alert Popup
    
    // MARK: - PUBLIC FUNCTIONS
    
    // Local Push Notifications Related
    func requestNotificationPermission() {
        notificationsManager.requestAuthorizationIfNeeded()
    }
    
    func sendNotification(after seconds: TimeInterval = 0.5) {
        notificationsManager.scheduleNotification(after: seconds)
    }
    
    // MARK: Tone Related
    func playTone(_ fileName: String, loopCount: Int = -1) {
        Task {
            await toneManager.playTone(fileName, loopCount: loopCount)
        }
    }
    
    func stopTone() {
        Task {
            await toneManager.stopTone()
            resetToneVolume()
        }
    }
    
    func setToneVolume(_ volume: Float, fadeDuration: Double = 0.8) {
        Task {
            await toneManager.setToneVolume(volume, fadeDuration: fadeDuration)
        }
    }
    
    private func resetToneVolume() {
        Task {
            await toneManager.resetToneVolume(.zero)
        }
    }
    
    // MARK: Haptics Related
    func playHaptic() {
        Task {
            await hapticManager.playSOSPattern()
        }
    }
    
    func stopHaptic() {
        Task {
            await hapticManager.stopSOSPattern()
        }
    }
    
    // MARK: Alert Popup Related
    func showAlert(_ type: AlertTypes) {
        alertPopupmanager.showAlert(type)
    }
    
    func getFirstAlertItem() -> AlertModel? {
        alertPopupmanager.alertItems.first
    }
    
    func alertPopupBinding() -> Binding<Bool> {
        return alertPopupmanager.alertIsPresentedBinding()
    }
}
