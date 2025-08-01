//
//  NotificationManager.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-31.
//

import UserNotifications

final class NotificationManager {
    // MARK: - ASSIGNED PROPERTIES
    static let shared = NotificationManager()
    
    // MARK: - INITIALIZER
    private init() {}
    
    // MARK: - FUNCTIONS
    func requestAuthorizationIfNeeded() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus != .authorized else { return }
            
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
                if let error = error {
                    print("Notification authorization error:", error)
                } else {
                    print("Notification permission granted:", granted)
                }
            }
        }
    }
    
    func scheduleNotification(after seconds: TimeInterval = 0) {
        let content = UNMutableNotificationContent()
        content.title = "You're Here 🎉"
        content.body = "You've arrived at your destination. Tap to continue."
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "arrivalNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["arrivalNotification"])
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule notification:", error)
            }
        }
    }
}
