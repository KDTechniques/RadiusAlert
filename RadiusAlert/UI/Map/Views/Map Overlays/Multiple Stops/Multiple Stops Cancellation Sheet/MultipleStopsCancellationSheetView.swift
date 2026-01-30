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
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            Group {
                if let firstMarkerID: String = mapVM.markers.first?.id,
                   let lastMarkerID: String = mapVM.markers.last?.id {
                    List(mapVM.markers) { marker in
                        let radiusText: String = mapVM.getRadiusTextString(marker.radius, withAlertRadiusText: false)
                        
                        MultipleStopsCancellationSheetListRowView(
                            color: marker.color,
                            title: marker.title,
                            radius: radiusText
                        )
                        .listRowSeparator(marker.id == firstMarkerID ? .hidden : .visible, edges: .top)
                        .listRowSeparator(marker.id == lastMarkerID ? .hidden : .visible, edges: .bottom)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button("Stop Alert", role: .destructive) {
                                print("Stop Alert here...")
                            }
                        }
                    }
                    .contentMargins(.top, 10, for: .scrollContent)
                    .contentMargins(.bottom, 80, for: .scrollContent)
                    .listStyle(.plain)
                }
            }
            .toolbar {
                stopAllAlertsButton
                sheetDismissButton
            }
            .navigationTitle(Text("Your Current Stops"))
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheetCornerRadiusViewModifier
        .presentationDragIndicator(.visible)
    }
}

// MARK: - PREVIEWS
#Preview("MultipleStopsCancellationSheetView") {
    Color.clear
        .sheet(isPresented: .constant(true)) {
            MultipleStopsCancellationSheetView()
        }
        .previewModifier()
}

// MARK: - EXTENSIONS
extension MultipleStopsCancellationSheetView {
    private var stopAllAlertsButton: some ToolbarContent {
        ToolbarItem(placement: .bottomBar) {
            if #available(iOS 26, *) {
                Button(role: .destructive) {
                    // action goes here...
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
                    // action goes here...
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
                    // action goes here...
                }
            } else {
                Button("Dismiss", role: .cancel) {
                    // action goes here...
                }
            }
        }
    }
}
