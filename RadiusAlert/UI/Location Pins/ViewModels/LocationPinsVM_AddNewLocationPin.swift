//
//  LocationPinsVM_AddNewLocationPin.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-07.
//

import SwiftUI

extension LocationPinsViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    /// Handles tap on the "Add New Location Pin" button.
    ///
    /// First checks if the map has a valid center coordinate.
    /// If a pin already exists at that location, an alert is shown and the user is
    /// taken to the existing pin.
    ///
    /// If no pin exists, it prepares the data for creating a new location pin
    /// and presents the save sheet.
    ///
    /// - Note: Prevents duplicate pins from being created at the same coordinate.
    func onAddNewLocationPinButtonTap() {
        // Basic Validations
        guard let centerCoordinate = mapVM.primaryCenterCoordinate else { return }
        
        // Get Existing Item If Available
        let existingItem: LocationPinsModel? = locationPinsArray.first(where: { $0.isSameCoordinate(centerCoordinate) })
        
        if let item: LocationPinsModel = existingItem { // If Item Already Exist, Show An Alert
            alertManager.showAlert(.locationPinAlreadyExist(viewLevel: .content) { [weak self] in
                guard let self else { return }
                setLocationPinNavigationPathsArray([item])
                setIsPresentedSavedLocationsSheet(true)
            })
        } else {  // If No Item Available, Prepare a Sheet for Adding a New Location Pin
            setNewLocationPinTextFieldText(mapVM.selectedSearchResult?.result.name ?? "")
            setNewLocationPinRadius(mapVM.primarySelectedRadius)
            setNewLocationCoordinate(centerCoordinate)
            setIsPresentedLocationSavingSheet(true)
        }
    }
    
    /// Handles tap on the "Save" button when creating a new location pin.
    ///
    /// Creates and saves a new location pin, closes the save sheet,
    /// refreshes the pins list, and scrolls to the updated pins section.
    ///
    /// - Note: Adds a short delay to ensure the UI updates smoothly before scrolling.
    func onAddNewLocationPinSaveButtonTap() {
        Task {
            await createNewLocationPin()
            setIsPresentedLocationSavingSheet(false)
            try? await fetchNSetLocationPins()
            try? await Task.sleep(nanoseconds: .seconds(0.8))
            setScrollPositionID(scrollableHorizontalLocationPinsContentID)
        }
    }
    
    /// Handles tap on a location pin from a popup card.
    ///
    /// Adds the selected location pin to the map and refreshes the pins list.
    ///
    /// - Parameter item: The selected location pin.
    /// - Throws: An error if adding the location pin fails.
    func onPopupCardLocationPinTap(_ item: LocationPinsModel) async throws {
        try await addLocationPin(item)
        try? await fetchNSetLocationPins()
    }
    
    /// Handles tap on a popup card and creates a saved location pin.
    ///
    /// Extracts required data from the popup card and map marker, then creates a new
    /// location pin and saves it.
    ///
    /// On success, triggers success callback and success haptic feedback.
    /// On failure, triggers failure callback and warning haptic feedback.
    ///
    /// - Parameters:
    ///   - item: The popup card data.
    ///   - success: Called when the pin is created successfully.
    ///   - failure: Called when the operation fails.
    func onPopupCardPinTap(
        item: PopupCardModel,
        success: @escaping () -> Void,
        failure: @escaping () -> Void)
    {
        Task {
            guard
                let title: String = item.locationTitle,
                let marker: MarkerModel = mapVM.getMarkerObject(on: item.markerID) else { return }
            
            let item: LocationPinsModel = .init(
                title: title,
                radius: marker.radius,
                coordinate: marker.coordinate
            )
            
            do {
                try await onPopupCardLocationPinTap(item)
                success()
                await hapticManager.hapticFeedback(type: .success)
            } catch {
                failure()
                await hapticManager.hapticFeedback(type: .warning)
            }
        }
    }
    
    // MARK: - PRIVATER FUNCTIONS
    
    /// Creates and saves a new location pin using the currently selected data.
    ///
    /// Builds a new location pin from the user input (title, radius, and coordinate)
    /// and saves it to the local database.
    ///
    /// If the coordinate is missing, the operation is skipped.
    private func createNewLocationPin() async {
        guard let coordinate = newLocationCoordinate else { return }
        
        let item: LocationPinsModel = .init(
            title: newLocationPinTextFieldText,
            radius: newLocationPinRadius,
            coordinate: coordinate
        )
        
        try? await addLocationPin(item)
    }
    
    /// Adds a new location pin to the local database.
    ///
    /// Saves the provided location pin using the location pin manager.
    /// If the operation fails, the error is logged and rethrown.
    ///
    /// - Parameter item: The location pin to be saved.
    /// - Throws: An error if the pin cannot be added.
    private func addLocationPin(_ item: LocationPinsModel) async throws {
        do {
            try await locationPinManager.addLocationPin(item)
        } catch let error {
            Utilities.log(LocationPinsVMErrorModel.failedToCreateNewLocationPin(error).errorDescription)
            throw error
        }
    }
}
