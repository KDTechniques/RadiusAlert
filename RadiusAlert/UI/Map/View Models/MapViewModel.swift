//
//  MapViewModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-31.
//

import SwiftUI
import MapKit
import Combine

@Observable
final class MapViewModel {
    // MARK: - INJKECTED PROPERTIES
    let settingsVM: SettingsViewModel
    
    // MARK: - INITIALIZER
    init(settingsVM: SettingsViewModel) {
        self.settingsVM = settingsVM
        selectedRadius = mapValues.minimumRadius
        authorizationStatusPublisher()
        clearMemoryByMapStyles()
    }
    
    // MARK: - ASSIGNED PROPERTIES
    let locationManager: LocationManager = .shared
    let networkManager: NetworkManager = .shared
    let memoryWarningsHandler: MemoryWarningHandler = .shared
    private(set) var locationSearchManager: LocationSearchManager = .init()
    let alertManager: AlertManager = .shared
    let mapValues: MapValues.Type = MapValues.self
    
    private(set) var position: MapCameraPosition = .automatic
    private(set) var interactionModes: MapInteractionModes = [.all]
    private(set) var centerCoordinate: CLLocationCoordinate2D?
    private(set) var selectedRadius: CLLocationDistance { didSet { onRadiusChange() } }
    private(set) var markerCoordinate: CLLocationCoordinate2D? { didSet { onMarkerCoordinateChange(markerCoordinate) } }
    private(set) var route: MKRoute?
    private(set) var searchText: String = "" { didSet { onSearchTextChange(searchText) } }
    private(set) var isSearchFieldFocused: Bool = false
    private(set) var popupCardItem: PopupCardModel?
    private(set) var isCameraDragging: Bool = false
    private(set) var sliderHeight: CGFloat?
    
    @ObservationIgnored private(set) var isAuthorizedToGetMapCameraUpdate: Bool = false
    @ObservationIgnored private var cancellables: Set<AnyCancellable> = []
    @ObservationIgnored private(set) var selectedSearchResult: MKMapItem?
    @ObservationIgnored private(set) var radiusAlertItem: RadiusAlertModel?
    @ObservationIgnored private(set) var isRadiusSliderActive: Bool = false
    
    // MARK: - PUBLISHERS
    func authorizationStatusPublisher() {
        locationManager.$authorizationStatus$
            .dropFirst()
            .removeDuplicates()
            .sink { [weak self] in
                guard let self else { return }
                isAuthorizedToGetMapCameraUpdate = ($0 == .authorizedAlways || $0 == .authorizedWhenInUse)
                
                guard isAuthorizedToGetMapCameraUpdate else { return }
                
                Task { @MainActor  [weak self] in
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                    self?.positionToInitialUserLocation()
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - SETTERS
    func setInteractionModes(_ modes: MapInteractionModes) {
        interactionModes = modes
    }
    
    func setCameraDragging(_ boolean: Bool) {
        isCameraDragging = boolean
    }
    
    func setPosition(region: MKCoordinateRegion, animate: Bool) {
        withAnimation(animate ? .default : .none) {
            position = .region(region)
        }
    }
    
    func setPosition(_ position: MapCameraPosition) {
        self.position = position
    }
    
    func setSearchFieldFocused(_ boolean: Bool) {
        isSearchFieldFocused = boolean
    }
    
    func setCenterCoordinate(_ center: CLLocationCoordinate2D) {
        centerCoordinate = center
    }
    
    func setSelectedRadius(_ radius: CLLocationDistance) {
        selectedRadius = radius
    }
    
    func setMarkerCoordinate(_ marker: CLLocationCoordinate2D?) {
        markerCoordinate =  marker
    }
    
    func setRoute(_ route: MKRoute?) {
        self.route = route
    }
    
    func setSearchText(_ text: String) {
        searchText = text
    }
    
    func setPopupCardItem(_ item: PopupCardModel?) {
        popupCardItem = item
    }
    
    func setRadiusAlertItem(_ item: RadiusAlertModel?) {
        radiusAlertItem = item
    }
    
    func setSelectedSearchResult(_ item: MKMapItem?) {
        selectedSearchResult = item
    }
    
    func setRadiusSliderActiveState(_ boolean: Bool) {
        isRadiusSliderActive = boolean
    }
    
    func setSliderHeight(_ value: CGFloat) {
        sliderHeight = value
    }
    
    // MARK: - PUBLIC FUNCTIONS
    func getNavigationTitleIconColor() -> Color {
        networkManager.connectionState == .connected
        ? .primary
        : .init(uiColor: .systemGray5)
    }
}
