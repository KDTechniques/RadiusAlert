//
//  SearchResultListRowView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-06.
//

import SwiftUI

struct SearchResultListRowView: View {
    // MARK: - INJECTED PROPERTIES
    let title: String
    let subTitle: String
    let showSeparator: Bool
    
    //  MARK: - INTIALIZER
    init(title: String, subTitle: String, showSeparator: Bool = true) {
        self.title = title
        self.subTitle = subTitle
        self.showSeparator = showSeparator
    }
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 5) {
                titleText
                subTitleText
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
#Preview("SearchResultListRowView") {
    SearchResultListRowView(
        title: "Name: 1234567890 1234567890 ",
        subTitle: "Title: 1234567890 1234567890 1234567890 12345678"
    )
    .previewModifier()
}

#Preview("Content") {
    ContentView()
        .previewModifier()
}

// MARK: - EXTENSIONS
extension SearchResultListRowView {
    private var titleText: some View {
        Text(title)
            .fontWeight(.medium)
            .padding(.trailing, 100)
    }
    
    private var subTitleText: some View {
        Text(subTitle.isEmpty ? "Address Not Available" : subTitle)
            .font(.caption)
            .foregroundStyle(.secondary)
            .padding(.trailing, 50)
    }
}

