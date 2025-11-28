//
//  SearchRecentsView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-22.
//

import SwiftUI

struct SearchRecentsView: View {
    
    let recentsArray:[RecentsModel] = RecentsModel.mock
    
    // MARK: - BODY
    var body: some View {
        let lastID: String = recentsArray.last?.id ?? ""
        VStack(alignment: .leading, spacing: 20) {
            ForEach(recentsArray) {
                row($0.title, showSeparator: $0.id != lastID)
            }
            
            Spacer()
        }
    }
}

// MARK: - PREVIEWS
#Preview("SearchRecentsView") {
    SearchRecentsView()
        .previewModifier()
}

// MARK: - EXTENSIONS
extension SearchRecentsView {
    private func row(_ title: String, showSeparator: Bool) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: "clock.fill")
                Text(title)
            }
            .padding(.horizontal)
            
            Divider()
                .opacity(showSeparator ? 1 : 0)
        }
        .background(.primary.opacity(0.001))
    }
}
