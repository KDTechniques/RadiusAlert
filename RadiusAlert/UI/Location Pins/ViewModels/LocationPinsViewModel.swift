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
    private(set) var newLocationCoordinate: CLLocationCoordinate2D?
    
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
    
    func setNewLocationCoordinate(_ value: CLLocationCoordinate2D?) {
        newLocationCoordinate = value
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func initializeLocationPinsVM() async {
        // Fetch saved location pins from local database
        do {
            let locationPinsArray: [LocationPinsModel] = try await locationPinsManager.fetchLocationPins()
            setLocationPinsArray(locationPinsArray)
            
            for item in locationPinsArray {
                print("\n\(item.order) | \(item.title) | \(item.radius) | \(item.getCoordinate())" )
            }
            
        } catch let error {
            print("Error Initializing Location Pins View Model. \(error.localizedDescription)")
        }
    }
    
    // MARK: - PUBLIC FUNCTIONS
    
    func onAddNewLocationPinButtonTapped() {
        guard mapVM.isBeyondMinimumDistance(),
              let centerCoordinate = mapVM.centerCoordinate else { return }
        
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
            print("Error creating a new location pin. \(error.localizedDescription)")
        }
    }
}
