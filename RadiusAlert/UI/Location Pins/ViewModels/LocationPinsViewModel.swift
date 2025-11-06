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
    let locationPinsManager: LocationPinsManager = .shared

    private(set) var horizontalPinButtonsHeight: CGFloat?
    private(set) var isPresentedSavedLocationsSheet: Bool = false
    private(set) var isPresentedLocationSavingSheet: Bool = false
    private(set) var locationPinsArray: [LocationPinsModel] = []
    private(set) var newLocationPinTextFieldText: String = ""
    private(set) var newLocationPinRadius: CLLocationDistance = .zero
    
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
    
    func setNewLocationPinTextFieldText(_ value: String) {
        newLocationPinTextFieldText = value
    }
    
    func setNewLocationPinRadius(_ value: CLLocationDistance) {
        newLocationPinRadius = value
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func initializeLocationPinsVM() async {
        // Fetch saved location pins from local database
        do {
            let locationPinsArray: [LocationPinsModel] = try await locationPinsManager.fetchLocationPins()
            setLocationPinsArray(locationPinsArray)
            print("location pins array: \(locationPinsArray)")
        } catch let error {
            print("Error Initializing Location Pins View Model. \(error.localizedDescription)")
        }
    }
    
    // MARK: - PUBLIC FUNCTIONS
    func addNewLocationPin(_ items: [LocationPinsModel]) async {
        do {
            try await locationPinsManager.addLocationPins(items)
        } catch {
            print("Error adding new location pin. \(error.localizedDescription)")
        }
    }
    
    func createLocationPin() -> LocationPinsModel? {
        guard let markerCoordinate = mapVM.markerCoordinate else { return nil }
        
        if let result = mapVM.selectedSearchResult {
            return .init(
                title: result.result.name ?? "",
                radius: mapVM.selectedRadius,
                coordinate: markerCoordinate
            )
        } else {
            return .init(
                title: "",
                radius: mapVM.selectedRadius,
                coordinate: markerCoordinate
            )
        }
    }
}
