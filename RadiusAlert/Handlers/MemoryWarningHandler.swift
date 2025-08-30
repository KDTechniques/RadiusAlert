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
    private init() { addMemoryWarningObserver() }
    
    // MARK: - DEINITIALIZER
    deinit { removeMemoryWarningObserver() }
    
    // MARK: - PUBLIC FUNCTIONS
    
    /// Registers a closure to be executed when a memory warning occurs.
    ///
    /// - Parameter action: A closure that contains cleanup logic
    ///   such as clearing caches, temporary files, or resetting non-critical data.
    func registerCleanupAction(_ action: @escaping () -> Void) {
        cleanupActions.append(action)
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
    /// Adds an observer for `UIApplication.didReceiveMemoryWarningNotification`.
    ///
    /// This allows the handler to be notified when the system detects
    /// low memory conditions. The observer will then trigger the
    /// `memoryWarningReceived()` function to execute cleanup actions.
    ///
    /// - Note: This should only be called once during initialization
    ///   to avoid duplicate observers.
    private func addMemoryWarningObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(memoryWarningReceived),
            name: UIApplication.didReceiveMemoryWarningNotification,
            object: nil
        )
    }
    
    /// Removes the previously added memory warning observer.
    ///
    /// This should be called during `deinit` to prevent potential
    /// memory leaks or unwanted notifications being sent after
    /// the object has been deallocated.
    private func removeMemoryWarningObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// Invoked automatically when the system sends a memory warning.
    ///
    /// Iterates through all registered cleanup actions and executes them
    /// to reduce memory pressure.
    @objc private func memoryWarningReceived() {
        print("⚠️: Memory warning received! Executing cleanup actions…")
        cleanupActions.forEach { $0() }
    }
}
