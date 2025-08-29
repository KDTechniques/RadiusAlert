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
    @State private var showSplashScreen: Bool = true
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            MapView()
                .overlay {
                    MapPinView()
                    CircularRadiusTextView()
                    MapStyleButtonView()
                    RadiusSliderView()
                    DistanceTextView()
                }
                .safeAreaInset(edge: .bottom, spacing: 0) {  BottomSafeAreaView() }
                .overlay { SearchListBackgroundView() }
                .safeAreaInset(edge: .top, spacing: 0) { TopSafeAreaView() }
                .toolbarVisibility(.hidden, for: .navigationBar)
                .ignoresSafeArea(.keyboard)
                .alertViewModifier(item: $alertManager.alertItem)
                .navigationTitle(Text("Map"))
        }
        .popupCardViewModifier(vm: mapVM)
        .overlay(splashScreen)
        .onAppear { mapVM.positionToInitialUserLocation() }
        .onChange(of: scenePhase) { onScenePhaseChange($1) }
    }
}

// MARK: - PREVIEWS
#Preview("Content View") {
    ContentView()
        .previewModifier()
}

// MARK: - EXTENSIONS
extension ContentView {
    @ViewBuilder
    private var splashScreen: some View {
        if showSplashScreen {
            LaunchScreen()
                .background {
                    KeyboardPreLoaderView {
                        showSplashScreen = false
                    }
                }
        }
    }
    
    private func onScenePhaseChange(_ value: ScenePhase) {
        mapVM.reduceAlertToneVolumeOnScenePhaseChange(value)
    }
}

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
