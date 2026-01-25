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
    let errorModel = LocationPinsVMErrorModel.self
    
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
#if DEBUG
            for item in locationPinsArray {
                print("\n\(item.order) | \(item.title) | \(item.radius) | \(item.coordinate)" )
            }
            print("\n\n")
#endif
        } catch let error {
            Utilities.log(errorModel.failedToInitializeLocationPinsVM(error).errorDescription)
        }
    }
    
    private func onLocationPinsArrayChange() {
        if locationPinsArray.isEmpty {
            setIsPresentedSavedLocationsSheet(false)
            setEditMode(.inactive)
        }
    }
    
    // MARK: - PUBLIC FUNCTIONS
    
    func fetchNSetLocationPins() async throws {
        do {
            let locationPinsArray: [LocationPinsModel] = try await locationPinManager.fetchLocationPins()
            withAnimation { setLocationPinsArray(locationPinsArray) }
        } catch let error {
            Utilities.log(errorModel.failedToFetchNSetLocationPinArray(error).errorDescription)
            throw error
        }
    }
    
    func onScrollableHorizontalLocationPinButtonTap(_ item: LocationPinsModel) {
//        guard mapVM.isMarkerCoordinateNil() else {
//            alertManager.showAlert(.stopAlertOnSubmit {
//                self.mapVM.stopAlert()
//                self.mapVM.prepareSelectedLocationPinCoordinateOnMap(item)
//            })
//            return
//        }
//        
//        mapVM.prepareSelectedLocationPinCoordinateOnMap(item)
    }
}

