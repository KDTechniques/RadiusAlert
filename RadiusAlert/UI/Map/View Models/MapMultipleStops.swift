//
//  MapMultipleStops.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2026-01-05.
//

import SwiftUI
import MapKit

// MARK: MULTIPLE STOPS

extension MapViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    func clearMultipleStops() {
        setMultipleStopsMedium(nil)
    }
    
    func handleAddAnotherStopBySearchOnAlert() {
        // First, set the medium
        setMultipleStopsMedium(.search)
        
        // Focus on search field, and show the search list
        setSearchFieldFocused(true)
        
        
        // Once the center coordinate pin is set,  let the user tap on + button to finalize adding the next stop.
    }
    
    func handleAddAnotherStopManuallyOnAlert() {
        setMultipleStopsMedium(.manual)
        /// Once the restrictions on Map Interactions are disabled, the use may able to move the map around.
        /// If not, fix that. If it works, check whether the center coordinate notation on the map is visible or not.
        setInteractionModes(.all)
        // Move the map around to counting to the next step here...
        
        
        
        // If everything works as expected!, let the user set another coordinates using center coordinate by tapping on the + button.
    }
    
    func resetMultipleStopsMedium() {
        setMultipleStopsMedium(nil)
        setRegionBoundsToUserLocationNMarkerCoordinate(animate: true)
    }
}
