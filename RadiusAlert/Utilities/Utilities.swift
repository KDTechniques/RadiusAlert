//
//  Utilities.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-10.
//
//  A collection of general-purpose helper methods name-spaced under `Utilities`
//  to prevent global namespace pollution and improve discoverability.
//

import CoreLocation
import UIKit
import AVFoundation

struct Utilities {
    static var screenWidth: CGFloat = UIScreen.main.bounds.width
    static var screenHeight: CGFloat = UIScreen.main.bounds.height
    
    /// Logs debug info with file name, line number, and calling function.
    /// - Parameters:
    ///   - message: The message to log.
    ///   - functionName: Name of the calling function (auto-filled).
    ///   - fileName: Source file name (auto-filled).
    ///   - lineNumber: Line number in the source file (auto-filled).
    static func log(_ message: String, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
#if DEBUG
        let fileNameWithoutPath = (fileName as NSString).lastPathComponent
        print("[\(fileNameWithoutPath):\(lineNumber)] \(functionName): \(message)")
#endif
    }
    
    /// Calculates the geographic average (centroid) of a list of coordinates.
    ///
    /// This function computes the mean latitude and longitude of all coordinates
    /// in the array and returns the result as a new `CLLocationCoordinate2D`.
    ///
    /// - Parameter coordinates: An array of coordinates to average.
    /// - Returns: The geographic midpoint (average) of all provided coordinates.
    /// - Note: This uses simple arithmetic averaging and is suitable for
    ///         relatively small areas. For long distances or spherical
    ///         accuracy, a great-circle midpoint algorithm may be needed.
    static func calculateMidCoordinate(from coordinates: [CLLocationCoordinate2D]) -> CLLocationCoordinate2D {
        let count: Int = coordinates.count
        let totalLatitude: CLLocationDistance = coordinates.map({ $0.latitude }).reduce(0, +)
        let totalLongitude: CLLocationDistance = coordinates.map({ $0.longitude }).reduce(0, +)
        
        let midLatitude: CLLocationDistance = totalLatitude / Double(count)
        let midLongitude: CLLocationDistance = totalLongitude / Double(count)
        
        return .init(latitude: midLatitude, longitude: midLongitude)
    }
    
    /// Calculates the distance between two coordinates.
    ///
    /// - Parameters:
    ///   - coordinate1: The starting coordinate.
    ///   - coordinate2: The ending coordinate.
    /// - Returns: The distance in meters as a `CLLocationDistance`.
    static func getDistance(from coordinate1: CLLocationCoordinate2D, to coordinate2: CLLocationCoordinate2D) -> CLLocationDistance {
        let location1: CLLocation = .init(latitude: coordinate1.latitude, longitude: coordinate1.longitude)
        let location2: CLLocation = .init(latitude: coordinate2.latitude, longitude: coordinate2.longitude)
        
        return location1.distance(from: location2)
    }
    
    /// Computes either the minimum or maximum pairwise distance among a set of coordinates.
    /// - Parameters:
    ///   - type: `.min` to find the smallest distance, `.max` to find the largest.
    ///   - coordinates: Array of coordinates to compare. Requires at least two.
    /// - Returns: The requested distance in meters, or 0 if insufficient data.
    static func getDistance(by type: DistanceTypes, from coordinates: [CLLocationCoordinate2D]) -> CLLocationDistance {
        // Need at least two coordinates to compute a pairwise distance.
        guard coordinates.count >= 2 else { return 0 }
        
        // Initialize accumulator depending on search type (min starts high, max starts at 0).
        var result: CLLocationDistance = type == .min ? .greatestFiniteMagnitude : 0
        
        // Compare all unique pairs (i, j) with i < j to avoid duplicates and self-pairs.
        for i in 0..<coordinates.count {
            let location1 = CLLocation(
                latitude: coordinates[i].latitude,
                longitude: coordinates[i].longitude
            )
            
            for j in (i + 1)..<coordinates.count {
                let location2 = CLLocation(
                    latitude: coordinates[j].latitude,
                    longitude: coordinates[j].longitude
                )
                
                // Compute the distance between the two locations in meters.
                let distance = location1.distance(from: location2)
                
                // Update the running result based on whether we're seeking min or max.
                switch type {
                case .max:
                    if distance > result {
                        result = distance
                    }
                    
                case .min:
                    if distance < result {
                        result = distance
                    }
                }
            }
        }
        
        // Safety: If `.min` never updated (e.g., unexpected path), return 0 instead of infinity.
        if result == .greatestFiniteMagnitude {
            return 0
        }
        
        return result
    }
    
    /// Returns the current region code from the user's locale (e.g., "US", "LK").
    static func getCountryCode() -> String? {
        return Locale.current.region?.identifier // e.g. "US", "LK"
    }
    
    /// Convenience helper to check if the current region code is Sri Lanka ("LK").
    static func isCountryCodeSriLanka() -> Bool {
        let countryCode = Locale.current.region?.identifier
        return countryCode == "LK"
    }
    
    /// Reads the current system output volume from `AVAudioSession` (0.0 - 1.0).
    static func getSystemVolume() -> Float {
        let audioSession = AVAudioSession.sharedInstance()
        return audioSession.outputVolume  // Value between 0.0 and 1.0
    }
    
    /// Retrieves the app's version and build number from the main bundle.
    /// - Returns: A formatted string containing the app version and build number (e.g., "1.0.0 (123)"), or `nil` if the version or build number cannot be retrieved.
    static func appVersion() -> String? {
        guard let version: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else { return nil }
        
        return "\(version)"
    }
    
    /// Calculates the user's distance from the edge of a circular area around a marker coordinate.
    ///
    /// - Parameters:
    ///   - userCoordinate: The user's current geographic location.
    ///   - markerCoordinate: The center coordinate of the circular area (marker).
    ///   - radius: The radius of the area in meters.
    /// - Returns: The distance in meters from the user's location to the edge of the radius.
    ///            Positive if outside the radius, negative if inside, zero if exactly on the edge.
    static func getDistanceToRadius(
        userCoordinate: CLLocationCoordinate2D,
        markerCoordinate:CLLocationCoordinate2D,
        radius: CLLocationDistance
    ) -> CLLocationDistance {
        // Subtract the radius from the distance to determine how far outside/inside the user is.
        return getDistance(from: userCoordinate, to: markerCoordinate) - radius
    }
}

