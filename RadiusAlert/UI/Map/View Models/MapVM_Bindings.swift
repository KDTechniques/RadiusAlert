//
//  MapVM_Bindings.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-02.
//

import SwiftUI
import CoreLocation

// MARK: BINDINGS

extension MapViewModel {
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
    
    func primarySelectedRadiusBinding() -> Binding<CLLocationDistance> {
        return .init(
            get: {  [weak self] in
                guard let self else { return .zero }
                return primarySelectedRadius
            }, set: setPrimarySelectedRadius)
    }
    
    func secondarySelectedRadiusBinding() -> Binding<CLLocationDistance> {
        return .init(
            get: {  [weak self] in
                guard let self else { return .zero }
                return secondarySelectedRadius
            }, set: setSecondarySelectedRadius)
    }
}
