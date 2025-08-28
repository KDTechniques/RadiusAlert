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
    let locationManager: LocationManager = .shared
    @State private var volume: String?
    
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
        currentDistanceMode
        tone
        haptic
        notification
        alert
        systemVolume
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
    
    private var currentDistanceMode: some View {
        HStack {
            Text("Current Distance  Mode")
            
            Spacer()
            
            Text(locationManager.currentDistanceMode?.rawValue ?? "nil")
                .foregroundStyle(.secondary)
        }
    }
    
    private var systemVolume: some View {
        HStack {
            Button("Get System Volume") {
                volume = Utilities.getSystemVolume()
                    .formatted(.percent.precision(.fractionLength(0)))
            }
            
            Spacer()
            
            if let volume {
                Text(volume)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
