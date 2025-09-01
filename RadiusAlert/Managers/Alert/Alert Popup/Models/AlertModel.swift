//
//  AlertModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-05.
//

import SwiftUI

struct AlertModel: Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let message: String
    let hapticType: HapticTypes
    let actions: [AlertButtonModel]
    
    init(
        title: String,
        message: String = "",
        hapticType: HapticTypes,
        actions: [AlertButtonModel],
    ) {
        self.title = title
        self.message = message
        self.hapticType = hapticType
        self.actions = actions
    }
}
