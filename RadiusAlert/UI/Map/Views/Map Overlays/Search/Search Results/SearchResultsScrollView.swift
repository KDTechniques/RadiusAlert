//
//  SearchResultsScrollView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-29.
//

import SwiftUI

struct SearchResultsScrollView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    
    // MARK: - BODY
    var body: some View {
        if let lastItemID: String = mapVM.locationSearchManager.results.last?.id {
            ScrollViewContent {
                scrollViewContent(lastItemID: lastItemID)
            }
        }
    }
}

// MARK: - PREVIEWS
#Preview("SearchResultsScrollView") {
    let maxNumber: Int = 10
    
    ScrollViewContent {
        ForEach(1...maxNumber, id: \.self) { number in
            SearchResultListRowView(
                title: "Title \(number) Goes Here",
                subTitle: "Subtitle \(number) goes here",
                showSeparator: number != maxNumber) {
                    print("Tapped \(number)!")
                }
        }
    }
    .previewModifier()
}

// MARK: - SUB VIEWS
fileprivate struct ScrollViewContent<T: View>: View {
    // MARK: INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    let content: T
    
    // MARK: INITIALIZER
    init(_ content: @escaping () -> T) {
        self.content = content()
    }
    
    // MARK: BODY
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                content
            }
        }
        .scrollDismissesKeyboard(.immediately)
    }
}

// MARK: - EXTENSIONS
extension SearchResultsScrollView {
    private func scrollViewContent(lastItemID: String) -> some View {
        ForEach(mapVM.locationSearchManager.results) { item in
            SearchResultListRowView(
                title: item.result.title,
                subTitle: item.result.subtitle,
                showSeparator: lastItemID != item.id) {
                    mapVM.onSearchResultsListRowTap(item.result)
                }
        }
    }
}
