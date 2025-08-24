//
//  DebugView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-24.
//

import SwiftUI

struct DebugView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(SettingsViewModel.self) private var settingsVM
    
    // MARK: -  ASSIGNED PROPERTIES
    let alertManager: AlertManager = .shared
    
    // MARK: - BODY
    var body: some View {
        NavigationLink {
            List {
                content
            }
            .navigationTitle(Text("Debug"))
        } label: {
            Image(systemName: "ladybug.fill")
        }
        .padding(.trailing)
    }
}

// MARK: - PREVIEWS
#Preview("Debug") {
    NavigationStack {
        DebugView()
    }
    .previewModifier()
}

#Preview("Content") {
    ContentView()
        .previewModifier()
}

// MARK: - EXTENSIONS
extension DebugView {
    @ViewBuilder
    private var content: some View {
        tone
        haptic
        notification
        alert
    }
    
    private var tone: some View {
        Section {
            Button("Play Tone") {
                alertManager.playTone(settingsVM.selectedTone.fileName)
            }
            
            Button("Stop Tone") {
                alertManager.stopTone()
            }
        } header: {
            Text("Tone Manager")
        }
    }
    
    private var haptic: some View {
        Section {
            Button("Play Haptic") {
                alertManager.playHaptic()
            }
            
            Button("Stop Haptic") {
                alertManager.stopHaptic()
            }
        } header: {
            Text("Haptic Manager")
        }
    }
    
    private var notification: some View {
        Section {
            Button("Request Permission") {
                alertManager.requestNotificationPermission()
            }
            
            Button("Send Notification") {
                alertManager.sendNotification(after: 3)
            }
        } header: {
            Text("Notification Manager")
        }
    }
    
    private var alert: some View {
        Section {
            ForEach(AlertTypes.allCases, id: \.self)  { alert in
                Button(alert.rawValue)  {
                    alertManager.alertItem = alert.alert
                }
            }
        } header: {
            Text("Alert Popups")
        }
    }
}
