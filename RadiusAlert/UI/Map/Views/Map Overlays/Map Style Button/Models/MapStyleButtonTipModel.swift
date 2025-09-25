//
//  MapStyleButtonTipModel.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-25.
//

import TipKit

struct MapStyleButtonTipModel: Tip {
    static let startAlertEvent: Event = .init(id: "startAlertEvent")
    
    var title: Text {
        Text("Choose a Map Style")
    }
    
    var message: Text? {
        Text("Map styles are great if you want to see things in 3D on the map.")
    }
    
    var rules: [Rule] { [
        #Rule(Self.startAlertEvent) { $0.donations.count >= 5 }
    ] }
}
