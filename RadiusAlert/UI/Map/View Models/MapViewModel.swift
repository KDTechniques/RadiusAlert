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
        authorizationStatusSubscriber()
        clearMemoryByMapStyles()
    }
    
    // MARK: - ASSIGNED PROPERTIES
    let mapValues: MapValues.Type = MapValues.self
    let radiusSliderTip: RadiusSliderTipModel = .init()
    @ObservationIgnored var cancellables: Set<AnyCancellable> = []
    
    // Managers/Services
    let locationManager: LocationManager = .shared
    let networkManager: NetworkManager = .shared
    let memoryWarningsHandler: MemoryWarningHandler = .shared
    let alertManager: AlertManager = .shared
    private(set) var locationSearchManager: LocationSearchManager = .init()
    
    // Map state
    private(set) var position: MapCameraPosition = .automatic
    private(set) var interactionModes: MapInteractionModes = [.all]
    private(set) var centerCoordinate: CLLocationCoordinate2D?
    private(set) var selectedRadius: CLLocationDistance { didSet { onRadiusChange(selectedRadius) } }
    private(set) var markerCoordinate: CLLocationCoordinate2D? { didSet { onMarkerCoordinateChange(markerCoordinate) } }
    private(set) var route: MKRoute?
    @ObservationIgnored private(set) var isAuthorizedToGetMapCameraUpdate: Bool = false
    
    // Search and UI state
    private(set) var searchText: String = "" { didSet { onSearchTextChange(searchText) } }
    private(set) var isSearchFieldFocused: Bool = false
    private(set) var popupCardItem: PopupCardModel?
    private(set) var isCameraDragging: Bool = false
    private(set) var sliderHeight: CGFloat?
    @ObservationIgnored private(set) var selectedSearchResult: SearchResultModel? { didSet { onSelectedSearchResultChange(selectedSearchResult) } }
    
    @ObservationIgnored private(set) var radiusAlertItem: RadiusAlertModel?
    @ObservationIgnored private(set) var isRadiusSliderActive: Bool = false
 
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
    
    func setSelectedSearchResult(_ item: SearchResultModel?) {
        selectedSearchResult = item
    }
    
    func setRadiusSliderActiveState(_ boolean: Bool) {
        isRadiusSliderActive = boolean
    }
    
    func setSliderHeight(_ value: CGFloat) {
        sliderHeight = value
    }
    
    func set_IsAuthorizedToGetMapCameraUpdate(_ value: Bool) {
        isAuthorizedToGetMapCameraUpdate = value
    }
    
    func set_cancellables(_ value: Set<AnyCancellable>) {
        cancellables = value
    }
    
    // MARK: - PUBLIC FUNCTIONS
    
    func getNavigationTitleIconColor() -> Color {
        networkManager.connectionState == .connected
        ? .primary
        : .init(uiColor: .systemGray5)
    }
    
    func onMapViewAppear() {
        MapStyleButtonTipModel.isOnMapView = true
    }
    
    func onMapViewDisappear() {
        MapStyleButtonTipModel.isOnMapView = false
    }
}

