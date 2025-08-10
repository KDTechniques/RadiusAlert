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
    
    private(set) var position: MapCameraPosition = .automatic
    private(set) var interactionModes: MapInteractionModes = [.all]
    var centerCoordinate: CLLocationCoordinate2D?
    var selectedRadius: CLLocationDistance { didSet { onRadiusChange() } }
    var markerCoordinate: CLLocationCoordinate2D? {
        didSet {
            locationManager.markerCoordinate = markerCoordinate
        }
    }
    var selectedMapStyle: MapStyleTypes = .standard
    var route: MKRoute?
    var searchText: String = "" { didSet { onSearchTextChange(searchText) } }
    var isSearchFieldFocused: Bool = false
    var popupCardItem: PopupCardModel?
    
    @ObservationIgnored var selectedSearchResult: MKMapItem?
    @ObservationIgnored private(set) var radiusAlertItem:RadiusAlertModel?
    @ObservationIgnored private(set) var isCameraDragging: Bool = false
    @ObservationIgnored var isRadiusSliderActive: Bool = false
    
    // MARK: - SETTERS
    func setRadiusAlertItem(_ item: RadiusAlertModel?) {
        radiusAlertItem = item
    }
    
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
    
    /// Positions the map region so that both coordinates are visible, centered at their midpoint.
    /// - Parameters:
    ///   - coordinate1: The first location coordinate.
    ///   - coordinate2: The second location coordinate.
    ///   - animate: Whether the map camera movement should be animated.
    func positionRegionBoundsToMidCoordinate(
        coordinate1: CLLocationCoordinate2D,
        coordinate2: CLLocationCoordinate2D,
        animate: Bool
    ) {
        // Calculate the distance between the two coordinates.
        let distance: CLLocationDistance = Utilities.getDistance(from: coordinate1, to: coordinate2)
        
        // Find the midpoint between the two coordinates.
        let midCoordinate: CLLocationCoordinate2D = Utilities.calculateMidCoordinate(from: coordinate1, and: coordinate2)
        
        // Determine the bounds size so both annotations are visible.
        let boundsMeters: CLLocationDistance = distance * mapValues.regionBoundsFactor
        
        // Create a region centered at the midpoint with the calculated bounds.
        let region: MKCoordinateRegion = .init(
            center: midCoordinate,
            latitudinalMeters: boundsMeters,
            longitudinalMeters: boundsMeters
        )
        
        // Update the map position with optional animation.
        setPosition(region: region, animate: animate)
    }
}
