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
    
    //  MARK: - INTIALIZER
    init(name: String, title: String) {
        self.name = name
        self.title = title
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
        }
        .background(.red.opacity(0.001))
    }
}

// MARK: - PREVIEWS
#Preview("Search Result List Row View") {
    SearchResultListRowView(name: "Name", title: "Title")
        .previewModifier()
}

// MARK: - EXTENSIONS
extension SearchResultListRowView {
    private var nameText: some View {
        Text(name)
            .fontWeight(.medium)
    }
    
    private var titleText: some View {
        Text(title)
            .font(.caption)
            .foregroundStyle(.secondary)
    }
}

