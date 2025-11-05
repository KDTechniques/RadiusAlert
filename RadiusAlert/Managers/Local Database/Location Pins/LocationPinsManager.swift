//
//  LocationPinsManager.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-05.
//

import Foundation

actor LocationPinsManager {
    // MARK: - ASSIGNED PROPERTIES
    static let shared: LocationPinsManager = .init()
    let locationPinsDatabaseManager: LocationPinsLocalDatabaseManager = .shared
    
    // MARK: - INITILAIZER
    private init() { }
    
    // MARK: - PUBLIC FUNCTIONS
    
    @MainActor
    func fetchLocationPins() throws -> [LocationPinsModel] {
        return try locationPinsDatabaseManager.fetchLocationPins()
    }
    
    @MainActor
    func addLocationPins(_ newItems: [LocationPinsModel]) throws {
        let existingLocationPinsArray: [LocationPinsModel] = try fetchLocationPins()
        let startOrder: Int = (existingLocationPinsArray.map(\.order).max() ?? -1) + 1
        
        for (offset, item) in newItems.enumerated() {
            item.order = startOrder + offset
        }
        
        try locationPinsDatabaseManager.addLocationPins(newItems)
    }
    
    @MainActor
    func updateLocationPins(_ itemsInNewOrder: [LocationPinsModel]) throws {
        for (index, item) in itemsInNewOrder.enumerated() {
            item.order = index
        }
        
        try locationPinsDatabaseManager.updateLocationPins()
    }
    
    @MainActor
    func moveLocationPins(items: inout [LocationPinsModel], fromOffsets: IndexSet, toOffset: Int) throws {
        items.move(fromOffsets: fromOffsets, toOffset: toOffset)
        
        // After mutating the array, persist the new order
        for (index, item) in items.enumerated() {
            item.order = index
        }
        
        try locationPinsDatabaseManager.updateLocationPins()
    }
    
    @MainActor
    func renameLocationPin(item: LocationPinsModel, newTitle: String) throws {
        item.title = newTitle
        try locationPinsDatabaseManager.updateLocationPins()
    }
    
    @MainActor
    func deleteLocationPin(item: LocationPinsModel) throws {
        try locationPinsDatabaseManager.deleteLocationPin(at: item)
    }
}
