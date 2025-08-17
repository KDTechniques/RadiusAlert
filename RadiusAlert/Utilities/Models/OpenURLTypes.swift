//
//  OpenURLTypes.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-13.
//

import UIKit

enum OpenURLTypes {
    case settings,whatsApp, facebook, gitHub
    
    var string: String {
        switch self {
        case .settings:
            return ""
        case .whatsApp:
            return "WhatsApp"
        case .facebook:
            return "Facebook"
        case .gitHub:
            return "GitHub"
        }
    }
    
    var icon: ImageResource? {
        switch self {
        case .whatsApp:
            return .whatsApp
        case .facebook:
            return .facebook
        case .gitHub:
            return .gitHub
        default:
            return nil
        }
    }
    
    private var url: URL? {
        switch  self {
        case .settings:
            return .init(string: UIApplication.openSettingsURLString)
        case .whatsApp:
            return .init(string: "https://wa.me/94770050165")
        case .facebook:
            return .init(string: "https://facebook.com/kdtechniques")
        case .gitHub:
            return .init(string: "https://github.com/KDTechniques/RadiusAlert")
        }
    }
    
    func openURL() {
        guard let url, UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
}
