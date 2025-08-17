//
//  MemoryWarningHandler.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-17.
//

import UIKit

final class MemoryWarningHandler {
    // MARK: - ASSIGNED PROPERTIES
    static let shared = MemoryWarningHandler()
    private var cleanupActions: [() -> Void] = []
    
    // MARK: - PRIVATE INITIALIZER
    private init() {
        // Listen for memory warnings
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(memoryWarningReceived),
            name: UIApplication.didReceiveMemoryWarningNotification,
            object: nil
        )
    }
    
    // MARK: - DEINITIALIZER
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - PUBLIC FUNCTIONS
    
    /// Register a cleanup action to be executed when memory warning occurs
    func registerCleanupAction(_ action: @escaping () -> Void) {
        cleanupActions.append(action)
    }
    
    // MARK: - PRIVATE FUNCTIONS
    /// Called when a memory warning is received
    @objc private func memoryWarningReceived() {
        print("Memory warning received! Executing cleanup actions…")
        cleanupActions.forEach { $0() }
    }
}
