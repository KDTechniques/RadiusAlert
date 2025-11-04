//
//  SavedPinsListView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-04.
//

import SwiftUI

struct SavedPinsListView: View {
    // MARK: - BODY
    var body: some View {
        List(PinModel.mock) { item in
            Text(item.title)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                EditButton()
            }
        }
    }
}

//MARK: - PREVIEWS
#Preview("SavedPinsListView") {
    Color.clear
        .sheet(isPresented: .constant(true)) {
            SavedPinsListView()
        }
        .previewModifier()
}
