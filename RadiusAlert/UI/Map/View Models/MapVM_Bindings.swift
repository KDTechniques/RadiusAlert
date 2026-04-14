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
            get: { [weak self] in
                guard let self else { return "" }
                return searchText
            },
            set: {  [weak self] in
                guard
                    let self,
                    searchText != $0 else { return }
                setSearchText($0)
            }
        )
    }
    
    func multipleStopsCancellationSheetBinding() -> Binding<Bool> {
        return .init(
            get: { [weak self] in
                guard let self else { return false }
                return isPresentedMultipleStopsCancellationSheet
            },
            set: { [weak self] in
                guard let self, isPresentedMultipleStopsCancellationSheet != $0 else { return }
                setIsPresentedMultipleStopsCancellationSheet($0)
            }
        )
    }
    
    func multipleStopsMapSheetBinding() -> Binding<Bool> {
        return .init(
            get: { [weak self] in
                guard let self else { return false }
                return isPresentedMultipleStopsMapSheet
            },
            set: { [weak self] in
                guard let self, isPresentedMultipleStopsMapSheet != $0 else { return }
                setIsPresentedMultipleStopsMapSheet($0)
            }
        )
    }
    
    func editRadiusSheetBinding() -> Binding<Bool> {
        return .init(
            get: { [weak self] in
                guard let self else { return false }
                return isPresentedEditRadiusSheet
            }, set: setIsPresentedEditRadiusSheet)
    }
    
    func customReviewSheetBinding() -> Binding<Bool> {
        return .init(
            get: { [weak self] in
                guard let self else { return false }
                return isPresentedCustomReviewSheet
            }, set: setIsPresentedCustomReviewSheet)
    }
}
