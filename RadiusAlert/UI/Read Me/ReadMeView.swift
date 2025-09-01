//
//  ReadMeView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-01.
//

import SwiftUI

struct ReadMeView: View {
    // MARK: - INJECTED PROPERTIES
    @Binding var isPresented: Bool
    
    // MARK: - INITIALIZER
    init(isPresented: Binding<Bool>) {
        _isPresented = isPresented
    }
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .onTapGesture {
                    isPresented.toggle()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(25)
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Design")
                    .font(.title.weight(.semibold))
                
                Text("Built for purpose.\nWith a purpose.")
                    .font(.system(size: 58))
                    .fontWeight(.bold)
                
                Text("At just five by five inches,Mac mini is an epic little space-saver designed to put ports and possibilities right where you need them. It fits perfectly next to a monitor and is easy to move, rack, or mount just about anywhere. Mac mini is also built with the environment in mind — in fact, it's the first carbon neutral Mac, helping lead the way toward Apple 2030.")
                    .font(.title2.weight(.semibold))
            }
            .padding(.horizontal, 50)
            
            Spacer()
            
        }
        .presentationCornerRadius(40)
    }
}

// MARK: - PREVIEWS
#Preview("Read Me") {
    @Previewable @State var isPresented: Bool = true
    
    Color.clear
        .sheet(isPresented: $isPresented) {
            ReadMeView(isPresented: $isPresented)
        }
        .previewModifier()
}
