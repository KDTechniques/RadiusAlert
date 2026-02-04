//
//  RecentSearchLocalDatabaseManager.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-29.
//

import Foundation
import SwiftData

actor RecentSearchLocalDatabaseManager {
    // MARK: - ASSIGNED PROPERTIES
    static let shared: RecentSearchLocalDatabaseManager = .init()
    let localDatabaseManager: LocalDatabaseManager = .shared
    
    // MARK: - INITIALIZER
    private init() { }
    
    // MARK: - PUBLIC FUNCTIONS
    
    @MainActor
    func addRecentSearch(_ newItem: RecentSearchModel) throws {
        localDatabaseManager.insertToContext(newItem)
        
        do {
            try limitRecentSearches()
            try localDatabaseManager.saveContext()
        } catch {
            Utilities.log(RecentSearchLocalDatabaseManagerErrorModel.failedToCreateRecentSearch(error).errorDescription)
            throw error
        }
    }
    
    @MainActor
    func fetchRecentSearches() throws -> [RecentSearchModel] {
        do {
            var descriptor: FetchDescriptor = FetchDescriptor<RecentSearchModel>()
            descriptor.sortBy = [SortDescriptor(\.timestamp, order: .reverse)]
            let savedRecentSearches: [RecentSearchModel] = try localDatabaseManager.fetchFromContext(descriptor)
            
            return savedRecentSearches
        } catch {
            Utilities.log(RecentSearchLocalDatabaseManagerErrorModel.failedToFetchRecentSearches(error).errorDescription)
            throw error
        }
    }
    
    @MainActor
    func deleteRecentSearch(at item: RecentSearchModel) throws {
        localDatabaseManager.deleteFromContext(item)
        do {
            try localDatabaseManager.saveContext()
        } catch {
            Utilities.log(RecentSearchLocalDatabaseManagerErrorModel.failedToDeleteRecentSearch(error).errorDescription)
            throw error
        }
    }
    
    @MainActor
    func deleteAllLocationPins() throws {
        let fetchedRecentSearches: [RecentSearchModel] = try fetchRecentSearches()
        for item in fetchedRecentSearches {
            localDatabaseManager.deleteFromContext(item)
        }
        
        do {
            try localDatabaseManager.saveContext()
        } catch {
            Utilities.log(RecentSearchLocalDatabaseManagerErrorModel.failedToDeleteRecentSearch(error).errorDescription)
            throw error
        }
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
    @MainActor
    private func limitRecentSearches() throws {
        // Fetch all items sorted by most recent first
        let allItems: [RecentSearchModel] = try fetchRecentSearches()
        
        // Determine overflow items beyond the max allowed
        let maxCount: Int = RecentSearchModel.maxRecentSearchesCount
        if allItems.count > maxCount {
            let overflow = allItems.suffix(from: maxCount)
            // Delete overflow items
            for item in overflow {
                try deleteRecentSearch(at: item)
            }
        }
    }
}

