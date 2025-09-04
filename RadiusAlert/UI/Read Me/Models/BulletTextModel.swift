//
//  BulletTextModel.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-04.
//

import Foundation

struct BulletTextModel: Identifiable {
    let id: String = UUID().uuidString
    let emoji: String
    let text: String
}
