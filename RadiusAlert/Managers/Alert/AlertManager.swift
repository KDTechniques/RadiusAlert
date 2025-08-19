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
    func sendNotification() {
        notificationsManager.scheduleNotification()
    }
    
    // Tone Related
    func playTone(_ fileName: String, loopCount: Int = -1) {
        toneManager.playTone(fileName, loopCount: loopCount)
    }
    
    func stopTone() {
        toneManager.stopTone()
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
