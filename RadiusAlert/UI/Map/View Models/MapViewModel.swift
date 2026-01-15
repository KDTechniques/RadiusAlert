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
        initializeMapVM()
    }
    
    // MARK: - ASSIGNED PROPERTIES
    let mapValues: MapValues.Type = MapValues.self
    let radiusSliderTip: RadiusSliderTipModel = .init()
    @ObservationIgnored var cancellables: Set<AnyCancellable> = []
    
    // Managers/Services
    let locationManager: LocationManager = .shared
    let networkManager: NetworkManager = .shared
    let userDefaultsManager: UserDefaultsManager = .init()
    let memoryWarningsHandler: MemoryWarningHandler = .shared
    let alertManager: AlertManager = .shared
    let textToSpeechManager: TextToSpeechManager = .shared
    private(set) var locationSearchManager: LocationSearchManager = .init()
    let recentSearchManager: RecentSearchManager = .shared
    
    // Map state
    private(set) var position: MapCameraPosition = .automatic
    private(set) var interactionModes: MapInteractionModes = [.all]
    private(set) var centerCoordinate: CLLocationCoordinate2D?
    private(set) var selectedRadius: CLLocationDistance { didSet { onRadiusChange(selectedRadius) } }
    private(set) var markerCoordinate: CLLocationCoordinate2D? { didSet { onMarkerCoordinateChange(markerCoordinate) } }
    private(set) var routes: [MKRoute] = []
    @ObservationIgnored private(set) var isAuthorizedToGetMapCameraUpdate: Bool = false
    private(set) var addPinOrAddMultipleStops: AddPinOrAddMultipleStops = .addPin
    private(set) var multipleStopsMedium: MultipleStopMediums?
    
    // Search and UI state
    private(set) var searchText: String = "" { didSet { onSearchTextChange(searchText) } }
    private(set) var isSearchFieldFocused: Bool = false
    private(set) var popupCardItem: PopupCardModel?
    private(set) var isCameraDragging: Bool = false
    private(set) var sliderHeight: CGFloat?
    @ObservationIgnored private(set) var selectedSearchResult: SearchResultModel? { didSet { onSelectedSearchResultChange(selectedSearchResult) } }
    @ObservationIgnored private(set) var radiusAlertItem: RadiusAlertModel?
    @ObservationIgnored private(set) var isRadiusSliderActive: Bool = false
    private(set) var recentSearches: [RecentSearchModel] = []
    
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
    
    func setRoute(_ route: MKRoute) {
        routes.append(route)
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
    
    func setIsAuthorizedToGetMapCameraUpdate(_ value: Bool) {
        isAuthorizedToGetMapCameraUpdate = value
    }
    
    func setRecentSearches(_ value: [RecentSearchModel]) {
        recentSearches = value
    }
    
    func setAddPinOrAddMultipleStops(_ value: AddPinOrAddMultipleStops) {
        addPinOrAddMultipleStops = value
    }
    
    func setMultipleStopsMedium(_ value: MultipleStopMediums?) {
        multipleStopsMedium = value
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
    
    func clearRoutes() {
        routes = []
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
    private func initializeMapVM() {
        authorizationStatusSubscriber()
        clearMemoryByMapStyles()
        fetchNAssignRecentSearches()
    }
}

