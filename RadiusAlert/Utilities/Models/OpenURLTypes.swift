//
//  OpenURLTypes.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-13.
//

import UIKit

enum OpenURLTypes {
    case whatsApp, facebook, gitHub, linkedIn
    case appStore
    case settings, notifications
    
    var rawValue: String {
        switch self {
        case .whatsApp:
            return "WhatsApp"
            
        case .facebook:
            return "Facebook"
            
        case .linkedIn:
            return "LinkedIn"
            
        case .gitHub:
            return "GitHub"
            
        default:
            return ""
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
            
        case .linkedIn:
            return .linkedin
            
        default:
            return nil
        }
    }
    
    func openURL() {
        guard let url, UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    private var url: URL? {
        switch  self {
        case .settings:
            return .init(string: UIApplication.openSettingsURLString)
            
        case .notifications:
            return .init(string: UIApplication.openNotificationSettingsURLString)
            
        case .whatsApp:
            return .init(string: "https://wa.me/94770050165")
            
        case .facebook:
            return .init(string: "https://facebook.com/kdtechniques")
            
        case .gitHub:
            return .init(string: "https://github.com/KDTechniques/RadiusAlert")
            
        case .linkedIn:
            return .init(string: "https://www.linkedin.com/in/paramsoodi")
            
        case .appStore:
            return .init(string: "https://apps.apple.com/app/284882215?action=write-review")
        }
    }
}
