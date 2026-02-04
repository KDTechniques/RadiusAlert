//
//  RecentSearchManager.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-29.
//

import Foundation

actor RecentSearchManager {
    // MARK: - ASSIGNED PROPERTIES
    static let shared: RecentSearchManager = .init()
    let recentSearchDatabaseManager: RecentSearchLocalDatabaseManager = .shared
    
    // MARK: - INITILAIZER
    private init() { }
    
    // MARK: - PUBLIC FUNCTIONS
    
    @MainActor
    func fetchRecentSearches() throws -> [RecentSearchModel] {
        return try recentSearchDatabaseManager.fetchRecentSearches()
    }
    
    @MainActor
    func addRecentSearch(_ newItem: RecentSearchModel) throws {
        try recentSearchDatabaseManager.addRecentSearch(newItem)
    }
    
    @MainActor
    func deleteRecentSearch(item: RecentSearchModel) throws {
        try recentSearchDatabaseManager.deleteRecentSearch(at: item)
    }
    
    @MainActor
    func deleteAllRecentSearches() throws {
        try recentSearchDatabaseManager.deleteAllLocationPins()
    }
}
