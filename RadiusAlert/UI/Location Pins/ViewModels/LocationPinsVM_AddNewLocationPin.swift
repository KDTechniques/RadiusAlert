//
//  LocationPinsVM_AddNewLocationPin.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-07.
//

import SwiftUI

extension LocationPinsViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
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
    
    func onAddNewLocationPinSaveButtonTap() {
        Task {
            await createNewLocationPin()
            setIsPresentedLocationSavingSheet(false)
            try? await fetchNSetLocationPins()
            try? await Task.sleep(nanoseconds: .seconds(0.8))
            setScrollPositionID(scrollableHorizontalLocationPinsContentID)
        }
    }
    
    func onPopupCardLocationPinTap(_ item: LocationPinsModel) async throws {
        try await addLocationPin(item)
        try? await fetchNSetLocationPins()
    }
    
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
    
    private func createNewLocationPin() async {
        guard let coordinate = newLocationCoordinate else { return }
        
        let item: LocationPinsModel = .init(
            title: newLocationPinTextFieldText,
            radius: newLocationPinRadius,
            coordinate: coordinate
        )
        
        try? await addLocationPin(item)
    }
    
    private func addLocationPin(_ item: LocationPinsModel) async throws {
        do {
            try await locationPinManager.addLocationPin(item)
        } catch let error {
            Utilities.log(LocationPinsVMErrorModel.failedToCreateNewLocationPin(error).errorDescription)
            throw error
        }
    }
}
