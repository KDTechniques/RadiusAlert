//
//  LocationPinLocalDatabaseManager.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-05.
//

import Foundation
import SwiftData

actor LocationPinLocalDatabaseManager {
    // MARK: - ASSIGNED PROPERTIES
    static let shared: LocationPinLocalDatabaseManager = .init()
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
            Utilities.log(LocationPinLocalDatabaseManagerErrorModel.failedToCreateLocationPin(error).errorDescription)
            throw error
        }
    }
    
    @MainActor
    func fetchLocationPins() throws -> [LocationPinsModel] {
        do {
            var descriptor: FetchDescriptor = FetchDescriptor<LocationPinsModel>()
            descriptor.sortBy = [SortDescriptor(\.order, order: .forward)]
            let savedLocationPins: [LocationPinsModel] = try localDatabaseManager.fetchFromContext(descriptor)
            
            return savedLocationPins
        } catch {
            Utilities.log(LocationPinLocalDatabaseManagerErrorModel.failedToFetchLocationPins(error).errorDescription)
            throw error
        }
    }
    
    @MainActor
    func updateLocationPins() throws {
        do {
            try localDatabaseManager.saveContext()
        } catch {
            Utilities.log(LocationPinLocalDatabaseManagerErrorModel.failedToUpdateLocationPins(error).errorDescription)
            throw error
        }
    }
    
    @MainActor
    func deleteLocationPin(at item: LocationPinsModel) throws {
        localDatabaseManager.deleteFromContext(item)
        do {
            try localDatabaseManager.saveContext()
        } catch {
            Utilities.log(LocationPinLocalDatabaseManagerErrorModel.failedToDeleteLocationPin(error).errorDescription)
            throw error
        }
    }
}
