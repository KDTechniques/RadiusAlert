//
//  LocationPinsVM_AddNewLocationPin.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-07.
//

import Foundation

extension LocationPinsViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    func onAddNewLocationPinButtonTap() {
        // Basic Validations
        guard let centerCoordinate = mapVM.primaryCenterCoordinate else { return }
        
        // Get Existing Item If Available
        let existingItem: LocationPinsModel? = locationPinsArray.first(where: { $0.isSameCoordinate(centerCoordinate) })
        
        if let item: LocationPinsModel = existingItem { // If Item Already Exist, Show An Alert
            alertManager.showAlert(.locationPinAlreadyExist(viewLevel: .content) {
                self.setLocationPinNavigationPathsArray([item])
                self.setIsPresentedSavedLocationsSheet(true)
            })
        } else {  // If No Item Available, Prepare a Sheet for Adding a New Location Pin
            
            setNewLocationPinTextFieldText(mapVM.selectedSearchResult?.result.name ?? "")
            setNewLocationPinRadius(mapVM.primarySelectedRadius)
            setNewLocationCoordinate(centerCoordinate)
            setIsPresentedLocationSavingSheet(true)
        }
    }
    
    func createNewLocationPin() async {
        guard let coordinate = newLocationCoordinate else { return }
        
        let item: LocationPinsModel = .init(
            title: newLocationPinTextFieldText,
            radius: newLocationPinRadius,
            coordinate: coordinate
        )
        
        do {
            try await locationPinManager.addLocationPins([item])
        } catch let error {
            Utilities.log(errorModel.failedToCreateNewLocationPin(error).errorDescription)
        }
    }
    
    func onAddNewLocationPinSaveButtonTap() {
        Task {
            await createNewLocationPin()
            setIsPresentedLocationSavingSheet(false)
            try? await fetchNSetLocationPins()
            try? await Task.sleep(nanoseconds: 800_000_000)
            setScrollPositionID(scrollableHorizontalLocationPinsContentID)
        }
    }
}
