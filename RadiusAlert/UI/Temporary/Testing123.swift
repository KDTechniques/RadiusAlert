//
//  Testing123.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-31.
//

import SwiftUI

struct Testing123: View {
    var body: some View {
        VStack {
            Button("Play") {
                ToneManager.shared.playDefaultTone()
            }
            
            Button("Stop") {
                ToneManager.shared.stopDefaultTone()
            }
            
            Button("Request permission for notifications") {
                NotificationManager.shared.requestAuthorizationIfNeeded()
            }
            
            Button("trigger local push notification") {
                NotificationManager.shared.scheduleNotification()
            }
            
            Button("Open app settings") {
                openAppSettings()
            }
            
            Button("Play Haptic") {
                HapticManager.shared.playSOSPattern()
            }
            
            Button("Stop haptics") {
                HapticManager.shared.stopSOSPattern()
            }
        }
    }
}

#Preview {
    Testing123()
}
