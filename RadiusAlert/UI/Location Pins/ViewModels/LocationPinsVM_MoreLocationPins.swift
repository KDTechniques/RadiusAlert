//
//  LocationPinsVM_MoreLocationPins.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-07.
//

import SwiftUI

extension LocationPinsViewModel {
    // MARK: - PUBLIC FUNCTIONS
    /// Returns the top bar button text for the location pin list sheet.
    ///
    /// Changes based on whether update mode is active.
    func getLocationPinListSheetTopBarLeadingButtonText() -> String {
        canUpdateLocationPin ? "Cancel" : "Update"
    }
    
    /// Reorders location pins in the list.
    ///
    /// Updates the local array immediately for UI feedback,
    /// then saves the new order to the local database and refreshes the list.
    func onLocationPinListItemMove(_ from: IndexSet, to: Int) {
        var tempArray: [LocationPinsModel] = locationPinsArray
        
        tempArray.move(fromOffsets: from, toOffset: to)
        withAnimation { setLocationPinsArray(tempArray) }
        
        Task {
            do {
                try await locationPinManager.updateLocationPins(tempArray)
                try await fetchNSetLocationPins()
            } catch let error {
                Utilities.log(LocationPinsVMErrorModel.failedToMoveLocationPinListItem(error).errorDescription)
            }
        }
    }
    
    /// Deletes a location pin using its index in the list.
    ///
    /// Updates UI first, then removes it from the local database and refreshes the list.
    func onLocationPinListItemDelete(_ indexSet: IndexSet) {
        var tempArray: [LocationPinsModel] = locationPinsArray
        let locationPin: LocationPinsModel = tempArray[indexSet.first!]
        
        tempArray.remove(atOffsets: indexSet)
        withAnimation { setLocationPinsArray(tempArray) }
        
        Task {
            do {
                try await locationPinManager.deleteLocationPin(item: locationPin)
                try await fetchNSetLocationPins()
            } catch let error {
                Utilities.log(LocationPinsVMErrorModel.failedToMoveLocationPinListItem(error).errorDescription)
            }
        }
    }
    
    /// Deletes a specific location pin item.
    ///
    /// Updates UI first, then removes it from the local database and refreshes the list.
    func onLocationPinListItemDelete(_ item: LocationPinsModel) {
        var tempArray: [LocationPinsModel] = locationPinsArray
        
        tempArray.removeAll(where: { $0.id == item.id })
        withAnimation { setLocationPinsArray(tempArray) }
        
        Task {
            do {
                try await locationPinManager.deleteLocationPin(item: item)
                try await fetchNSetLocationPins()
            } catch let error {
                Utilities.log(LocationPinsVMErrorModel.failedToMoveLocationPinListItem(error).errorDescription)
            }
        }
    }
    
    /// Called when the location pin list sheet disappears.
    ///
    /// Resets update mode state.
    func onLocationPinListDisappear() {
        setCanUpdateLocationPin(false)
    }
    
    /// Toggles edit/update mode for the location pin list.
    func locationPinListTopLeadingButtonAction() {
        var temp: Bool = canUpdateLocationPin
        temp.toggle()
        setCanUpdateLocationPin(temp)
    }
    
    /// Handles tap on a location pin in the saved list.
    ///
    /// If markers already exist, opens multiple stops flow and prepares the pin
    /// on the secondary map. Otherwise, uses the primary map directly.
    func onLocationPinsListRowItemTap(_ item: LocationPinsModel) {
        setIsPresentedSavedLocationsSheet(false)
        
        guard mapVM.markers.isEmpty else {
            mapVM.setIsPresentedMultipleStopsMapSheet(true)
            Task { await mapVM.prepareSelectedLocationPinCoordinate(on: .secondary, item: item) }
            return
        }
        
        Task { await mapVM.prepareSelectedLocationPinCoordinate(on: .primary, item: item) }
    }
    
    /// Handles saved location sheet visibility changes.
    ///
    /// Resets sheet state when it is dismissed.
    func onSavedLocationSheetAppearance(_ isPresented: Bool) {
        guard !isPresented else { return }
        
        resetSavedLocationPinsSheet()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
    /// Resets all states related to the saved location pins sheet.
    private func resetSavedLocationPinsSheet() {
        setEditMode(.inactive)
        setCanUpdateLocationPin(false)
        setLocationPinNavigationPathsArray([])
    }
}
