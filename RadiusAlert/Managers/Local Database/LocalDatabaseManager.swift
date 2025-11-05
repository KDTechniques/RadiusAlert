//
//  LocalDatabaseManager.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-05.
//

import Foundation
import SwiftData

/**
 A thread-safe actor responsible for managing the local database operations.
 It provides methods for initializing the database, erasing all data, and saving changes to the context.
 This actor ensures that all database operations are performed in a thread-safe manner, leveraging Swift's concurrency model.
 */
actor LocalDatabaseManager {
    // MARK: SINGLETON
    static let shared: LocalDatabaseManager = .init()
    
    // MARK: - INJECTED PROPERTIES
    private let container: ModelContainer
    
    // MARK: - INITIALIZER
    private init() {
        do {
            container = try ModelContainer(for: SavedLocationPinsModel.self)
            Utilities.log("✅: Initialized `LocalDatabaseManager`.")
        } catch {
            Utilities.log(LocalDatabaseManagerErrorModel.failedToInitializeModelContainer(error).localizedDescription)
            fatalError()
        }
    }
    
    // MARK: PUBLIC FUNCTIONS
    
    /// Erases all data from the local database.
    /// - Throws: An error if the operation fails, such as if the database cannot be erased.
    func eraseAllData() throws {
        do {
            try container.erase()
        } catch {
            Utilities.log(LocalDatabaseManagerErrorModel.failedToEraseAllData(error).localizedDescription)
            throw error
        }
    }
    
    /// Saves changes made to the local database context.
    /// - Throws: An error if the operation fails, such as if the context cannot be saved.
    /// - Note: If saving fails, the context will roll back any unsaved changes.
    @MainActor
    func saveContext() throws {
        do {
            try container.mainContext.save()
        } catch {
            // Rollback changes to the context if saving fails
            container.mainContext.rollback() // Rollback any unsaved changes
            Utilities.log(LocalDatabaseManagerErrorModel.failedToSaveContext(error).localizedDescription)
            throw error
        }
    }
    
    @MainActor
    func insertToContext<T: PersistentModel>(_ item: T) {
        container.mainContext.insert(item)
    }
    
    @MainActor
    func fetchFromContext<T: PersistentModel>(_ request: FetchDescriptor<T>) throws -> [T] {
        try container.mainContext.fetch(request)
    }
    
    @MainActor
    func deleteFromContext<T: PersistentModel>(_ item: T) {
        container.mainContext.delete(item)
    }
}
