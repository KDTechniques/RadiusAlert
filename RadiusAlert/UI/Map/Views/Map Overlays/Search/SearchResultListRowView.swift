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
    let action: () -> Void
    
    //  MARK: - INTIALIZER
    init(title: String, subTitle: String, showSeparator: Bool = true, action: @escaping () -> Void) {
        self.title = title
        self.subTitle = subTitle
        self.showSeparator = showSeparator
        self.action = action
    }
    
    // MARK: - BODY
    var body: some View {
        Button {
            action()
        } label: {
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
            .background(.primary.opacity(0.001))
        }
        .buttonStyle(.plain)
    }
}

// MARK: - PREVIEWS
#Preview("SearchResultListRowView") {
    SearchResultListRowView(
        title: "Name: 1234567890 1234567890 ",
        subTitle: "Title: 1234567890 1234567890 1234567890 12345678"
    ) { print("Tapped!") }
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

