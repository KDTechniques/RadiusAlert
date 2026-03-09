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
        guard !builtInOutputPorts.contains(where: { $0 == port }) else { return .speaker }
        return connectedOutputPorts.contains(port) ? .connectedDevice : .allDevice
    }
    
    private static let builtInOutputPorts: [AVAudioSession.Port] = [.builtInSpeaker, .builtInReceiver]
    
    private static let connectedOutputPorts: [AVAudioSession.Port] = [
        .airPlay,
        .bluetoothA2DP,
        .bluetoothLE,
        .HDMI,
        .headphones,
        .lineOut,
        .AVB,
        .PCI,
        .bluetoothHFP,
        .carAudio,
        .displayPort,
        .fireWire,
        .thunderbolt,
        .usbAudio,
        .virtual
    ]
}
