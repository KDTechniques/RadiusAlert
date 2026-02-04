//
//  MultipleStopsCancellationSheetView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2026-01-29.
//

import SwiftUI

struct MultipleStopsCancellationSheetView: View {
    // MARK: INJECTED PROEPRTIES
    @Environment(MapViewModel.self) private var mapVM
    let markers: [MarkerModel]
    
    // MARK: - INITIALIZER
    init(markers: [MarkerModel]) {
        self.markers = markers
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            Group {
                if let firstMarkerID: String = markers.first?.id,
                   let lastMarkerID: String = markers.last?.id {
                    List(markers) { marker in
                        let radiusText: String = mapVM.getRadiusTextString(marker.radius, withAlertRadiusText: false)
                        
                        MultipleStopsCancellationSheetListRowView(
                            color: marker.color,
                            number: marker.number,
                            title: marker.title,
                            radius: radiusText
                        )
                        .listRowSeparator(marker.id == firstMarkerID ? .hidden : .visible, edges: .top)
                        .listRowSeparator(marker.id == lastMarkerID ? .hidden : .visible, edges: .bottom)
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) { swipeActionButton(marker.id) }
                    }
                    .contentMargins(.top, 10, for: .scrollContent)
                    .contentMargins(.bottom, 80, for: .scrollContent)
                    .listStyle(.plain)
                    .animation(.default, value: markers)
                }
            }
            .toolbar {
                stopAllAlertsButton
                sheetDismissButton
            }
            .navigationTitle(Text("Your Current Stops"))
            .navigationBarTitleDisplayMode(.inline)
        }
        .alertViewModifier(at: .multipleStopsCancellationSheet)
        .onDisappear {
            mapVM.setRegionBoundsToUserLocationNMarkers(on: .primary)
        }
        .sheetCornerRadiusViewModifier
        .presentationDragIndicator(.visible)
    }
}

// MARK: - PREVIEWS
#Preview("MultipleStopsCancellationSheetView") {
    Color.clear
        .sheet(isPresented: .constant(true)) {
            MultipleStopsCancellationSheetView(markers: MarkerModel.mock)
        }
        .previewModifier()
}

// MARK: - EXTENSIONS
extension MultipleStopsCancellationSheetView {
    private var stopAllAlertsButton: some ToolbarContent {
        ToolbarItem(placement: .bottomBar) {
            if #available(iOS 26, *) {
                Button(role: .destructive) {
                    mapVM.handleMultipleStopsCancellation()
                } label: {
                    Text("Stop All Alerts")
                        .fontWeight(.semibold)
                        .foregroundStyle(.red)
                        .padding(.vertical)
                        .frame(width: Utilities.screenWidth * 0.7)
                }
                .buttonStyle(.plain)
            } else {
                Button("Stop All Alerts", role: .destructive) {
                    mapVM.handleMultipleStopsCancellation()
                }
                .tint(.red)
                .fontWeight(.semibold)
                .padding(.top)
            }
        }
    }
    
    private var sheetDismissButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            if #available(iOS 26, *) {
                Button(role: .close) {
                    mapVM.setIsPresentedMultipleStopsCancellationSheet(false)
                }
            } else {
                Button("Dismiss", role: .cancel) {
                    mapVM.setIsPresentedMultipleStopsCancellationSheet(false)
                }
            }
        }
    }
    
    private func swipeActionButton(_ markerID: String) -> some View {
        Button("Stop Alert", role: .destructive) {
            mapVM.handleMultipleStopsSingleCancellation(for: markerID)
        }
    }
}
