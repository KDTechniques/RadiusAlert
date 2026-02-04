//
//  RecentSearchLocalDatabaseManagerErrorModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-29.
//

import Foundation

enum RecentSearchLocalDatabaseManagerErrorModel {
    case failedToCreateRecentSearch(_ error: Error)
    case failedToFetchRecentSearches(_ error: Error)
    case failedToUpdateRecentSearch(_ error: Error)
    case failedToDeleteRecentSearch(_ error: Error)
    
    var errorDescription: String {
        switch self {
        case .failedToCreateRecentSearch(let error):
            return "❌: Failed to create recent search. \(error.localizedDescription)"
        case .failedToFetchRecentSearches(let error):
            return "❌: Failed to fetch recent searches from context. \(error.localizedDescription)"
        case .failedToUpdateRecentSearch(let error):
            return "❌: failed to update recent search. \(error.localizedDescription)"
        case .failedToDeleteRecentSearch(let error):
            return "❌: Failed to delete recent search from context. \(error.localizedDescription)"
        }
    }
}

