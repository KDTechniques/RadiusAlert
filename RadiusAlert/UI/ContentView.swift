//
//  ContentView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-07-27.
//

import SwiftUI
import SearchBarSwiftUI
import MapKit

struct ContentView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    @Environment(\.scenePhase) private var scenePhase
    
    // MARK: - ASSIGNED PROPERTIES
    @State private var alertManager: AlertManager = .shared
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            MapView()
                .overlay {
                    MapPinView()
                    CircularRadiusTextView()
                    MapStyleButtonView()
                    RadiusSliderView()
                }
                .safeAreaInset(edge: .bottom, spacing: 0) {  BottomSafeAreaView() }
                .overlay { SearchListBackgroundView() }
                .safeAreaInset(edge: .top, spacing: 0) { TopSafeAreaView() }
                .overlay { KeyboardPreLoaderView() }
                .popupCardViewModifier(vm: mapVM)
                .toolbarVisibility(.hidden, for: .navigationBar)
                .ignoresSafeArea(.keyboard)
                .alertViewModifier(item: $alertManager.alertItem)
        }
        .onAppear { mapVM.positionToInitialUserLocation() }
        .onChange(of: scenePhase) { mapVM.playHapticsInForeground(by: $1) }
    }
}

// MARK: - PREVIEWS
#Preview("Content View") {
    ContentView()
        .previewModifier()
}

// MARK: - EXTENSIONS
fileprivate extension View  {
    func popupCardViewModifier(vm: MapViewModel) -> some View {
        self
            .overlay {
                if let popupCardItem: PopupCardModel = vm.popupCardItem {
                    PopupCardView(item: popupCardItem)
                }
            }
    }
}
