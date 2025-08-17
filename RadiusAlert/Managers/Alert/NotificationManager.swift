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
    private init() { }
    
    // MARK: - PUBLIC FUNCTIONS
    
    /// Schedules a local notification to inform the user they've reached their destination.
    /// Any previously scheduled notification with the same identifier is removed before scheduling a new one.
    /// - Parameter seconds: Delay in seconds before the notification is delivered. Defaults to 0.5 seconds.
    func scheduleNotification(after seconds: TimeInterval = 0.5) {
        // 1. Configure notification content
        let content = UNMutableNotificationContent()
        content.title = "You're Here 📍"
        content.body = "You've arrived at your destination radius. Tap to continue."
        content.sound = .defaultRingtone
        
        // 2. Create a time-based trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        
        // 3. Create the notification request with a unique identifier
        let request = UNNotificationRequest(identifier: "arrivalNotification", content: content, trigger: trigger)
        
        // 4. Remove any previously scheduled notifications with the same identifier
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["arrivalNotification"])
        
        // 5. Add the new notification request to the notification center
        UNUserNotificationCenter.current().add(request) { error in
            if let error {
                print("Failed to schedule notification:", error)
            }
        }
    }
    
    /// Requests user authorization for local notifications if not already granted.
    /// Checks current notification settings first to avoid redundant permission requests.
    func requestAuthorizationIfNeeded() {
        // 1. Retrieve current notification settings
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            
            // 2. Exit early if authorization has already been granted
            guard settings.authorizationStatus != .authorized else { return }
            
            // 3. Request authorization for alerts and sounds
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
                if let error {
                    // Log any errors that occur during the authorization request
                    print("Notification authorization error:", error)
                } else {
                    // Log the result of the authorization request
                    print("Notification permission granted:", granted)
                }
            }
        }
    }
}
