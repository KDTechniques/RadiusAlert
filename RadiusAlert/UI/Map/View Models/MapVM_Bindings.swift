//
//  MapVM_Bindings.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-02.
//

import SwiftUI

// MARK: BINDINGS

extension MapViewModel {
    /// Returns a `Binding<String>` that keeps the search bar text in sync with the view model's `searchText`.
    /// Useful for connecting the SwiftUI TextField directly to the view model.
    func searchTextBinding() -> Binding<String> {
        return .init(
            get: { self.searchText },
            set: {
                guard self.searchText != $0 else { return }
                self.setSearchText($0)
            }
        )
    }
    
    func multipleStopsCancellationSheetBinding() -> Binding<Bool> {
        return .init(
            get: { self.isPresentedMultipleStopsCancellationSheet },
            set: {
                guard self.isPresentedMultipleStopsCancellationSheet != $0 else { return }
                self.setIsPresentedMultipleStopsCancellationSheet($0)
            }
        )
    }
    
    func multipleStopsMapSheetBinding() -> Binding<Bool> {
        return .init(
            get: { self.isPresentedMultipleStopsMapSheet },
            set: {
                guard self.isPresentedMultipleStopsMapSheet != $0 else { return }
                self.setIsPresentedMultipleStopsMapSheet($0)
            }
        )
    }
}
