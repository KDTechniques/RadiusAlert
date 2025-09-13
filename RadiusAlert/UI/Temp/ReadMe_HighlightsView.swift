//
//  ReadMe_HighlightsView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-09-13.
//

import SwiftUI

struct ReadMe_Highlights_ImageResourceValues {
    private let hPadding: CGFloat
    
    init(hPadding: CGFloat) {
        self.hPadding = hPadding
    }
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    private var availableWidth: CGFloat { screenWidth - hPadding*2 }
    private let middleImageToScreenWidthRatio: CGFloat = 2.8
    let imageToImageWidthRatio: CGFloat = 1.15
    
    // Widths
    var middleImageWidth: CGFloat { availableWidth/middleImageToScreenWidthRatio }
    var leftRightImage1Width: CGFloat { middleImageWidth/imageToImageWidthRatio }
    var leftRightImage2Width: CGFloat { leftRightImage1Width/imageToImageWidthRatio }
    
    // Offsets
    var offsetFraction: CGFloat { middleImageToScreenWidthRatio }
    var offset1: CGFloat { middleImageWidth / offsetFraction }
    var offset2: CGFloat { middleImageWidth / offsetFraction * 2 }
}

enum ReadMe_Highlights_ImageResourceTypes {
    // // Left 2
    case highlightsLeft2Dark, highlightsLeft2Light
    
    // Left 1
    case highlightsLeft1Dark, highlightsLeft1Light
    
    // Middle
    case highlightsMiddleDark, highlightsMiddleLight
    
    // Right 1
    case highlightsRight1Dark, highlightsRight1Light
    
    // Right 2
    case highlightsRight2Dark, highlightsRight2Light
    
    static func getImageResourceTypesOnColorScheme(_ colorScheme: ColorScheme) -> [Self] {
        switch colorScheme {
        case .light:
            return [.highlightsLeft2Light, .highlightsLeft1Light, .highlightsMiddleLight, .highlightsRight1Light, .highlightsRight2Light]
            
        case .dark:
            return [.highlightsLeft2Dark, .highlightsLeft1Dark, .highlightsMiddleDark, .highlightsRight1Dark, .highlightsRight2Dark]
            
        default:
            return  [.highlightsLeft2Dark, .highlightsLeft1Dark, .highlightsMiddleDark, .highlightsRight1Dark, .highlightsRight2Dark]
        }
    }
    
    func width(_ values: ReadMe_Highlights_ImageResourceValues) -> CGFloat {
        switch self {
        case .highlightsLeft2Dark, .highlightsLeft2Light, .highlightsRight2Dark, .highlightsRight2Light:
            return values.leftRightImage2Width
            
        case .highlightsLeft1Dark, .highlightsLeft1Light, .highlightsRight1Dark, .highlightsRight1Light:
            return values.leftRightImage1Width
            
        case .highlightsMiddleDark, .highlightsMiddleLight:
            return values.middleImageWidth
        }
    }
    
    func offsetX(_ values: ReadMe_Highlights_ImageResourceValues)  -> CGFloat {
        switch self {
        case .highlightsLeft2Dark, .highlightsLeft2Light:
            return values.offset2
            
        case .highlightsLeft1Dark, .highlightsLeft1Light:
            return values.offset1
            
        case .highlightsMiddleDark, .highlightsMiddleLight:
            return .zero
            
        case .highlightsRight1Dark, .highlightsRight1Light:
            return -values.offset1
            
        case .highlightsRight2Dark, .highlightsRight2Light:
            return -values.offset2
        }
    }
    
    func initialOffsetX(_ values: ReadMe_Highlights_ImageResourceValues) -> CGFloat {
        let firstImageOffset: CGFloat = values.leftRightImage1Width + (values.middleImageWidth-values.leftRightImage1Width)/2
        let secondImageOffset: CGFloat = values.leftRightImage1Width + (values.middleImageWidth-values.leftRightImage1Width)/2 + values.leftRightImage2Width + (values.leftRightImage1Width-values.leftRightImage2Width)/2
        
        switch self {
        case .highlightsLeft2Dark, .highlightsLeft2Light:
            return secondImageOffset
            
        case .highlightsLeft1Dark, .highlightsLeft1Light:
            return firstImageOffset
            
        case .highlightsMiddleDark, .highlightsMiddleLight:
            return .zero
            
        case .highlightsRight1Dark, .highlightsRight1Light:
            return -firstImageOffset
            
        case .highlightsRight2Dark, .highlightsRight2Light:
            return -secondImageOffset
        }
    }
    
    var zIndex: Double {
        switch self {
        case .highlightsLeft2Dark, .highlightsLeft2Light, .highlightsRight2Dark, .highlightsRight2Light:
            return 0
            
        case .highlightsLeft1Dark, .highlightsLeft1Light, .highlightsRight1Dark, .highlightsRight1Light:
            return 1
            
        case .highlightsMiddleDark, .highlightsMiddleLight:
            return 2
        }
    }
    
    var imageResource: ImageResource {
        switch self {
        case .highlightsLeft2Dark:
            return .highlightsLeft2Dark
        case .highlightsLeft2Light:
            return .highlightsLeft2Light
        case .highlightsLeft1Dark:
            return .highlightsLeft1Dark
        case .highlightsLeft1Light:
            return .highlightsLeft1Light
        case .highlightsMiddleDark:
            return .highlightsMiddleDark
        case .highlightsMiddleLight:
            return .highlightsMiddleLight
        case .highlightsRight1Dark:
            return .highlightsRight1Dark
        case .highlightsRight1Light:
            return .highlightsRight1Light
        case .highlightsRight2Dark:
            return .highlightsRight2Dark
        case .highlightsRight2Light:
            return .highlightsRight2Light
        }
    }
}

struct ReadMe_HighlightsView: View {
    // MARK:- INJECTED PROPERTIES
    let values: ReadMe_Highlights_ImageResourceValues
    let images: [ReadMe_Highlights_ImageResourceTypes]
    
    // MARK: - INITIALIZER
    init(_ colorScheme: ColorScheme, hPadding: CGFloat) {
        images = ReadMe_Highlights_ImageResourceTypes.getImageResourceTypesOnColorScheme(colorScheme)
        values = ReadMe_Highlights_ImageResourceValues.self(hPadding: hPadding)
    }
    
    // MARK: - ASSIGNED PROPERTIES
    @State private var animate: Bool = false
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: 0) {
            ForEach(images, id: \.self) { image in
                Image(image.imageResource)
                    .resizable()
                    .scaledToFit()
                    .frame(width: image.width(values))
                    .offset(x: animate ? image.offsetX(values) : image.initialOffsetX(values))
                    .zIndex(image.zIndex)
                    .animation(.smooth(duration: 1), value: animate)
            }
        }
        .onAppear {
            Task {
                try? await Task.sleep(nanoseconds: 300_000_000)
                animate.toggle()
            }
        }
    }
}

// MARK: - PREVIEWS
#Preview("ReadMe_HighlightsView") {
    @Previewable @Environment(\.colorScheme) var colorScheme
    
    ReadMe_HighlightsView(colorScheme, hPadding: 20)
        .previewModifier()
}
