//
//  Public Functions.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-31.
//

import UIKit

func openAppSettings() {
    guard let url = URL(string: UIApplication.openSettingsURLString),
          UIApplication.shared.canOpenURL(url) else {
        return
    }
    
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
}
