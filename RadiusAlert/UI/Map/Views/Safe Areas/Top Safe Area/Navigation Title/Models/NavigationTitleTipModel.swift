//
//  NavigationTitleTipModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-09-24.
//

import Foundation

import TipKit

struct NavigationTitleTipModel: Tip {
    static let startAlertEvent: Event = .init(id: "startAlertEvent")
    
    var title: Text {
        Text("Learn More & Settings")
    }
    
    var message: Text? {
        Text("Tap here to learn more about this app and settings.")
    }
    
    var image: Image? {
        Image(systemName: "hand.rays")
            .symbolRenderingMode(.hierarchical)
    }
    
    var rules: [Rule] { [
        #Rule(Self.startAlertEvent) { $0.donations.count >= 3 }
    ] }
}

