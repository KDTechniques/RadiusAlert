//
//  NavigationTitleButtonView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-08.
//

import SwiftUI

struct NavigationTitleButtonView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: 5) {
            Text("Radius Alert")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Image(.logo)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundStyle(mapVM.getNavigationTitleIconColor())
                .frame(height: 50)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading)
    }
}

// MARK: - PREVIEWS
#Preview("Navigation Title Button") {
    NavigationTitleButtonView()
        .previewModifier()
}
