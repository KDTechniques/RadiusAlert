//
//  TestGeometryEffect.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2026-01-05.
//

import SwiftUI

struct TestGeometryEffect: View {
    
    @State private var toggle: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 200, height: 200)
                .foregroundStyle(.white)
                .overlay {
                    if toggle {
                        Image(systemName: "plus")
                            .font(.largeTitle.bold())
                            .frame(width: 200, height: 200)
                            .foregroundStyle(.red)
                            .transition(.move(edge: .bottom))
                    } else {
                        Image(systemName: "pin")
                            .font(.largeTitle.bold())
                            .frame(width: 200, height: 200)
                            .foregroundStyle(.blue)
                            .transition(.move(edge: .top))
                    }
                }
                .clipped()
                .shadow(radius: 5)
            
            Button("Toggle") {
                withAnimation(.bouncy) {
                    toggle.toggle()
                }
            }
            .offset(y: 300)
        }
    }
}

#Preview {
    TestGeometryEffect()
}
