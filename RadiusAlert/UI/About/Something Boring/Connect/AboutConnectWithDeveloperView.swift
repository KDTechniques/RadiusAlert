//
//  AboutConnectWithDeveloperView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-13.
//

import SwiftUI

struct AboutConnectWithDeveloperView: View {
    // MARK: - BODY
    var body: some View {
        NavigationLink {
            Content()
        } label: {
            Text("Connect with Kavinda 👋")
        }
    }
}

// MARK: - PREVIEWS
#Preview("About - Connect with Developer") {
    NavigationStack {
        Content()
    }
    .previewModifier()
}

// MARK: - SUB VIEWS
fileprivate struct Content: View {
    @State private var showExpandedPhoto: Bool = false
    @Namespace private var photo
    let nameSpaceID: String = "photo"
    let socialMediaTypes: [OpenURLTypes] = [.whatsApp, .facebook, .linkedIn, .gitHub]
    let reasons: [String] = [
        "To share some love ❤️",
        "If you found a bug 🐞",
        "If you have a concern 🤔",
        "To share an idea 💡",
        "To suggest an improvement ✨",
        "If there’s something you don’t like 👎"
    ]
    
    var body: some View {
        List {
            reasonsSection
            sources
        }
        .overlay { if showExpandedPhoto { expandedPhoto } }
        .navigationTitle(Text("Connect with Kavinda"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(showExpandedPhoto)
    }
}

extension Content {
    private var developerImage: some View {
        Image(.developer)
            .resizable()
            .scaledToFit()
            .clipShape(.circle)
            .matchedGeometryEffect(id: nameSpaceID, in: photo)
            .frame(width: 50, height: 50)
            .onTapGesture { handlePhotoTap() }
            .padding(.top, 4)
    }
    
    private var expandedPhoto: some View {
        Color.clear
            .overlay {
                Image(.developer)
                    .resizable()
                    .scaledToFit()
                    .matchedGeometryEffect(id: nameSpaceID, in: photo)
            }
            .background(.ultraThinMaterial)
            .onTapGesture { handlePhotoTap() }
    }
    
    private var nameNAbout: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Kavinda Dilshan".uppercased())
                .font(.title3.weight(.bold))
            
            Text("Founder of Alert Radius | Native iOS Developer | Apple Mac Technician at OneMac (Pvt) Ltd, Sri Lanka")
                .foregroundStyle(.secondary)
                .font(.footnote)
        }
    }
    
    private var reasonPoints: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("You can connect with me for any of the following reasons:")
                .fontWeight(.medium)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
            
            VStack(alignment: .leading, spacing: 5) {
                ForEach(reasons,id: \.self) {
                    Text("• \($0)")
                }
            }
        }
    }
    
    private var reasonsSection: some View {
        Section {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top) {
                    Group {
                        if showExpandedPhoto {
                            Color.clear
                        } else {
                            developerImage
                        }
                    }
                    .frame(width: 50, height: 50)
                    
                    nameNAbout
                }
                
                Divider()
                
                reasonPoints
            }
        }
    }
    
    private var sources: some View {
        Section {
            ForEach(socialMediaTypes, id: \.self) {
                AboutConnectSocialMediaLinkView(type: $0)
            }
        }
    }
    
    private func handlePhotoTap() {
        withAnimation(.snappy(duration: 0.25)) {
            showExpandedPhoto.toggle()
        }
    }
}
