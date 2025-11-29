//
//  RecentSearchesListView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-30.
//

import SwiftUI

struct RecentSearchesListView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    
    // MARK: - BODY
    var body: some View {
        if let lastItemID: String = mapVM.recentSearches.last?.id {
            ScrollViewContent {
                ForEach(mapVM.recentSearches) {
                    SearchResultListRowView(
                        title: $0.title,
                        subTitle: $0.subtitle,
                        showSeparator: lastItemID != $0.id
                    ) {
                        // action goes here...
                    }
                }
            }
        }
    }
}

// MARK: - PREVIEWS
#Preview("RecentSearchesListView") {
    NavigationStack {
        let maxNumber: Int = 5
        
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
        VStack(spacing: 0) {
            header
            Divider()
            list
        }
    }
}

// MARK: - EXTENSIONS
extension ScrollViewContent {
    private var header: some View {
        Text("Recent Searches")
            .font(.subheadline)
            .fontWeight(.medium)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
    }
    
    private var list: some View {
        List {
            Group {
                content
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            print("Delete Swiped!")
                        } label: {
                            Image(systemName: "trash.fill")
                        }
                    }
                
                Color.clear
                    .frame(height: Utilities.screenHeight/3)
            }
            .listRowSeparator(.hidden)
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .scrollIndicators(.hidden)
    }
}
