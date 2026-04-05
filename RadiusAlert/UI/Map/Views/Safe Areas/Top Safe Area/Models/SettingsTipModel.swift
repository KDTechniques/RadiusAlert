//
//  SettingsTipModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-09-24.
//

import TipKit

struct SettingsTipModel: Tip {
    // Presentation
    var title: Text { .init("Learn More & Settings") }
    var message: Text? { .init("Tap here to learn more about this app and settings.") }
    var image: Image? {
        .init(systemName: "hand.rays")
        .symbolRenderingMode(.hierarchical)
    }
    
    // Conditional Parameters
    @Parameter(.transient) static var markersCount: Int = 0
    @Parameter(.transient) static var isPresentedSheet: Bool = false
    static let startAlertEvent: Event = .init(id: "settingsTipStartAlertEvent")
    
    // Conditional
    var rules: [Rule] { [
        #Rule(Self.startAlertEvent) { $0.donations.count > 2 },
        #Rule(Self.$isPresentedSheet) { !$0 },
        #Rule(Self.$markersCount) { $0 == 1 }
    ] }
}

