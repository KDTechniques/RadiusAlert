//
//  OpenURLTypes.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-13.
//

import UIKit

/// Defines supported external and system URLs that can be opened within the app.
/// Each case provides a corresponding display name (`rawValue`), optional icon,
/// and a method to safely open its associated URL.
///
/// Example usage:
/// ```swift
/// // Open the app's App Store review page
/// OpenURLTypes.appStore.openURL()
///
/// // Open LinkedIn profile
/// OpenURLTypes.linkedIn.openURL()
///
/// // Get an icon for display
/// let icon = OpenURLTypes.gitHub.icon
/// ```
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
            return .init(string: "https://apps.apple.com/app/6752566436?action=write-review")
        }
    }
}
