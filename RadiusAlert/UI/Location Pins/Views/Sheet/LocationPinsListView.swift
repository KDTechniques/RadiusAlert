//
//  LocationPinsListView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-04.
//

import SwiftUI

struct LocationPinsListView: View {
    @State var mockArray: [LocationPinModel] = LocationPinModel.mock
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            List {
                ForEach(mockArray) {
                    Text($0.getLabel())
                }
                .onDelete(perform: onDelete)
                .onMove(perform: onMove)
            }
            .toolbar { EditButton() }
            .navigationTitle(.init("Pined Locations"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//MARK: - PREVIEWS
#Preview("LocationPinsListView") {
    Color.clear
        .sheet(isPresented: .constant(true)) {
            LocationPinsListView()
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
                .presentationBackground(Color.init(uiColor: .systemGray6))
        }
        .previewModifier()
}

extension LocationPinsListView {
    func onDelete(_ indexSet: IndexSet) {
        mockArray.remove(atOffsets: indexSet)
    }
    
    func onMove(_ from: IndexSet, to: Int) {
        mockArray.move(fromOffsets: from, toOffset: to)
    }
}
