//
//  ContentView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-07-27.
//

import SwiftUI
import SearchBarSwiftUI
import MapKit

struct ContentView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(LocationManager.self) private var locationManager
    
    // ASSIGNED PROPERTIES
    @State private var searchText: String = ""
    @Namespace private var mapSpace
    
    @State private var position: MapCameraPosition = .automatic
    @State private var centerCoordinate: CLLocationCoordinate2D?
    @State private var radius: CLLocationDistance = 500
    
    var body: some View {
        NavigationStack {
            ZStack {
                MapView()
                    .overlay {
                        Image(systemName: "mappin")
                            .font(.title)
                            .foregroundStyle(.red)
                        
                        Text("Alert Radius\n\(Int(radius))m")
                            .font(.caption)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                            .offset(y: 30)
                            .opacity(centerCoordinate == nil ? 0 : 1)
                    }
                    .overlay(alignment: .bottomTrailing) {
                        Slider(value: $radius, in: 300...1000, step: 100)
                            .frame(width: 200)
                            .padding(.trailing)
                    }
            }
            .safeAreaInset(edge: .top, spacing: 0) {
                VStack(spacing: 0) {
                    ZStack {
                        Text("Radius Alert")
                            .fontWeight(.semibold)
                        
                        NavigationLink {
                            // Settings View goes here...
                        } label: {
                            Image(systemName: "gear")
                                .font(.title2)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.horizontal)
                        }
                    }
                    
                    SearchBarView(searchBarText: $searchText, placeholder: "Search", context: .navigation, customColors: nil) { _ in }
                        .padding(.vertical)
                    
                    Divider()
                }
                .background(.ultraThinMaterial)
            }
            .safeAreaInset(edge: .bottom, spacing: 0) {
                if true {
                    Button {
                        // action goes here...
                    } label: {
                        Text("Alert Me Here")
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical)
                            .background(.green, in: .rect(cornerRadius: 12))
                            .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.ultraThinMaterial)
                } else {
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
            .toolbarVisibility(.hidden, for: .navigationBar)
        }
        .onAppear {
            guard let position: MapCameraPosition = locationManager.getInitialUserCurrentLocation() else { return }
            self.position = position
        }
    }
}

#Preview {
    ContentView()
}
