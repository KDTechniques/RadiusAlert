//
//  NavigationTitleTipModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-09-24.
//

import Foundation

import TipKit

struct NavigationTitleTipModel: Tip {
    var title: Text { .init("Learn More & Settings") }
    var message: Text? { .init("Tap here to learn more about this app and settings.") }
    
    var image: Image? {
        .init(systemName: "hand.rays")
        .symbolRenderingMode(.hierarchical)
    }
    
    static let startAlertEvent: Event = .init(id: "startAlertEvent")
    
    var rules: [Rule] { [
        #Rule(Self.startAlertEvent) { $0.donations.count >= 3 }
    ] }
}

