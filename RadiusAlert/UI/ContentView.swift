//
//  ContentView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-07-27
//

import SwiftUI
import SearchBarSwiftUI
import MapKit

struct ContentView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    @Environment(SettingsViewModel.self) private var settingsVM
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
                    MapBottomTrailingButtonsView()
                    RadiusSliderView()
                }
                .safeAreaInset(edge: .bottom, spacing: 0) {  BottomSafeAreaView() }
                .overlay { SearchListBackgroundView() }
                .safeAreaInset(edge: .top, spacing: 0) { TopSafeAreaView() }
                .ignoresSafeArea(.keyboard)
                .navigationTitle(Text("Radius Alert"))
                .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
                .toolbar { ToolbarItem(placement: .topBarTrailing) { topTrailingNavigationButtons } }
        }
        .alertViewModifier
        .popupCardViewModifier(vm: mapVM)
        .overlay(splashScreen)
        .onAppear { mapVM.positionToInitialUserLocation() }
        .onChange(of: scenePhase) { onScenePhaseChange($1) }
    }
}

// MARK: - PREVIEWS
#Preview("ContentView") {
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
        let condition1: Bool = value == .active
        let condition2: Bool = UIApplication.shared.isProtectedDataAvailable
        
        guard condition1, condition2 else { return }
        
        mapVM.reduceAlertToneVolumeOnScenePhaseChange()
    }
    
    private var settingsNavigationLink: some View {
        Group {
            if #available(iOS 26.0, *) {
                NavigationLink {
                    SettingsView()
                } label: {
                    Image(systemName: "gear")
                }
                .buttonStyle(.plain)
                
            } else { // iOS 18.6
                NavigationLink {
                    SettingsView()
                } label: {
                    Text("Settings")
                }
            }
        }
        .popoverTip(settingsVM.settingsTip)
        .tipImageStyle(.secondary)
    }
    
    private var topTrailingNavigationButtons: some View {
        HStack(spacing: 20) {
            settingsNavigationLink
            debug
        }
    }
    
    @ViewBuilder
    private var debug: some View {
#if DEBUG
        DebugView()
#endif
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
