//
//  ReadMeView_EXT.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-04.
//

import SwiftUI

extension View {
    /// Applies the primary heading style for the ReadMe screen.
    /// - Returns: A view with `.title` font and bold weight.
    var readMeHeading1ViewModifier: some View {
        self
            .font(.title)
            .fontWeight(.bold)
    }
    
    /// Applies the secondary heading style for the ReadMe screen.
    /// - Returns: A view with `.title2` font and bold weight.
    var readMeHeading2ViewModifier: some View {
        self
            .font(.title2)
            .fontWeight(.bold)
    }
    
    /// Applies the body style used in ReadMe descriptions.
    /// - Returns: A view using secondary foreground style, `.title3` font, and semibold weight.
    var readMeBodyViewModifier: some View {
        self
            .foregroundStyle(.secondary)
            .font(.title3)
            .fontWeight(.semibold)
    }
    
    /// Configures scroll behavior for ReadMe sections after the scroll target layout.
    /// - Returns: A view with view-aligned scrolling, bounce based on size, and hidden indicators.
    var readMeAfterScrollTargetLayoutViewModifier: some View {
        self
            .scrollTargetBehavior(.viewAligned)
            .scrollBounceBehavior(.basedOnSize)
            .scrollIndicators(.hidden)
    }
    
    /// Adds vertical spacing between major heading sections in the ReadMe screen.
    /// - Returns: A view with a top padding of 50 points.
    var readMeHeadingSectionToSectionPadding: some View {
        self
            .padding(.top, 50)
    }
    
    /// Adds vertical spacing between subheading sections in the ReadMe screen.
    /// - Returns: A view with a top padding of 20 points.
    var readMeSubHeadingSectionToSectionPadding: some View {
        self
            .padding(.top, 20)
    }
}

