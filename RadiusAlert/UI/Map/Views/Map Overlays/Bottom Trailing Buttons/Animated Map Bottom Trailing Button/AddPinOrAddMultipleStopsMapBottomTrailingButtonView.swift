//
//  AddPinOrAddMultipleStopsMapBottomTrailingButtonView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2026-01-08.
//

import SwiftUI

struct AddPinOrAddMultipleStopsMapBottomTrailingButtonView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    @Environment(MapViewModel.self) private var mapVM
    @Environment(LocationPinsViewModel.self) private var locationPinsVM
    
    // MARK: - ASSIGNED PROPERTIES
    @State private var alertManager: AlertManager = .shared
    
    // MARK: - BODY
    var body: some View {
        Group {
            if #available(iOS 26.0, *) {
                glassButton
            } else {
                nonGlassButton
            }
        }
        .sheet(isPresented: locationPinsVM.isPresentedLocationSavingSheetBinding()) {
            AddLocationPinSheetContentView()
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
                .presentationBackground(Color.init(uiColor: .systemGray6))
        }
    }
}

// MARK: - PREVIEWS
#Preview("AddPinOrAddMultipleStopsMapBottomTrailingButtonView") {
    Preview()
        .previewModifier()
}

fileprivate struct Preview: View {
    @Environment(MapViewModel.self) private var mapVM
    
    var body: some View {
        AddPinOrAddMultipleStopsMapBottomTrailingButtonView()
            .allowsHitTesting(false)
            .overlay {
                Color.primary.opacity(0.001)
                    .onTapGesture {
                        mapVM.setAddPinOrAddMultipleStops(mapVM.addPinOrAddMultipleStops == .addPin ? .addMultipleStops : .addPin)
                    }
            }
    }
}

// MARK: - EXTENSIONS
extension AddPinOrAddMultipleStopsMapBottomTrailingButtonView {
    private var buttonLabel: some View {
        MapControlButtonBackgroundView(size: .init(width: 44, height: 44)) {
            Group {
                switch mapVM.addPinOrAddMultipleStops {
                case .addPin:
                    Image(systemName: mapVM.addPinOrAddMultipleStops.rawValue)
                        .frame(width: 44, height: 44)
                        .transition(.slide)
                    
                case .addMultipleStops:
                    Image(systemName: mapVM.addPinOrAddMultipleStops.rawValue)
                        .frame(width: 44, height: 44)
                        .transition(.slide)
                }
            }
            .animation(.bouncy, value: mapVM.addPinOrAddMultipleStops)
        }
        .defaultTypeSizeViewModifier
    }
    
    private func buttonAction() {
        switch mapVM.addPinOrAddMultipleStops {
        case .addPin:
            locationPinsVM.onAddNewLocationPinButtonTap()
            
        case .addMultipleStops:
#if DEBUG
//            Task {
//                guard
//                    let currentUserLocation = locationManager.markerCoordinate,
//                    let centerCoordinate = mapVM.centerCoordinate,
//                    let route = await locationManager.getRoute(pointA: currentUserLocation, pointB: centerCoordinate) else { return }
//                
//                mapVM.setRoute(route)
//            }
            alertManager.showAlert(
                .addMultipleStops {
                    mapVM.setSearchFieldFocused(true)
                    // If user going through the search bar, disable asking the permission alert to cancel the existing alert as we're trying to set another stop, and not just trying to replace the existing one.
                    // No need too disable the restrictions on map interactions as it automatically moves the map to the correct coordinates, not manually moving the map around.
                    // Once the center coordinate pin is set,  let the user tap on + button to finalize adding the next stop.
                } manual: {
                    print("manual action is working")
                    /// Once the restrictions on Map Interactions are disabled, the use may able to move the map around.
                    /// If not, fix that. If it works, check whether the center coordinate notation on the map is visible or not.
                    mapVM.setInteractionModes(.all)
                    // Move the map around to counting to the next step here...
                    
                    
                    
                    // If everything works as expected!, let the user set another coordinates using center coordinate by tapping on the + button.
                }
            )
            
#endif
        }
        
    }
    
    private var nonGlassButton: some View {
        Button {
            buttonAction()
        } label: {
            buttonLabel
        }
    }
    
    @ViewBuilder
    private var glassButton: some View {
        if #available(iOS 26.0, *) {
            Button {
                buttonAction()
            } label: {
                buttonLabel
                    .fontWeight(.semibold)
                    .foregroundStyle(colorScheme == .dark ? .white : Color.accentColor)
                    .glassEffect(.regular)
            }
            .buttonStyle(.plain)
        }
    }
}
