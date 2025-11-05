//
//  SavedLocationPinsLocalDatabaseManager.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-05.
//

import Foundation
import SwiftData

actor SavedLocationPinsLocalDatabaseManager {
    // MARK: - ASSIGNED PROPERTIES
    static let shared: SavedLocationPinsLocalDatabaseManager = .init()
    let localDatabaseManager: LocalDatabaseManager = .shared
    
    // MARK: - INITIALIZER
    private init() { }
    
    // MARK: - PUBLIC FUNCTIONS
    
    @MainActor
    func addLocationPins(_ newItems: [SavedLocationPinsModel]) throws {
        for item in newItems {
            localDatabaseManager.insertToContext(item)
        }
        
        do {
            try localDatabaseManager.saveContext()
        } catch {
            Utilities.log(SavedPinsLocalDatabaseManagerErrorModel.failedToCreateNewLocationPin(error).localizedDescription)
            throw error
        }
    }
    
    @MainActor
    func fetchSavedLocationPins() throws -> [SavedLocationPinsModel] {
        do {
            let descriptor: FetchDescriptor = FetchDescriptor<SavedLocationPinsModel>(
                sortBy: [SortDescriptor(\.timestamp, order: .forward)] // Ascending order
            )
            let collectionsArray: [Collection] = try localDatabaseManager.fetchFromContext(descriptor)
            
            return collectionsArray
        } catch {
            Logger.log(CollectionLocalDatabaseManagerError.failedToFetchCollections(error).localizedDescription)
            throw error
        }
    }
    
    
    
    
    
    
    
}
