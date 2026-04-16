//
//  Image.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-10-30.
//

import SwiftUI

extension Image {
    /// Provides easy access to custom images.
    /// Avoids repeatedly using the full model path for each image.
    /// Example: Image(.custom.SocialMediaIcons.facebook.image)
    static let custom = CustomImages.self
}
