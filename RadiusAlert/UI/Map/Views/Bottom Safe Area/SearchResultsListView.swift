//
//  SearchResultsListView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-27.
//

import SwiftUI

struct SearchResultsListView: View {
    // MARK: - BODY
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                list
            }
        }
    }
}

// MARK: - PREVIEWS
#Preview("Search Results List View") {
    SearchResultsListView()
        .previewModifier()
}

// MARK: - EXTENSIONS
extension SearchResultsListView {
    private func primaryText(_ text: String) -> some View {
        Text(text)
            .fontWeight(.medium)
    }
    
    private func secondaryText(_ text:  String) -> some View {
        Text(text)
            .font(.callout)
            .foregroundStyle(.secondary)
    }
    
    private var selectionIcon:some View {
        Image(systemName: "checkmark")
            .foregroundStyle(.secondary)
    }
    
    private var listRow: some View {
        VStack(spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    primaryText("Location Name")
                    secondaryText(UUID().uuidString)
                }
                
                Spacer()
                
                selectionIcon
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            Divider()
        }
        .background(.red.opacity(0.001))
    }
    
    private var list: some View {
        ForEach(0...20, id: \.self) { number in
            Button {
                // Action goes here...
                print(number.description)
            } label: {
                listRow
            }
            .buttonStyle(.plain)
        }
    }
}
