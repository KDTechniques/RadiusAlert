//
//  AboutViewModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-09-24.
//

import Foundation

@Observable
final class AboutViewModel {
    // MARK: - ASSIGNED PROPERTIES
    let navigationTitleTip: NavigationTitleTipModel = .init()
    
    // MARK: - PUBLIC FUNCTIONS
    func handleOnAppear() {
        navigationTitleTip.invalidate(reason: .actionPerformed)
    }
}
