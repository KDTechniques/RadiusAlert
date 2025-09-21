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
        NavigationLink {
            AboutView()
        } label: {
            HStack(spacing: 5) {
                Text("Radius Alert")
                    .tint(.primary)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Image(.logo)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(mapVM.getNavigationTitleIconColor())
                    .frame(height: 50)
                
                debug
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
        }
        
    }
}

// MARK: - PREVIEWS
#Preview("Navigation Title Button") {
    NavigationStack {
        NavigationTitleButtonView()
    }
    .previewModifier()
}

// MARK: - EXTENSIONS
extension NavigationTitleButtonView {
    @ViewBuilder
    private var debug: some View  {
#if DEBUG
        Spacer()
        DebugView()
#endif
    }
}
