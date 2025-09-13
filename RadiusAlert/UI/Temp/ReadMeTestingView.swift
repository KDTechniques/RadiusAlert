//
//  ReadMeTestingView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-09-07.
//

import SwiftUI

struct ReadMeTestingView: View {
    
    @Binding var isPresented: Bool
    @State private var animate: Bool = false
    
    init(_ isPresented: Binding<Bool>) {
        _isPresented = isPresented
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                Image(.readMePhoto0)
                    .resizable()
                    .scaledToFit()
                    .overlay(alignment: .bottom) {
                        Image(.readMePhoto0)
                            .resizable()
                            .scaledToFit()
                            .mask(alignment: .bottom) {
                                Rectangle()
                                    .frame(height: 200)
                            }
                            .blur(radius: 5)
                        
                        
                    }
                    .overlay {
                        VStack(spacing: 10) {
                            ReadMe_MorphAnimationView {
                                animate = true
                            }
                            
                            Text("Radius Alert is an iOS app designed to solve a simple but common problem: falling asleep or getting distracted during your bus or train ride and missing your stop.")
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                                .font(.callout)
                            
                        }
                        .padding(30)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                    }
                
                ReadMe_HighlightsView(hPadding: 20, animate: animate)
                    .padding(.vertical, 20)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("🚌 Why Radius Alert?")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("If you’ve ever dozed off or gotten lost in your iPhone on a commute, you know the fear:")
                        .foregroundStyle(.secondary)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            Image(.readMePhoto2)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 250, height: 320)
                                .overlay(alignment: .top) {
                                    Color.black.opacity(0.3)
                                        .frame(height: 70)
                                }
                                .clipShape(.rect(cornerRadius: 25))
                                .overlay(alignment: .topLeading) {
                                    Text("😴 Falling asleep during your ride.")
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                        .padding()
                                }
                            
                            Image(.readMePhoto3)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 250, height: 320)
                                .overlay(alignment: .top) {
                                    Color.black.opacity(0.3)
                                        .frame(height: 70)
                                }
                                .clipShape(.rect(cornerRadius: 25))
                                .overlay(alignment: .topLeading) {
                                    Text("😨 Missing your stop.")
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                        .padding()
                                }
                            
                            Image(.readMePhoto4)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 250, height: 320)
                                .overlay(alignment: .top) {
                                    Color.black.opacity(0.3)
                                        .frame(height: 70)
                                }
                                .clipShape(.rect(cornerRadius: 25))
                                .overlay(alignment: .topLeading) {
                                    Text("🚶‍♂️ Having to walk (or pay extra) just to get back.")
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                        .padding()
                                }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .scrollBounceBehavior(.basedOnSize)
                    .scrollIndicators(.hidden)
                    .padding(.top, 30)
                    
                    Text("Radius Alert takes that stress away. Just set your stop, relax, listen to music, even take a nap and the app will wake you up right on time.")
                        .foregroundStyle(.secondary)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    // Key Features
                    
                    Text("✨ Key Features")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top, 50)
                    
                    Text("🎯 Smart Radius Alerts")
                        .foregroundStyle(.white)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    ScrollView(.horizontal) {
                        HStack(alignment: .top, spacing: 20) {
                            VStack(alignment: .leading,spacing: 20) {
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(.regularMaterial)
                                    .frame(width: 250, height: 320)
                                    .overlay {
                                        Image(.readMePhoto5Dark)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 200)
                                            .offset(y: 75)
                                    }
                                    .clipped()
                                
                                Text("**Pick your stop on the map.** Move the map and set your stop atleast 1km ahead of your current location. Otherwise you won't see the map pin in red.")
                                    .font(.footnote)
                                    .frame(width: 200)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            
                            VStack(alignment: .leading,spacing: 20) {
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(.regularMaterial)
                                    .frame(width: 250, height: 320)
                                    .overlay {
                                        Image(.readMePhoto5Dark)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 200)
                                            .offset(y: 75)
                                    }
                                    .clipped()
                                
                                Text("**or Search for a location.** Use the search bar to search your stop, or location and pick a result from the list.")
                                    .font(.footnote)
                                    .frame(width: 200)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            
                            VStack(alignment: .leading,spacing: 20) {
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(.regularMaterial)
                                    .frame(width: 250, height: 320)
                                    .overlay {
                                        Image(.readMePhoto5Dark)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 200)
                                            .offset(y: 75)
                                    }
                                    .clipped()
                                
                                Text("**Pick your stop on the map.** Move the map and set your stop atleast 1km ahead of your current location. Otherwise you won't see the map pin in red.")
                                    .font(.footnote)
                                    .frame(width: 200)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    .padding(.top, 30)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
            }
        }
        .overlay(alignment: .topTrailing) {
            ReadMe_DismissButtonView {
                isPresented = false
            }
            .padding(20)
        }
    }
}

#Preview("On Sheet") {
    Color.clear
        .sheet(isPresented: .constant(true)) {
            ReadMeTestingView(.constant(true))
                .presentationCornerRadius(40)
        }
}

#Preview("Without Sheet") {
    VStack {
        ReadMeTestingView(.constant(true))
            .background {
                Color.clear
                    .background(.regularMaterial)
                    .ignoresSafeArea()
            }
        
        Spacer()
    }
}
