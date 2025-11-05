//
//  LocationPinsListView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-04.
//

import SwiftUI

struct LocationPinsListView: View {
    @State var mockArray: [LocationPinsModel] = LocationPinsModel.mock
    @State private var mode: EditMode = .inactive
    @State private var canRename: Bool = false
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            List {
                ForEach(mockArray) { item in
                    if canRename {
                        NavigationLink(item.title) {
                            Text("// Rename the location pin and set new radius here...")
                        }
                    } else {
                        Text(item.title)
                    }
                }
                .onDelete(perform: onDelete)
                .onMove(perform: onMove)
            }
            .onDisappear {
                canRename = false
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button(canRename ? "Cancel" : "Rename") {
                        canRename.toggle()
                    }
                }
            }
            .environment(\.editMode, $mode)
            .navigationTitle(.init("Pined Locations"))
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: mode.isEditing) {
                // use this closure to update the new order of the location pins or try to use `movePins` function if possible.
            }
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
