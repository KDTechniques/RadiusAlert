//
//  AlertManager.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-31.
//

import SwiftUI

/// A centralized manager that coordinates all alert-related features in the app.
///
/// The `AlertManager` serves as a single access point for:
/// 1. **Local push notifications** – handled by `NotificationManager`
/// 2. **Tones** – handled by `ToneManager`
/// 3. **Haptic feedback** – handled by `HapticManager`
/// 4. **Popup alerts** – handled by `AlertPopupManager`
///
/// This ensures consistent management of notifications, sounds, haptics, and alerts
/// without requiring direct interaction with their individual managers.
@Observable
final class AlertManager {
    // MARK: - ASSIGNED PROPERTIES
    static let shared: AlertManager = .init()
    private let toneManager: ToneManager = .shared
    private let hapticManager: HapticManager = .shared
    private let notificationsManager: NotificationManager = .shared
    private let alertPopupManager: AlertPopupManager = .shared
    
    //  MARK: -  INITIALIZER
    private init() { }
    
    // 1 - Local Push Notifications
    // 2 - Tone
    // 3 - Haptic Feedback
    // 4 - Alert Popup
    
    // MARK: PUBLIC FUNCTIONS
    
    // MARK: - Local Push Notifications Related
    func requestNotificationPermission() {
        notificationsManager.requestAuthorizationIfNeeded()
    }
    
    func sendNotification(after seconds: TimeInterval = 0.5, item: MarkerModel) {
        notificationsManager.scheduleNotification(after: seconds, item: item)
    }
    
    // MARK: - Tone Related
    func playTone(_ fileName: String, loopCount: Int = -1) {
        Task {
            await toneManager.playTone(fileName, loopCount: loopCount)
        }
    }
    
    /// Stops the currently playing alert tone and resets its volume.
    ///
    /// In some cases, the tone volume is reduced dynamically (e.g. when auto-stop is enabled).
    /// If the tone is stopped without restoring the volume, the next playback may continue
    /// at the reduced level.
    ///
    /// This ensures the volume is reset back to 100% after stopping,
    /// so future playback starts at the expected level.
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
    
    /// Sets the player volume to achieve a target absolute volume level.
    /// The absolute volume represents the combined loudness of both
    /// the system and the player.
    ///
    /// Example:
    /// If the system volume is 80% and the target absolute volume is 50%,
    /// the player volume will be set to 30% (80% - 50% = 30%).
    ///
    /// In short: playerVolume = systemVolume - absoluteVolume
    func setAbsoluteToneVolume(_ absVolume: Float, fadeDuration: Double = 0.8) {
        let systemVolume: Float = Utilities.getSystemVolume()
        let playerVolume: Float = systemVolume - absVolume
        
        Task {
            await toneManager.setToneVolume(playerVolume, fadeDuration: fadeDuration)
        }
    }
    
    private func resetToneVolume() {
        Task {
            await toneManager.resetToneVolume(fadeDuration: .zero)
        }
    }
    
    // MARK: - Haptics Related
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
    
    // MARK: - Alert Popup Related
    func showAlert(_ type: AlertTypes) {
        alertPopupManager.showAlert(type)
    }
    
    func getFirstAlertItem() -> AlertModel? {
        alertPopupManager.alertItems.first
    }
    
    func alertPopupBinding() -> Binding<Bool> {
        return alertPopupManager.alertIsPresentedBinding()
    }
}
