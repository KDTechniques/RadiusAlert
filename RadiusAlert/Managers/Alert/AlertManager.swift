//
//  AlertManager.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-31.
//

import Foundation

final class AlertManager {
    // MARK: - ASSIGNED PROPERTIES
    static let shared: AlertManager = .init()
    let toneManager: ToneManager = .shared
    let hapticManager: HapticManager = .shared
    let notificationsManager: NotificationManager = .shared
    
    //  MARK: -  INITIALIZER
    private  init() { }
    
    // 1 - Local Push Notifications
    // 2 - Tone
    // 3 - Haptic Feedback
    
    // MARK: - FUNCTIONS
    
    // Local Push Notifications Related
    func requestNotificationPermission() {
        notificationsManager.requestAuthorizationIfNeeded()
    }
    
    func sendNotification() {
        notificationsManager.scheduleNotification()
    }
    
    // Tone Related
    func playTone() {
        toneManager.playDefaultTone()
    }
    
    func stopTone() {
        toneManager.stopDefaultTone()
    }
    
    // Haptics Related
    func playHaptic() {
        hapticManager.playSOSPattern()
    }
    
    func stopHaptic() {
        hapticManager.stopSOSPattern()
    }
}
