//
//  Color+EXT.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-04.
//

import SwiftUI

extension Color {
    static var debug: Self {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        
        return Color(red: red, green: green, blue: blue)
    }
    
    static func getNotPrimary(colorScheme: ColorScheme) -> Self {
        return colorScheme == .dark ? .white : .black
    }
}
