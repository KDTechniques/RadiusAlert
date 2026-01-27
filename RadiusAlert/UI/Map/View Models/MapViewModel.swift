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
        primarySelectedRadius = mapValues.minimumRadius
        primarySelectedRadius$ = mapValues.minimumRadius
        secondarySelectedRadius = mapValues.minimumRadius
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
    
    // Main Map Related
    private(set) var primaryPosition: MapCameraPosition = .automatic
    private(set) var primaryCenterCoordinate: CLLocationCoordinate2D?
    
    private(set) var primarySelectedRadius: CLLocationDistance { didSet { primarySelectedRadius$ = primarySelectedRadius } }
    @ObservationIgnored @Published private(set) var primarySelectedRadius$: CLLocationDistance
    
    private(set) var isPrimaryCameraDragging: Bool = false { didSet { isPrimaryCameraDragging$ = isPrimaryCameraDragging } }
    @ObservationIgnored @Published private(set) var isPrimaryCameraDragging$: Bool = false
    
    private(set) var interactionModes: MapInteractionModes = [.all]
    @ObservationIgnored private(set) var isAuthorizedToGetMapCameraUpdate: Bool = false
    
    // Search and UI Related
    private(set) var searchText: String = "" { didSet { onSearchTextChange(searchText) } }
    private(set) var isSearchFieldFocused: Bool = false
    private(set) var popupCardItem: PopupCardModel?
    private(set) var sliderHeight: CGFloat?
    @ObservationIgnored private(set) var selectedSearchResult: SearchResultModel? { didSet { onSelectedSearchResultChange(selectedSearchResult) } }
    @ObservationIgnored private(set) var radiusAlertItem: RadiusAlertModel?
    private(set) var recentSearches: [RecentSearchModel] = []
    private(set) var distanceText: CLLocationDistance = .zero
    
    // Multiple Stops Map Related
    private(set) var addPinOrAddMultipleStops: AddPinOrAddMultipleStops = .addPin
    private(set) var multipleStopsMedium: MultipleStopMediums? { didSet { multipleStopsMedium$ = multipleStopsMedium } }
    @ObservationIgnored @Published private(set) var multipleStopsMedium$: MultipleStopMediums?
    private(set) var markers: [MarkerModel] = []
    private(set) var secondaryPosition: MapCameraPosition = .automatic
    private(set) var secondaryCenterCoordinate: CLLocationCoordinate2D?
    private(set) var secondarySelectedRadius: CLLocationDistance
    private(set) var isSecondaryCameraDragging: Bool = false
    
    // MARK: - SETTERS
    
    func setInteractionModes(_ modes: MapInteractionModes) {
        interactionModes = modes
    }
    
    func setPrimaryCameraDragging(_ boolean: Bool) {
        isPrimaryCameraDragging = boolean
    }
    
    func setSecondaryCameraDragging(_ boolean: Bool) {
        isSecondaryCameraDragging = boolean
    }
    
    func setPrimaryPosition(_ position: MapCameraPosition) {
        primaryPosition = position
    }
    
    func setSecondaryPosition(_ position: MapCameraPosition) {
        secondaryPosition = position
    }
    
    func setPrimaryPosition(region: MKCoordinateRegion, animate: Bool) async {
        withAnimation(animate ? .default : .none) {
            primaryPosition = .region(region)
        }
        
        try? await Task.sleep(nanoseconds: 800_000_000)
    }
    
    func setSecondaryPosition(region: MKCoordinateRegion, animate: Bool) async {
        withAnimation(animate ? .default : .none) {
            secondaryPosition = .region(region)
        }
        
        try? await Task.sleep(nanoseconds: 800_000_000)
    }
    
    func setSearchFieldFocused(_ boolean: Bool) {
        isSearchFieldFocused = boolean
    }
    
    func setPrimaryCenterCoordinate(_ center: CLLocationCoordinate2D?) {
        primaryCenterCoordinate = center
    }
    
    func setSecondaryCenterCoordinate(_ center: CLLocationCoordinate2D?) {
        secondaryCenterCoordinate = center
    }
    
    func setPrimarySelectedRadius(_ radius: CLLocationDistance) {
        primarySelectedRadius = radius
    }
    
    func setSecondarySelectedRadius(_ radius: CLLocationDistance) {
        secondarySelectedRadius = radius
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
    
    func setDistanceText(_ value: CLLocationDistance) {
        distanceText = value
    }
    
    func addMarker(_ value: MarkerModel) {
        // Following logic must be isolated to another function except the setter.
        guard !markers.contains(where: { $0.id == value.id }) else { return }
        
        var marker = value
        
        if markers.isEmpty {
            marker.color = .pink
        }
        
        markers.append(marker)
    }
    
    func updateMarker(at id: String, value: MarkerModel) {
        guard let index: Int = markers.firstIndex(where: { $0.id == id }) else { return }
        markers[index] = value
    }
    
    func clearAllMarkers() {
        markers.removeAll()
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
    
    // MARK: - PRIVATE FUNCTIONS
    
    private func initializeMapVM() {
        authorizationStatusSubscriber()
        clearMemoryByMapStyles()
        fetchNAssignRecentSearches()
        multipleStopsMedium_IsCameraDraggingSubscriber()
        currentUserLocationSubscriber()
        primarySelectedRadiusSubscriber()
    }
}

