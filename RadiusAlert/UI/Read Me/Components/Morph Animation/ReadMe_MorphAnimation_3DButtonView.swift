//
//  ReadMe_MorphAnimation_3DButtonView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-08.
//

import SwiftUI

struct ReadMe_MorphAnimation_3DButtonView: View {
    // MARK: - INJECTED PROPERTIES
    let namespace: Namespace.ID
    
    // MARK: - INITIALIZER
    init(_ namespace: Namespace.ID) {
        self.namespace = namespace
    }
    
    // MARK: - BODY
    var body: some View {
        ReadMe_TitleTextView()
            .opacity(0)
            .overlay(alignment: .leading) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.white)
                        .shadow(color: .black.opacity(0.1), radius: 2)
                        .matchedGeometryEffect(id: 1, in: namespace)
                    
                    Text("3D")
                        .font(.callout)
                        .foregroundStyle(.blue)
                        .matchedGeometryEffect(id: 2, in: namespace)
                }
                .frame(width: 35, height: 35)
            }
    }
}

// MARK: - PREVIEWS
#Preview("ReadMe_MorphAnimation_3DButtonView") {
    @Previewable @Namespace var namespace
    
    ReadMe_MorphAnimation_3DButtonView(namespace)
        .previewModifier()
}
