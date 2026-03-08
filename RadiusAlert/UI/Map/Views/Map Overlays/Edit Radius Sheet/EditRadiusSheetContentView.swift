//
//  EditRadiusSheetContentView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2026-03-07.
//

import SwiftUI

struct EditRadiusSheetContentView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    let markers: [MarkerModel]
    
    // MARK: - INITIALIZER
    init(markers: [MarkerModel]) {
        self.markers = markers
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            Group {
                if let firstMarkerID: String = markers.first?.id,
                   let lastMarkerID: String = markers.last?.id {
                    List(markers) { marker in
                        let radiusText: String = mapVM.getRadiusTextString(marker.radius, title: nil, withAlertRadiusText: false)
                        
                        NavigationLink {
                            EditRadiusSheetSliderContentView(marker)
                        } label: {
                            MarkerItemListRowView(
                                color: marker.color,
                                number: marker.number,
                                title: marker.title,
                                radius: radiusText
                            )
                        }
                        .listRowSeparator(marker.id == firstMarkerID ? .hidden : .visible, edges: .top)
                        .listRowSeparator(marker.id == lastMarkerID ? .hidden : .visible, edges: .bottom)
                    }
                    .markerItemListViewModifier
                    .animation(.default, value: markers)
                }
            }
            .navigationTitle(.init("Edit Radius"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    dismissButton
                }
            }
        }
        .alertViewModifier(at: .editRadiusSheet)
        .presentationDetents([.medium])
    }
}

// MARK: - PREVIEWS
#Preview("EditRadiusSheetContentView") {
    Color.debug.ignoresSafeArea()
        .sheet(isPresented: .constant(true)) {
            EditRadiusSheetContentView(markers: MarkerModel.mock)
        }
        .previewModifier()
}

// MARK: - EXTENSIONS
extension EditRadiusSheetContentView {
    @ViewBuilder
    private var dismissButton: some View {
        if #available(iOS 26.0, *) {
            Button(role: .close) {
                mapVM.setIsPresentedEditRadiusSheet(false)
            }
        } else {
            Button("Dismiss") {
                mapVM.setIsPresentedEditRadiusSheet(false)
            }
        }
    }
}
