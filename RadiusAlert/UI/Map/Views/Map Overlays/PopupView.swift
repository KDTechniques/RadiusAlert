//
//  PopupView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-08.
//

import SwiftUI

struct PopupView: View {
    var body: some View {
        VStack {
            // Toolbar
            HStack {
                Button("Save") {
                    // action goes here...
                }
                
                Spacer()
                
                Button {
                    // action goes here...
                } label: {
                    Image(systemName: "xmark")
                        .font(.footnote)
                        .fontWeight(.heavy)
                        .foregroundStyle(.secondary)
                        .padding(7)
                        .background(.regularMaterial, in: .circle)
                }
                .buttonStyle(.plain)
            }
            
            VStack {
                // Title
                Text("It's time!")
                    .font(.title)
                    .bold()
                
                // Subtitle
                Text("You've arrived to your destination radius")
                    .foregroundStyle(.secondary)
                    .font(.callout)
                    .multilineTextAlignment(.center)
            }
            .padding(.vertical)
            
            // Location Title
            VStack {
                Image(systemName: "mappin.and.ellipse")
                    .symbolRenderingMode(.hierarchical)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.red.gradient)
                    .frame(width: 50)
                
                Text("Pettah")
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .font(.title3)
                    .bold()
            }
            
            Divider()
                .padding(.vertical, 10)
            
            // Details
            HStack(spacing: 10) {
                VStack(alignment: .leading) {
                    Text("Radius".uppercased())
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                    
                    HStack(spacing: 5) {
                        Image(systemName: "circle.circle.fill")
                        
                        Text("700m")
                            .font(.footnote)
                            .bold()
                    }
                    .foregroundStyle(.red)
                }
                
                Rectangle()
                    .fill(Color(uiColor: .separator))
                    .frame(width: 1,  height: 30)
                
                VStack(alignment: .leading) {
                    Text("Duration".uppercased())
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                    
                    HStack(spacing: 5) {
                        Image(systemName: "stopwatch.fill")
                            .foregroundStyle(.secondary)
                        
                        Text("43 min.")
                            .font(.footnote)
                            .bold()
                    }
                }
                
                Rectangle()
                    .fill(Color(uiColor: .separator))
                    .frame(width: 1,  height: 30)
                
                VStack(alignment: .leading) {
                    Text("Distance".uppercased())
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                    
                    HStack(spacing: 5) {
                        Image(systemName: "point.topleft.down.to.point.bottomright.curvepath.fill")
                            .foregroundStyle(.secondary)
                        
                        Text("34 km")
                            .font(.footnote)
                            .bold()
                    }
                }
            }
            
            // CTA Button
            Button {
                // action goes here...
            } label: {
                Text("OK")
                    .foregroundStyle(.black)
                    .fontWeight(.medium)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
            }
            .background(.regularMaterial, in: .rect(cornerRadius: 12))
            .padding(.top)
        }
        .padding()
        .background(.white, in: .rect(cornerRadius: 20))
        .padding(.horizontal, 50)
    }
}

// MARK: - PREVIEWS
#Preview {
    PopupView()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.regularMaterial)
        .ignoresSafeArea()
}
