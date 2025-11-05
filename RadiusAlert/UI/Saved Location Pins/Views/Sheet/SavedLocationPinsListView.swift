//
//  SavedLocationPinsListView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-04.
//

import SwiftUI

struct SavedLocationPinsListView: View {
    @State var mockArray: [PinModel] = PinModel.mock
    
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
#Preview("SavedLocationPinsListView") {
    Color.clear
        .sheet(isPresented: .constant(true)) {
            SavedLocationPinsListView()
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
                .presentationBackground(Color.init(uiColor: .systemGray6))
        }
        .previewModifier()
}

extension SavedLocationPinsListView {
    func onDelete(_ indexSet: IndexSet) {
        mockArray.remove(atOffsets: indexSet)
    }
    
    func onMove(_ from: IndexSet, to: Int) {
        mockArray.move(fromOffsets: from, toOffset: to)
    }
}
