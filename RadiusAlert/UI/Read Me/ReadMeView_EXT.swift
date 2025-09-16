//
//  ReadMeView_EXT.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-04.
//

import SwiftUI

extension View {
    var readMeHeading1ViewModifier: some View {
        self
            .font(.title)
            .fontWeight(.bold)
    }
    
    var readMeHeading2ViewModifier: some View {
        self
            .font(.title2)
            .fontWeight(.bold)
    }
    
    var readMeBodyViewModifier: some View {
        self
            .foregroundStyle(.secondary)
            .font(.title3)
            .fontWeight(.semibold)
    }
    
    var readMeAfterScrollTargetLayoutViewModifier: some View {
        self
            .scrollTargetBehavior(.viewAligned)
            .scrollBounceBehavior(.basedOnSize)
            .scrollIndicators(.hidden)
    }
    
    var readMeHeadingSectionToSectionPadding: some View {
        self
            .padding(.top, 50)
    }
}
