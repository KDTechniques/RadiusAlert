//
//  ReadMeMorphAnimationModel.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-08.
//

import Foundation

struct ReadMeMorphAnimationModel {
    let type: ReadMeMorphAnimationTypes
    var isInitialView:  Bool
    var showAnimation: Bool
    
    init(type: ReadMeMorphAnimationTypes, isInitialView: Bool = true, showAnimation: Bool = false) {
        self.type = type
        self.isInitialView = isInitialView
        self.showAnimation = showAnimation
    }
}
