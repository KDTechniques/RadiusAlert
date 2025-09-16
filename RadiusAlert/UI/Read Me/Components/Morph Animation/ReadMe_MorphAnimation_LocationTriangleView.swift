//
//  ReadMe_MorphAnimation_LocationTriangleView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-08.
//

import SwiftUI

struct ReadMe_MorphAnimation_LocationTriangleView: View {
    // MARK: - INJECTED PROPERTIES
    let namespace: Namespace.ID
    
    // MARK: - INITIALIZER
    init(_ namespace: Namespace.ID) {
        self.namespace = namespace
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.white)
                .shadow(color: .black.opacity(0.1), radius: 2)
                .matchedGeometryEffect(id: 1, in: namespace)
            
            Image(systemName: "location.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.blue)
                .padding(9)
                .matchedGeometryEffect(id: 2, in: namespace)
            
        }
        .frame(width: 35, height: 35)
    }
}

#Preview("ReadMe_MorphAnimation_LocationTriangleView") {
    @Previewable @Namespace var namespace
    
    ReadMe_MorphAnimation_LocationTriangleView(namespace)
        .previewModifier()
}
