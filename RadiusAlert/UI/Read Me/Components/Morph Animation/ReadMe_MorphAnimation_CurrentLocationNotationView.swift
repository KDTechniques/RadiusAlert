//
//  ReadMe_MorphAnimation_CurrentLocationNotationView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-08.
//

import SwiftUI

struct ReadMe_MorphAnimation_CurrentLocationNotationView: View {
    // MARK: - INJECTED PROPERTIES
    let namespace: Namespace.ID
    
    // MARK: - INITIALIZER
    init(_ namespace: Namespace.ID) {
        self.namespace = namespace
    }
    
    // MARK: - BODY
    var body: some View {
        Circle()
            .fill(.white)
            .matchedGeometryEffect(id: 1, in: namespace)
            .frame(width: 30)
            .shadow(color: .black.opacity(0.3), radius: 2)
            .overlay {
                Circle()
                    .fill(.blue)
                    .padding(5)
                    .matchedGeometryEffect(id: 2, in: namespace)
            }
    }
}

// MARK: -  PREVIEWS
#Preview("ReadMe_MorphAnimation_CurrentLocationNotationView") {
    @Previewable @Namespace var namespace
    
    ReadMe_MorphAnimation_CurrentLocationNotationView(namespace)
        .previewModifier()
}
