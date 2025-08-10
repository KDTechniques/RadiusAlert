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
    
    /// Opens the app's settings page in the system Settings app.
    /// Safely checks if the URL can be opened before attempting to open it.
    static func openAppSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(url) else {
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
}
