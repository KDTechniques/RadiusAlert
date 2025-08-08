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
    let alertManager: AlertManager = .shared
    let mapValues: MapValues.Type = MapValues.self
    
    var position: MapCameraPosition = .automatic
    var interactionModes: MapInteractionModes = [.all]
    var centerCoordinate: CLLocationCoordinate2D?
    var selectedRadius: CLLocationDistance { didSet { onRadiusChange() } }
    var markerCoordinate: CLLocationCoordinate2D? { didSet { locationManager.markerCoordinate = markerCoordinate } }
    var selectedMapStyle: MapStyleTypes = .standard
    var route: MKRoute?
    var searchText: String = "" { didSet { onSearchTextChange() } }
    var searchResults: [MKMapItem]?
    var isSearching: Bool = false
    var isSearchFieldFocused: Bool = false
    
    @ObservationIgnored var searchQueryTask: Task<Void, Never>?
    @ObservationIgnored var isCameraDragging: Bool = false
    @ObservationIgnored var isRadiusSliderActive: Bool = false
    
    // MARK: - PUBLIC FUNCTIONS
    func calculateMidCoordinate(from coord1: CLLocationCoordinate2D, and coord2: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        let midLatitude = (coord1.latitude + coord2.latitude) / 2
        let midLongitude = (coord1.longitude + coord2.longitude) / 2
        
        return .init(latitude: midLatitude, longitude: midLongitude)
    }
}
