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
    @Environment(AboutViewModel.self) private var aboutVM
    
    // MARK: - BODY
    var body: some View {
        NavigationLink {
            AboutView()
        } label: {
            HStack(spacing: 5) {
                titleText
                LogoView(color: mapVM.getNavigationTitleIconColor(), size: 35)
//                debug
            }
            .popoverTip(aboutVM.navigationTitleTip)
            .tipImageStyle(.secondary)
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
    private var titleText: some View {
        Text("Radius Alert")
            .tint(.primary)
            .font(.largeTitle)
            .fontWeight(.bold)
    }
    
    @ViewBuilder
    private var debug: some View  {
#if DEBUG
        Spacer()
        DebugView()
#endif
    }
}
