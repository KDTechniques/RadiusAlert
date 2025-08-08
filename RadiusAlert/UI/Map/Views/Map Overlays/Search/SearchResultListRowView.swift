//
//  SearchResultListRowView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-06.
//

import SwiftUI

struct SearchResultListRowView: View {
    // MARK: - INJECTED PROPERTIES
    let name: String
    let title: String
    let showSeparator: Bool
    
    //  MARK: - INTIALIZER
    init(name: String, title: String, showSeparator: Bool = true) {
        self.name = name
        self.title = title
        self.showSeparator = showSeparator
    }
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 5) {
                nameText
                titleText
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, 10)
            
            Divider()
                .opacity(showSeparator ? 1 : 0)
        }
        .background(.red.opacity(0.001))
    }
}

// MARK: - PREVIEWS
#Preview("Search Result List Row View") {
    SearchResultListRowView(
        name: "Name: 1234567890 1234567890 ",
        title: "Title: 1234567890 1234567890 1234567890 12345678"
    )
    .previewModifier()
}

// MARK: - EXTENSIONS
extension SearchResultListRowView {
    private var nameText: some View {
        Text(name)
            .fontWeight(.medium)
            .padding(.trailing, 100)
    }
    
    private var titleText: some View {
        Text(title)
            .font(.caption)
            .foregroundStyle(.secondary)
            .padding(.trailing, 50)
    }
}

