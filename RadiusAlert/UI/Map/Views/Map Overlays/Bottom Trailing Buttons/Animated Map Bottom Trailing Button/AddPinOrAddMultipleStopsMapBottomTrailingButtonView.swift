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
    let locationManager: LocationManager = .shared
    
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
            Task {
                guard
                    let currentUserLocation = locationManager.markerCoordinate,
                    let centerCoordinate = mapVM.centerCoordinate,
                    let route = await locationManager.getRoute(pointA: currentUserLocation, pointB: centerCoordinate) else { return }
                
                mapVM.setRoute(route)
            }
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
