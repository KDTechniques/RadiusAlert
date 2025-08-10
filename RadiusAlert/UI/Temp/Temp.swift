//import SwiftUI
//import MapKit
//
//
//
//
//
//struct POISearchView: View {
//    @State private var query = ""
//    @State private var selectedCoordinate: CLLocationCoordinate2D?
//    @State private var isSearching = false
//    
//    let service = POISearchService()
//    
//    var body: some View {
//        NavigationStack {
//            List(service.results, id: \.self) { item in
//                Button {
//                    Task {
//                        isSearching = true
//                        do {
//                            selectedCoordinate = try await service.coordinates(for: item)
//                        } catch {
//                            print("Search error:", error)
//                        }
//                        isSearching = false
//                    }
//                } label: {
//                    VStack(alignment: .leading) {
//                        Text(item.title)
//                        if !item.subtitle.isEmpty {
//                            Text(item.subtitle)
//                                .font(.caption)
//                                .foregroundStyle(.secondary)
//                        }
//                    }
//                }
//            }
//            .searchable(text: $query)
//            .onChange(of: query) { service.update(query: $1) }
//            .overlay {
//                if isSearching {
//                    ProgressView()
//                }
//            }
//            .navigationTitle("POI Search")
//            .toolbar {
//                if let coordinate = selectedCoordinate {
//                    Text("Lat: \(coordinate.latitude), Lon: \(coordinate.longitude)")
//                        .font(.caption)
//                        .foregroundStyle(.secondary)
//                }
//            }
//        }
//    }
//}
