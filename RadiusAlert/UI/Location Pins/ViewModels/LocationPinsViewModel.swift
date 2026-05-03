//
//  LocationPinsViewModel.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-03.
//

import SwiftUI
import CoreLocation

@Observable
final class LocationPinsViewModel {
    // MARK: - INJECTRED PROPERTIES
    let mapVM: MapViewModel
    
    // MARK: - ASSIGNED PROPERTIES
    
    // Managers/Services/Models:
    let locationPinManager: LocationPinManager = .shared
    let alertManager: AlertManager = .shared
    let hapticManager: HapticManager = .shared
    
    private(set) var horizontalPinButtonsHeight: CGFloat?
    private(set) var locationPinsArray: [LocationPinsModel] = [] { didSet { onLocationPinsArrayChange() } }
    let locationPinTitleMaxCharacterCount: Int = 20
    
    // New Location Pin:
    private(set) var isPresentedLocationSavingSheet: Bool = false
    private(set) var newLocationPinTextFieldText: String = ""
    private(set) var newLocationPinRadius: CLLocationDistance = MapValues.minimumRadius
    private(set) var newLocationCoordinate: CLLocationCoordinate2D?
    private(set) var scrollPositionID: String?
    let scrollableHorizontalLocationPinsContentID: String = "last"
    
    // Location Pin List:
    private(set) var isPresentedSavedLocationsSheet: Bool = false { didSet { onSavedLocationSheetAppearance(isPresentedSavedLocationsSheet) } }
    private(set) var locationPinNavigationPathsArray: [LocationPinsModel] = []
    private(set) var editMode: EditMode = .inactive
    private(set) var canUpdateLocationPin: Bool = false
    
    // MARK: - INITIALIZER
    init(mapVM: MapViewModel) {
        self.mapVM = mapVM
        Task { await initializeLocationPinsVM() }
    }
    
    // MARK: - SETTERS
    func setHorizontalPinButtonsHeight(_ value: CGFloat) {
        horizontalPinButtonsHeight = value
    }
    
    func setIsPresentedSavedLocationsSheet(_ value: Bool) {
        isPresentedSavedLocationsSheet = value
    }
    
    func setIsPresentedLocationSavingSheet(_ value: Bool) {
        isPresentedLocationSavingSheet = value
    }
    
    func setLocationPinsArray(_ value: [LocationPinsModel]) {
        locationPinsArray = value
    }
    
    func insertToLocationPinsArray(index: Int, with value: LocationPinsModel) {
        locationPinsArray[index] = value
    }
    
    func setNewLocationPinTextFieldText(_ value: String) {
        newLocationPinTextFieldText = value
    }
    
    func setNewLocationPinRadius(_ value: CLLocationDistance) {
        newLocationPinRadius = value
    }
    
    func setNewLocationCoordinate(_ value: CLLocationCoordinate2D?) {
        newLocationCoordinate = value
    }
    
    func setScrollPositionID(_ value: String?) {
        scrollPositionID = value
    }
    
    func setEditMode(_ value: EditMode) {
        editMode = value
    }
    
    func setCanUpdateLocationPin(_ value: Bool) {
        canUpdateLocationPin = value
    }
    
    func setLocationPinNavigationPathsArray(_ value: [LocationPinsModel]) {
        locationPinNavigationPathsArray = value
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func initializeLocationPinsVM() async {
        // Fetch saved location pins from local database
        do {
            try await fetchNSetLocationPins()
        } catch let error {
            Utilities.log(LocationPinsVMErrorModel.failedToInitializeLocationPinsVM(error).errorDescription)
        }
    }
    
    /// Handles changes to the saved location pins array.
    ///
    /// If all pins are removed, this ensures related UI states are reset,
    /// including closing the saved locations sheet and exiting edit mode.
    ///
    /// Helps prevent UI inconsistencies when the pins list becomes empty.
    private func onLocationPinsArrayChange() {
        if locationPinsArray.isEmpty {
            setIsPresentedSavedLocationsSheet(false)
            setEditMode(.inactive)
        }
    }
    
    // MARK: - PUBLIC FUNCTIONS
    
    /// Fetches saved location pins and updates the app state.
    ///
    /// Loads all saved pins from the local database and updates the UI with animation.
    /// If the fetch fails, the error is logged and rethrown.
    ///
    /// - Throws: An error if location pins cannot be fetched.
    func fetchNSetLocationPins() async throws {
        do {
            let locationPinsArray: [LocationPinsModel] = try await locationPinManager.fetchLocationPins()
            withAnimation { setLocationPinsArray(locationPinsArray) }
        } catch let error {
            Utilities.log(LocationPinsVMErrorModel.failedToFetchNSetLocationPinArray(error).errorDescription)
            throw error
        }
    }
    
    /// Handles tap on a saved location pin in the horizontal scroll list.
    ///
    /// If there are no existing markers, the pin is directly selected on the primary map
    /// and processed like a normal marker.
    ///
    /// If markers already exist, the multiple stops sheet is shown first,
    /// and the pin is prepared on the secondary map. The user can then add it manually
    /// like a regular marker.
    ///
    /// - Parameter item: The selected saved location pin.
    func onScrollableHorizontalLocationPinButtonTap(_ item: LocationPinsModel) {
        if mapVM.markers.isEmpty {
            Task {
                await mapVM.prepareSelectedLocationPinCoordinate(on: .primary, item: item)
            }
        } else {
            let nanoSeconds: UInt64 = mapVM.isPresentedMultipleStopsMapSheet ? 0 : .seconds(0.5)
            
            /// Show multiple stops sheet and prepare on secondary map.
            /// User can then add it as a normal marker.
            mapVM.setIsPresentedMultipleStopsMapSheet(true)
            
            Task {
                try? await Task.sleep(nanoseconds: nanoSeconds)
                await mapVM.prepareSelectedLocationPinCoordinate(on: .secondary, item: item)
            }
        }
    }
}

