//
//  TestingView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2026-01-30.
//

import SwiftUI

struct TestingView: View {
    var body: some View {
        if #available(iOS 26, *) {
            Button {
                
            } label: {
                Text("Stop All Alerts")
                    .fontWeight(.semibold)
                    .foregroundStyle(.red)
                    .padding(.vertical)
                    .frame(width: Utilities.screenWidth * 0.7)
                    .glassEffect(.regular.tint(.red.opacity(0.2)), in: .capsule)
            }
        } else {
            
        }
    }
}

#Preview {
    TestingView()
}
