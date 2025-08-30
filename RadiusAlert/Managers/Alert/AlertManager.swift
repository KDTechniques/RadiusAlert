//
//  AlertManager.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-31.
//

import Foundation

@Observable
final class AlertManager {
    // MARK: - ASSIGNED PROPERTIES
    static let shared: AlertManager = .init()
    private let toneManager: ToneManager = .shared
    private let hapticManager: HapticManager = .shared
    private let notificationsManager: NotificationManager = .shared
    var alertItem: AlertModel?
    
    //  MARK: -  INITIALIZER
    private  init() { }
    
    // 1 - Local Push Notifications
    // 2 - Tone
    // 3 - Haptic Feedback
    
    // MARK: - PUBLIC FUNCTIONS
    func requestNotificationPermission() {
        notificationsManager.requestAuthorizationIfNeeded()
    }
    
    // Local Push Notifications Related
    func sendNotification(after seconds: TimeInterval = 0.5) {
        notificationsManager.scheduleNotification(after: seconds)
    }
    
    // Tone Related
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
    
    // Haptics Related
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
}
