//
//  LocationPinManager.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-05.
//

import Foundation

actor LocationPinManager {
    // MARK: - ASSIGNED PROPERTIES
    static let shared: LocationPinManager = .init()
    let locationPinDatabaseManager: LocationPinLocalDatabaseManager = .shared
    
    // MARK: - INITILAIZER
    private init() { }
    
    // MARK: - PUBLIC FUNCTIONS
    
    @MainActor
    func fetchLocationPins() throws -> [LocationPinsModel] {
        return try locationPinDatabaseManager.fetchLocationPins()
    }
    
    @MainActor
    func addLocationPins(_ newItems: [LocationPinsModel]) throws {
        let existingLocationPinsArray: [LocationPinsModel] = try fetchLocationPins()
        let startOrder: Int = (existingLocationPinsArray.map(\.order).max() ?? -1) + 1
        
        for (offset, item) in newItems.enumerated() {
            item.order = startOrder + offset
        }
        
        try locationPinDatabaseManager.addLocationPins(newItems)
    }
    
    @MainActor
    func updateLocationPins(_ itemsInNewOrder: [LocationPinsModel]) throws {
        for (index, item) in itemsInNewOrder.enumerated() {
            item.order = index
        }
        
        try locationPinDatabaseManager.updateLocationPins()
    }
    
    @MainActor
    func renameLocationPin(item: LocationPinsModel, newTitle: String) throws {
        item.title = newTitle
        try locationPinDatabaseManager.updateLocationPins()
    }
    
    @MainActor
    func deleteLocationPin(item: LocationPinsModel) throws {
        try locationPinDatabaseManager.deleteLocationPin(at: item)
    }
}
