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
    @Environment(SavedPinsViewModel.self) private var savedPinsVM
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
                }
                .safeAreaInset(edge: .bottom, spacing: 0) {  BottomSafeAreaView() }
                .overlay { SearchListBackgroundView() }
                .safeAreaInset(edge: .top, spacing: 0) { TopSafeAreaView() }
                .toolbarVisibility(.hidden, for: .navigationBar)
                .ignoresSafeArea(.keyboard)
                .navigationTitle(Text("Map"))
        }
        .alertViewModifier
        .popupCardViewModifier(vm: mapVM)
        .overlay(splashScreen)
        .sheet(isPresented: savedPinsVM.isPresentedSheetBinding()) {
            Text("All the Pins go here.\nMax is 10.\nUse a list to select and order them.")
                .presentationDetents([.fraction(0.3)])
//                .presentationCornerRadius(30)
                .presentationDragIndicator(.visible)
                .padding()
                .multilineTextAlignment(.center)
        }
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
