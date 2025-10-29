//
//  NetworkManager.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-12.
//

import Foundation
import Network
import Combine

/**
 A main-actor-bound, observable class responsible for monitoring and managing the device's network connection status.
 It provides real-time updates on the internet connection status and handles changes in connectivity.
 This class leverages `NWPathMonitor` to monitor network paths and uses Combine to publish connection status updates.
 */

@Observable
final class NetworkManager {
    // MARK: - ASSIGNED PROPERTIES
    static let shared: NetworkManager = .init()
    private let monitor = NWPathMonitor()
    private let networkManagerQueue = DispatchQueue(label: "com.kdtechniques.Pixel-Desktop-Pictures.NetworkManager.networkManagerQueue")
    private(set) var connectionState: ConnectionStates = .noConnection {
        didSet { connectionState$ = connectionState }
    }
    @ObservationIgnored @Published private var connectionState$: ConnectionStates = .noConnection
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - INITIALIZER
    private init() {
        connectionStatusSubscriber()
        startNetworkMonitor()
        Utilities.log("✅: `Network Manager` has been initialized")
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
    /// Subscribes to changes in the `connectionStatus$` property and handles updates accordingly.
    private func connectionStatusSubscriber() {
        $connectionState$
            .removeDuplicates()
            .sink {
                switch $0 {
                case .connected:
                    self.handleConnectedStatus()
                case .noConnection:
                    self.handleNoConnectionStatus()
                }
            }
            .store(in: &cancellables)
    }
    
    /// Starts monitoring the network path for changes in connectivity.
    private func startNetworkMonitor() {
        monitor.pathUpdateHandler = { value in
            Task { @MainActor in
                if value.status == .satisfied {
                    self.connectionState = .connected
                } else {
                    self.connectionState = .noConnection
                }
            }
        }
        
        monitor.start(queue: networkManagerQueue)
    }
    
    /// Handles actions when the device is connected to a network.
    private func handleConnectedStatus() {
        Utilities.log("✅🛜: Connected to a Network.")
    }
    
    /// Handles actions when the device loses network connectivity.
    private func handleNoConnectionStatus() {
        Utilities.log("❌🛜: No Network Connection.")
    }
}
