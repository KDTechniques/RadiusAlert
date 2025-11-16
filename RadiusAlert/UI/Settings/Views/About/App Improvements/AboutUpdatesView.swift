//
//  AboutUpdatesView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-13.
//

import SwiftUI

struct AboutUpdatesView: View {
    // MARK: - INJECTED PROPERTIES
    let type: UpdateTypes
    
    // MARK: - INITIALIZER
    init(type: UpdateTypes) {
        self.type = type
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationLink {
            Content(type: type)
        } label: {
            Text(type.navigationLinkString)
        }
    }
}

// MARK: - PREVIEWS
#Preview("AboutUpdatesView - Content") {
    NavigationStack {
        Content(type: .random())
    }
    .previewModifier()
}

#Preview("AboutUpdatesView") {
    NavigationStack {
        AboutUpdatesView(type: .random())
    }
    .previewModifier()
}

// MARK: - SUB VIEWS
private struct Content: View {
    let type: UpdateTypes
    
    init(type: UpdateTypes) {
        self.type = type
    }
    
    var body: some View {
        List {
            ForEach(type.values) {
                rowContent($0)
            }
        }
        .navigationTitle(Text(type.navigationTitle))
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - EXTENSIONS
private extension Content {
    private func rowContent(_ update: UpdateTypeValues) -> some View {
        HStack {
            Text(update.emoji)
            Text(update.description)
        }
    }
}
