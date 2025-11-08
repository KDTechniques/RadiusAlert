//
//  LocationPinsVM_MoreLocationPins.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-07.
//

import SwiftUI

extension LocationPinsViewModel {
    func getLocationPinListSheetTopBarLeadingButtonText() -> String {
        canRenameLocationPin ? "Cancel" : "Update"
    }
    
    func onLocationPinListItemMove(_ from: IndexSet, to: Int) {
        var tempArray: [LocationPinsModel] = locationPinsArray
        
        tempArray.move(fromOffsets: from, toOffset: to)
        withAnimation { setLocationPinsArray(tempArray) }
        
        Task {
            do {
                try await locationPinsManager.updateLocationPins(tempArray)
                try await fetchNSetLocationPins()
            } catch let error {
                Utilities.log(errorModel.failedToMoveLocationPinListItem(error).errorDescription)
            }
        }
    }
    
    func onLocationPinListItemDelete(_ indexSet: IndexSet) {
        var tempArray: [LocationPinsModel] = locationPinsArray
        let locationPin: LocationPinsModel = tempArray[indexSet.first!]
        
        tempArray.remove(atOffsets: indexSet)
        withAnimation { setLocationPinsArray(tempArray) }
        
        Task {
            do {
                try await locationPinsManager.deleteLocationPin(item: locationPin)
                try await fetchNSetLocationPins()
            } catch let error {
                Utilities.log(errorModel.failedToMoveLocationPinListItem(error).errorDescription)
            }
        }
    }
    
    func onLocationPinListDisappear() {
        setCanRenameLocationPin(false)
    }
    
    func locationPinListTopLeadingButtonAction() {
        var temp: Bool = canRenameLocationPin
        temp.toggle()
        setCanRenameLocationPin(temp)
    }
    
    func onLocationPinsListRowItemTap(_ item: LocationPinsModel) {
        setIsPresentedSavedLocationsSheet(false)
        mapVM.prepareSelectedSearchResultCoordinateOnMap(item)
    }
}
