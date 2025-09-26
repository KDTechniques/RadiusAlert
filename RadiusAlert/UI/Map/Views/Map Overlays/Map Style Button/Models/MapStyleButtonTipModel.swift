//
//  MapStyleButtonTipModel.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-25.
//

import TipKit

struct MapStyleButtonTipModel: Tip {
    @Parameter(.transient)
    static var isMapStyleButtonVisible: Bool = false
    
    @Parameter(.transient)
    static var isOnMapView: Bool = false
    
    static let startAlertEvent: Event = .init(id: "startAlertEvent")
    
    var title: Text {
        Text("Choose a Map Style")
    }
    
    var message: Text? {
        Text("Map styles are useful if you want to view the map in 3D.")
    }
    
    var rules: [Rule] { [
        #Rule(Self.startAlertEvent) { $0.donations.count >= 5 },
        #Rule(Self.$isMapStyleButtonVisible) { $0 },
        #Rule(Self.$isOnMapView) { $0 }
    ] }
}
