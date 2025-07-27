//
//  TestingView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-07-27.
//

import SwiftUI

struct TestingView: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                ForEach(0...20, id: \.self) { number in
                    Button {
                        print("Hello: \(number)")
                    } label: {
                        VStack(spacing: 10) {
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Starbucks")
                                        .fontWeight(.medium)
                                    
                                    Text("Hello")
                                        .font(.callout)
                                        .foregroundStyle(.secondary)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.horizontal)
                            .padding(.top, 10)
                            
                            Divider()
                        }
                        .background(.red.opacity(0.001))
                    }
                    .buttonStyle(.plain)
                }
            }
            
        }
    }
}

#Preview {
    TestingView()
}
