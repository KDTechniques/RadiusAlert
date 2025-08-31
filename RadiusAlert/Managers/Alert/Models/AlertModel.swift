//
//  AlertModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-05.
//

import SwiftUI

struct AlertModel: Identifiable {
    let id              : String = UUID().uuidString
    let title           : String
    let message         : String
    let hapticType      : HapticTypes
    let primaryAction   : Alert.Button
    let secondaryAction : Alert.Button?
    
    init(title: String, message: String = "", hapticType: HapticTypes, primaryAction: Alert.Button, secondaryAction: Alert.Button? = nil) {
        self.title              = title
        self.message            = message
        self.hapticType         = hapticType
        self.primaryAction      = primaryAction
        self.secondaryAction    = secondaryAction
    }
}

struct AlertButtonModel {
    let label: String
    let action: () -> Void
}
