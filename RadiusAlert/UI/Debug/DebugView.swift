//
//  DebugView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-24.
//

import SwiftUI

struct DebugView: View {
    // MARK: - BODY
    var body: some View {
        NavigationLink {
            Content()
        } label: {
            Image(systemName: "ladybug.fill")
        }
        .buttonStyle(.plain)
    }
}

// MARK: - PREVIEWS
#Preview("Debug - Content") {
    NavigationStack {
        Content()
    }
    .previewModifier()
}

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

// MARK: - SUB VIEWS
private struct Content: View {
    @Environment(SettingsViewModel.self) private var settingsVM
    @Environment(MapViewModel.self) private var mapVM
    
    let alertManager: AlertManager = .shared
    let locationManager: LocationManager = .shared
    let textToSpeechManager: TextToSpeechManager = .shared
    @State private var volume: String?
    @State private var playerVolume: Float = 1.0
    @State private var isPresentedReadMe: Bool = false
    @State private var availableVoices: [String] = []
    @State private var selectedVoice: String = "Samantha"
    
    var body: some View {
        List {
            currentDistanceMode
            textToSpeech
            tone
            haptic
            notification
            alert
            readMe
            clearUserDefaults
        }
        .sheet(isPresented: $isPresentedReadMe) {
            ReadMeView($isPresentedReadMe)
        }
        .navigationTitle(Text("Debug"))
        .task { availableVoices = await textToSpeechManager.getAvailableVoiceNames() }
    }
}

// MARK: - EXTENSIONS
extension Content {
    private var tone: some View {
        Section {
            Button("Play Tone") {
                alertManager.playTone(settingsVM.selectedTone.fileName)
            }
            
            Button("Stop Tone") {
                alertManager.stopTone()
            }
            
            getSystemVolume
            SetSystemVolume
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
                    alertManager.showAlert(alert)
                }
            }
        } header: {
            Text("Alert Popups")
        }
    }
    
    private var currentDistanceMode: some View {
        HStack {
            Text("Current Distance Mode")
            
            Spacer()
            
            Text(locationManager.currentDistanceMode?.rawValue ?? "nil")
                .foregroundStyle(.secondary)
        }
    }
    
    private var getSystemVolume: some View {
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
    
    private var SetSystemVolume: some View {
        VStack(alignment: .leading) {
            Text("Player Volume: \(playerVolume.formatted(.percent.precision(.fractionLength(0))))")
                .foregroundStyle(.secondary)
            
            Slider(value: $playerVolume, in: 0...1, step: 0.1) { }
                .onChange(of: playerVolume) {
                    mapVM.alertManager.setToneVolume($1, fadeDuration: 0)
                }
        }
    }
    
    private var readMe:  some View {
        Section {
            Button("Show Read Me") {
                isPresentedReadMe = true
            }
        }
    }
    
    private var textToSpeech: some View {
        Section {
            Picker("Voice", selection: $selectedVoice) {
                ForEach(availableVoices, id: \.self) { voice in
                    Text(voice)
                }
            }
            
            let text: String = TextToSpeechValues.defaultText(userName: "Kavinda", locationTitle: "OneMac")
            Text("Text: \(text)")
            
            Button("Speak") {
                Task {
                    await textToSpeechManager.speak(text: text, voice: selectedVoice)
                }
            }
        } header: {
            Text("Text-to-Speech")
        }
    }
    
    private var clearUserDefaults: some View {
        Button("Clear User Defaults") {
            UserDefaultsManager.clearAllUserDefaults()
        }
    }
}
