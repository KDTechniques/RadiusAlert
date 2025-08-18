//
//  NotificationManagerErrorModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-17.
//

import Foundation

enum NotificationManagerErrorModel {
    case failedToScheduleNotification(Error)
    case failedToAuthorizeNotification(Error)
    
    var errorDescription: String {
        switch self {
        case .failedToScheduleNotification(let error):
            return "❌: Failed to schedule local push notifications. \(error.localizedDescription)"
            
        case .failedToAuthorizeNotification(let error):
            return "❌: Failed to authorize notification. \(error.localizedDescription)"
        }
    }
}
