//
//  LocationPinsListView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-04.
//

import SwiftUI

struct LocationPinsListView: View {
    @Environment(MapViewModel.self) private var mapVM
    @Environment(LocationPinsViewModel.self) private var locationPinsVM
    let isMock: Bool
    
    init(isMock: Bool = false) {
        self.isMock = isMock
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            let array: [LocationPinsModel] = getArray()
            
            List {
                ForEach(array) { item in
                    if locationPinsVM.canRenameLocationPin {
                        titleOnUpdate(item)
                    } else {
                        justTitle(item)
                    }
                }
                .onDelete(perform: locationPinsVM.enableSwipeGestures() ? locationPinsVM.onLocationPinListItemDelete : nil)
                .onMove(perform: locationPinsVM.enableSwipeGestures() ? locationPinsVM.onLocationPinListItemMove : nil)
            }
            .onDisappear { locationPinsVM.onLocationPinListDisappear() }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                        .disabled(locationPinsVM.isDisabledLocationPinListSheetEditButton())
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button(locationPinsVM.getLocationPinListSheetTopBarLeadingButtonText()) {
                        locationPinsVM.locationPinListTopLeadingButtonAction()
                    }
                    .disabled(locationPinsVM.isDisabledLocationPinListSheetTopLeadingButtons())
                }
            }
            .environment(\.editMode, locationPinsVM.editModeBinding())
            .navigationTitle(.init("Pined Locations"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//MARK: - PREVIEWS
#Preview("LocationPinsListView") {
    Color.clear
        .sheet(isPresented: .constant(true)) {
            LocationPinsListView(isMock: true)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
                .presentationBackground(Color.init(uiColor: .systemGray6))
        }
        .previewModifier()
}

// MARK: - EXTENSIONS
extension LocationPinsListView {
    private func justTitle(_ item: LocationPinsModel) -> some View {
        Button(item.title) {
            locationPinsVM.onLocationPinsListRowItemTap(item)
        }
    }
    
    private func titleOnUpdate(_ item: LocationPinsModel) -> some View {
        NavigationLink(item.title) {
            UpdateLocationPinSheetContentView(item)
        }
    }
    
    private func getArray() -> [LocationPinsModel] {
        return isMock ? LocationPinsModel.mock : locationPinsVM.locationPinsArray
    }
}
