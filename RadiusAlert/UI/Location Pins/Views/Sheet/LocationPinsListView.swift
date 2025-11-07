//
//  LocationPinsListView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-04.
//

import SwiftUI

struct LocationPinsListView: View {
    @Environment(LocationPinsViewModel.self) private var locationPinsVM
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            List {
                ForEach(/*locationPinsVM.locationPinsArray*/LocationPinsModel.mock) { item in
                    if locationPinsVM.canRenameLocationPin {
                        NavigationLink(item.title) {
                            UpdateLocationPinSheetContentView(renameTitleText: item.title, radius: item.radius)
                        }
                    } else {
                        Text(item.title)
                    }
                }
                .onDelete(perform: onDelete)
                .onMove(perform: onMove)
            }
            .onDisappear { handleOnDisappear() }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                        .disabled(locationPinsVM.isDisabledLocationPinListSheetEditButton())
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button(locationPinsVM.getLocationPinListSheetTopBarLeadingButtonText()) {
                        handleTopLeadingButtonAction()
                    }
                    .disabled(locationPinsVM.isDisabledLocationPinListSheetTopLeadingButtons())
                }
            }
            .environment(\.editMode, locationPinsVM.editModeBinding())
            .navigationTitle(.init("Pined Locations"))
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: locationPinsVM.editMode.isEditing) {
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

// MARK: - EXTENSIONS
extension LocationPinsListView {
    func onDelete(_ indexSet: IndexSet) {
        var tempArray: [LocationPinsModel] = locationPinsVM.locationPinsArray
        tempArray.remove(atOffsets: indexSet)
        locationPinsVM.setLocationPinsArray(tempArray)
    }
    
    func onMove(_ from: IndexSet, to: Int) {
//        var tempArray: [LocationPinsModel] = locationPinsVM.locationPinsArray
//        tempArray.move(fromOffsets: from, toOffset: to)
//        locationPinsVM.setLocationPinsArray(tempArray)
        
        
        try? locationPinsVM.locationPinsManager.moveLocationPins(items: &locationPinsVM.locationPinsArray, fromOffsets: from, toOffset: to)
        
        Task { try? await locationPinsVM.fetchNSetLocationPins() }
    }
    
    private func handleOnDisappear() {
        locationPinsVM.setCanRenameLocationPin(false)
    }
    
    private func handleTopLeadingButtonAction() {
        var temp: Bool = locationPinsVM.canRenameLocationPin
        temp.toggle()
        locationPinsVM.setCanRenameLocationPin(temp)
    }
}
