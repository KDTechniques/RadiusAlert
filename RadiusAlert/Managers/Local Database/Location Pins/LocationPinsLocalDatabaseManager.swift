//
//  LocationPinsLocalDatabaseManager.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-05.
//

import Foundation
import SwiftData

actor LocationPinsLocalDatabaseManager {
    // MARK: - ASSIGNED PROPERTIES
    static let shared: LocationPinsLocalDatabaseManager = .init()
    let localDatabaseManager: LocalDatabaseManager = .shared
    
    // MARK: - INITIALIZER
    private init() { }
    
    // MARK: - PUBLIC FUNCTIONS
    
    @MainActor
    func addLocationPins(_ newItems: [LocationPinsModel]) throws {
        for item in newItems {
            localDatabaseManager.insertToContext(item)
        }
        
        do {
            try localDatabaseManager.saveContext()
        } catch {
            Utilities.log(SavedPinsLocalDatabaseManagerErrorModel.failedToCreateNewLocationPin(error).errorDescription)
            throw error
        }
    }
    
    @MainActor
    func fetchLocationPins() throws -> [LocationPinsModel] {
        do {
            var descriptor: FetchDescriptor = FetchDescriptor<LocationPinsModel>()
            descriptor.sortBy = [SortDescriptor(\.order, order: .forward)]
            let savedLocationPinsArray: [LocationPinsModel] = try localDatabaseManager.fetchFromContext(descriptor)
            
            return savedLocationPinsArray
        } catch {
            Utilities.log(SavedPinsLocalDatabaseManagerErrorModel.failedToFetchSavedLocationPins(error).errorDescription)
            throw error
        }
    }
    
    @MainActor
    func updateLocationPins() throws {
        do {
            try localDatabaseManager.saveContext()
        } catch {
            Utilities.log(SavedPinsLocalDatabaseManagerErrorModel.failedToUpdateLocationPins(error).errorDescription)
            throw error
        }
    }
    
    @MainActor
    func deleteLocationPin(at item: LocationPinsModel) throws {
        localDatabaseManager.deleteFromContext(item)
        do {
            try localDatabaseManager.saveContext()
        } catch {
            Utilities.log(SavedPinsLocalDatabaseManagerErrorModel.failedToDeleteSavedLocationPin(error).errorDescription)
            throw error
        }
    }
    
    @MainActor
    func deleteAllLocationPins() throws {
        let fetchedLocationPins: [LocationPinsModel] = try fetchLocationPins()
        for item in fetchedLocationPins {
            localDatabaseManager.deleteFromContext(item)
        }
        
        do {
            try localDatabaseManager.saveContext()
        } catch {
            Utilities.log(SavedPinsLocalDatabaseManagerErrorModel.failedToDeleteSavedLocationPin(error).errorDescription)
            throw error
        }
    }
}
