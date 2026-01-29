//
//  MultipleStopsCancellationSheetView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2026-01-29.
//

import SwiftUI

struct MultipleStopsCancellationSheetView: View {
    // MARKER: INJECTED PROEPRTIES
    @Environment(MapViewModel.self) private var mapVM
    
    // MARKER: ASSIGNED PROPERTIES
    let nilTitleText: String = "Unknown Location"
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            List(MarkerModel.mock) {
                let radiusText: String = mapVM.getRadiusTextString($0.radius, withAlertRadiusText: false)
                
                listRow(color: $0.color, title: $0.title, radius: radiusText)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button("Stop Alert", role: .destructive) {
                            print("Stop Alert here...")
                        }
                    }
            }
            .listStyle(.plain)
            .presentationDragIndicator(.visible)
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
        }
        .presentationCornerRadius(40)
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
            .fill(color.opacity(0.5))
            .frame(width: 50, height: 50)
    }
    
    private func markerText(title: String, radius: String) -> some View {
        VStack(alignment: .leading) {
            Text("Homestead High School")
                .fontWeight(.medium)
            
            Text("700m")
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
        .padding(.horizontal)
    }
}
