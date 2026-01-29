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
    
    // MARK: ASSIGNED PROPERTIES
    let nilTitleText: String = "Unknown Location"
    
    let mock: [MarkerModel] =  MarkerModel.mock
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            Group {
                if let firstMarkerID: String = mock.first?.id, let lastMarkerID: String = mock.last?.id {
                    List(mock) { marker in
                        let radiusText: String = mapVM.getRadiusTextString(marker.radius, withAlertRadiusText: false)
                        
                        listRow(color: marker.color, title: marker.title, radius: radiusText)
                            .listRowSeparator(marker.id == firstMarkerID ? .hidden : .visible, edges: .top)
                            .listRowSeparator(marker.id == lastMarkerID ? .hidden : .visible, edges: .bottom)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button("Stop Alert", role: .destructive) {
                                    print("Stop Alert here...")
                                }
                            }
                    }
                    .listStyle(.plain)
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    if #available(iOS 26, *) {
                        Button(role: .destructive) {
                            
                        } label: {
                            Text("Stop All Alerts")
                        }
                        .buttonStyle(.glassProminent)
                        .tint(.red)
                    } else {
                        Button("Stop All Alerts", role: .destructive) {
                            print("Stops All Alerts here...")
                        }
                        .tint(.red)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    if #available(iOS 26, *) {
                        Button(role: .close) {
                            
                        }
                    } else {
                        
                    }
                }
            }
            .navigationTitle(Text("Your Current Stops"))
            .navigationBarTitleDisplayMode(.inline)
        }
        .presentationCornerRadius(40)
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

extension MultipleStopsCancellationSheetView {
    private func markerCircle(color: Color) -> some View {
        Circle()
            .fill(color.opacity(0.2))
            .frame(width: 60, height: 60)
            .overlay {
                Image(systemName: "mappin")
                    .foregroundStyle(.red)
            }
    }
    
    private func markerText(title: String, radius: String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .fontWeight(.medium)
            
            Text(radius)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
    
    private func listRow(color: Color, title: String?, radius: String) -> some View {
        HStack {
            markerCircle(color: color)
            markerText(title: title ?? nilTitleText, radius: radius)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
