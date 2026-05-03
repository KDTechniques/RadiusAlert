//
//  EditRadiusButtonView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2026-03-09.
//

import SwiftUI

struct EditRadiusButtonView: View {
    //MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    
    // MARK: - BODY
    var body: some View {
        if mapVM.isThereAnyMarkerCoordinate() {
            MapOverlayButtonView(systemImage: "pencil") {
                mapVM.setIsPresentedEditRadiusSheet(true)
            }
            .sheet(isPresented: mapVM.editRadiusSheetBinding()) {
                EditRadiusSheetContentView(markers: mapVM.markers)
            }
        }
    }
}
