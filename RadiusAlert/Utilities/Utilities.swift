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
    
    /// Calculates the midpoint between two coordinates.
    ///
    /// - Parameters:
    ///   - coord1: The first coordinate.
    ///   - coord2: The second coordinate.
    /// - Returns: The geographic midpoint as a `CLLocationCoordinate2D`.
    static func calculateMidCoordinate(from coord1: CLLocationCoordinate2D, and coord2: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        let midLatitude = (coord1.latitude + coord2.latitude) / 2
        let midLongitude = (coord1.longitude + coord2.longitude) / 2
        
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
    
    static func getCountryCode() -> String? {
        return Locale.current.region?.identifier // e.g. "US", "LK"
    }
    
    static func isCountryCodeSriLanka() -> Bool {
        let countryCode = Locale.current.region?.identifier
        return countryCode == "LK"
    }
    
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
    
    static func getDistanceToRadius(
        userCoordinate: CLLocationCoordinate2D,
        markerCoordinate:CLLocationCoordinate2D,
        radius: CLLocationDistance
    ) -> CLLocationDistance {
       return getDistance(from: userCoordinate, to: markerCoordinate) - radius
    }
}
