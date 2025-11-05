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
            let descriptor: FetchDescriptor = FetchDescriptor<SavedLocationPinsModel>()
            let savedLocationPinsArray: [SavedLocationPinsModel] = try localDatabaseManager.fetchFromContext(descriptor)
            
            return savedLocationPinsArray
        } catch {
            Utilities.log(SavedPinsLocalDatabaseManagerErrorModel.failedToFetchSavedLocationPins(error).localizedDescription)
            throw error
        }
    }
    
    @MainActor
    func updateLocationPins() throws {
        do {
            try localDatabaseManager.saveContext()
        } catch {
            Utilities.log(SavedPinsLocalDatabaseManagerErrorModel.failedToUpdateLocationPins(error).localizedDescription)
            throw error
        }
    }
    
    @MainActor
    func deleteSavedLocationPin(at item: SavedLocationPinsModel) throws {
        localDatabaseManager.deleteFromContext(item)
        do {
            try localDatabaseManager.saveContext()
        } catch {
            Utilities.log(SavedPinsLocalDatabaseManagerErrorModel.failedToDeleteSavedLocationPin(error).localizedDescription)
            throw error
        }
    }
}
