//
//  AudioRouteOutputTypes.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2026-03-02.
//

import Foundation
import AVFoundation

enum AudioRouteOutputTypes: String, CaseIterable {
    case speaker = "Built-in Speaker"
    case connectedDevice = "Connected Device"
    case allDevice = "All Devices"
    
    static func getAudioRouteOutputType(for port: AVAudioSession.Port) -> Self {
        guard port != builtInSpeakerPort else { return .speaker }
        return allPorts.contains(port) ? .connectedDevice : .allDevice
    }
    
    private static let builtInSpeakerPort: AVAudioSession.Port = .builtInSpeaker
    
    private static let allPorts: [AVAudioSession.Port] = [
        .airPlay,
        .AVB,
        .bluetoothA2DP,
        .bluetoothHFP,
        .bluetoothLE,
        .builtInMic,
        .builtInReceiver,
        .carAudio,
        .continuityMicrophone,
        .displayPort,
        .fireWire,
        .HDMI,
        .headphones,
        .headsetMic,
        .lineIn,
        .lineOut,
        .PCI,
        .thunderbolt,
        .usbAudio,
        .virtual
    ]
}
