//
//  MapViewModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-31.
//

import SwiftUI
import MapKit

@Observable
final class MapViewModel {
    // MARK: - INITIALIZER
    init() {
        selectedRadius = mapValues.minimumRadius
    }
    
    // MARK: - ASSIGNED PROPERTIES
    let locationManager: LocationManager = .shared
    var locationSearchManager: LocationSearchManager = .init()
    let alertManager: AlertManager = .shared
    let mapValues: MapValues.Type = MapValues.self
    
    var position: MapCameraPosition = .automatic
    var interactionModes: MapInteractionModes = [.all]
    var centerCoordinate: CLLocationCoordinate2D?
    var selectedRadius: CLLocationDistance { didSet { onRadiusChange() } }
    var markerCoordinate: CLLocationCoordinate2D? { didSet { locationManager.markerCoordinate = markerCoordinate } }
    var selectedMapStyle: MapStyleTypes = .standard
    var route: MKRoute?
    var searchText: String = "" { didSet { onSearchTextChange(searchText) } }
    var isSearchFieldFocused: Bool = false
    var popupCardItem: PopupCardModel?
    
    @ObservationIgnored var selectedSearchResult: MKMapItem?
    @ObservationIgnored private(set) var radiusAlertItem:RadiusAlertModel?
    @ObservationIgnored var isCameraDragging: Bool = false
    @ObservationIgnored var isRadiusSliderActive: Bool = false
    
    // MARK: - PUBLIC FUNCTIONS
    func setRadiusAlertItem(_ item: RadiusAlertModel?) {
        radiusAlertItem = item
    }
}
