//
//  HorizontalPinView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-03.
//

import SwiftUI

struct HorizontalPinView: View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                Button {
                    
                } label: {
                    Text("💼 OneMac")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .background()
                        .clipShape(.capsule)
                        .font(.subheadline)
                        .foregroundStyle(.black)
                        .shadow(color: .black.opacity(0.2), radius: 1)
                }
                
                Button {
                    
                } label: {
                    Text("🚏 Pettah Market")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .background()
                        .clipShape(.capsule)
                        .font(.subheadline)
                        .foregroundStyle(.black)
                        .shadow(color: .black.opacity(0.2), radius: 1)
                }
                
                Button {
                    
                } label: {
                    Text("🛣️ Katunayake Highway Exit")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .background()
                        .clipShape(.capsule)
                        .font(.subheadline)
                        .foregroundStyle(.black)
                        .shadow(color: .black.opacity(0.2), radius: 1)
                }
                
                Button {
                    
                } label: {
                    Label("More", systemImage: "ellipsis")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .background()
                        .clipShape(.capsule)
                        .font(.subheadline.weight(.semibold))
                        .shadow(color: .black.opacity(0.2), radius: 1)
                }
                
                Button {
                    
                } label: {
                    Label("Add", systemImage: "plus")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .background()
                        .clipShape(.capsule)
                        .font(.subheadline.weight(.semibold))
                        .shadow(color: .black.opacity(0.2), radius: 1)
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
            .padding(.top, 1)
        }
        .scrollIndicators(.never)
    }
}

#Preview {
    HorizontalPinView()
}

