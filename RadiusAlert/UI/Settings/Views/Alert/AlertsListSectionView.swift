//
//  AlertsListSectionView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-19.
//

import SwiftUI

struct AlertsListSectionView: View {
    // MARK: - BODY
    var body: some View {
        Section {
            tone
            textToSpeech
            notifications
        } header: {
            Text("Alerts")
        }
    }
}

// MARK: - PREVIEWS
#Preview("AlertsListSectionView") {
    NavigationStack {
        List {
            AlertsListSectionView()
        }
    }
    .previewModifier()
}

// MARK: - EXTENSIONS
extension AlertsListSectionView {
    private var tone: some View {
        NavigationLink {
            ToneSettingsView()
        } label: {
            Text("Tone")
        }
    }
    
    private var textToSpeech: some View {
        NavigationLink {
            SpokenAlertView()
        } label: {
            Text("Spoken Alert")
        }
    }
    
    private var notifications: some View {
        Button {
            OpenURLTypes.notifications.openURL()
        } label: {
            Text("Manage Notifications")
        }
    }
}
