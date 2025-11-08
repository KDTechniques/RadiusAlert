//
//  LocationPinsVM_AddNewLocationPin.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-07.
//

import Foundation

extension LocationPinsViewModel {
    func onAddNewLocationPinButtonTap() {
        guard mapVM.isBeyondMinimumDistance(),
              let centerCoordinate = mapVM.centerCoordinate,
              !locationPinsArray.contains(where: { $0.isSameCoordinate(centerCoordinate) }) else {
            // show an alert here  saying that the location pin already exist!
            alertManager.showAlert(.locationPinAlreadyExist)
            return
        }
        
        setNewLocationPinTextFieldText(mapVM.selectedSearchResult?.result.name ?? "")
        setNewLocationPinRadius(mapVM.selectedRadius)
        setNewLocationCoordinate(centerCoordinate)
        setIsPresentedLocationSavingSheet(true)
    }
    
    func createNewLocationPin() async {
        guard let coordinate = newLocationCoordinate else { return }
        
        let item: LocationPinsModel = .init(
            title: newLocationPinTextFieldText,
            radius: newLocationPinRadius,
            coordinate: coordinate
        )
        
        do {
            try await locationPinsManager.addLocationPins([item])
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
