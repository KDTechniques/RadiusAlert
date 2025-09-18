//
//  LaunchScreenLogoTextModel.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-18.
//

import Foundation

struct LaunchScreenLogoTextModel: Identifiable {
    let id: String = UUID().uuidString
    let character: String
    var opacity: CGFloat
}
