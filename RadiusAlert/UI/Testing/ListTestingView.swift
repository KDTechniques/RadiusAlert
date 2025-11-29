//
//  ListTestingView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-29.
//

import SwiftUI

struct ListTestingView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Recent Searches")
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                NavigationLink {
                    Text("Hello there...")
                } label: {
                    Text("See All")
                }
            }
            .font(.subheadline)
            .padding()
            
            Divider()
            
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    Button {
                        
                    } label: {
                        SearchResultListRowView(
                            title: "Title 1 Goes Here",
                            subTitle: "Subtitle 1 goes here",
                            showSeparator: true
                        )
                    }
                    .buttonStyle(.plain)
                    
                    SearchResultListRowView(
                        title: "Title 2 Goes Here",
                        subTitle: "Subtitle 2 goes here",
                        showSeparator: true
                    )
                    
                    SearchResultListRowView(
                        title: "Title 3 Goes Here",
                        subTitle: "Subtitle 3 goes here",
                        showSeparator: true
                    )
                    
                    SearchResultListRowView(
                        title: "Title 4 Goes Here",
                        subTitle: "Subtitle 4 goes here",
                        showSeparator: false
                    )
                    
                    Button("Clear All") {
                        
                    }
                    .font(.subheadline)
                    .padding(.vertical)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ListTestingView()
    }
    .previewModifier()
}
