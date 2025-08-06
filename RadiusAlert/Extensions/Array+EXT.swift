//
//  Array+EXT.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-08-03.
//

import Foundation

extension Array {
    func nextIndex(after givenIndex: Int) -> Int {
        let lastIndex: Int = self.count-1
        return givenIndex < lastIndex ? givenIndex+1 : 0
    }
}
