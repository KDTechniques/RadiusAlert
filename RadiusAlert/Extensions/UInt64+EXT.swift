//
//  UInt64+EXT.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-08.
//

import Foundation

extension UInt64 {
    static func seconds(_ value: Double) -> Self {
        return Self(value * 1_000_000_000)
    }
}
