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
    func addLocationPin(_ newItem: LocationPinsModel) throws {
        let existingLocationPinsArray: [LocationPinsModel] = try fetchLocationPins()
        
        guard !existingLocationPinsArray.contains(where: { $0.isSameCoordinate(newItem.coordinate) }) else { return }
        
        let startOrder: Int = (existingLocationPinsArray.map(\.order).max() ?? -1) + 1
        newItem.order = startOrder
        try locationPinDatabaseManager.addLocationPin(newItem)
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
