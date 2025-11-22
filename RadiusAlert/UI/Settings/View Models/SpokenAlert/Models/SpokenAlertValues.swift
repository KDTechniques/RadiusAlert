//
//  SpokenAlertValues.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-16.
//

import Foundation

struct SpokenAlertValues {
    static func getPhrase(userName: String, locationTitle: String?) -> String {
        let userName: String = userName.isEmpty ? "" : "\(userName), "
        
        if let locationTitle {
            return userName + "you are close to \(locationTitle.noEmojisNSpaces)."
        } else {
            return userName + "you’ve arrived at your location."
        }
    }
    
    static let maxUserNameCharacters: Int = 15
    static let speakingRateRange: ClosedRange<CGFloat> = 0...0.5
    static let pitchRateRange: ClosedRange<CGFloat> = 0...1.5
    static let step: CGFloat = 0.1
}

fileprivate extension String {
    var noEmojisNSpaces: String {
        self.unicodeScalars
            .filter { !$0.properties.isEmojiPresentation }         // remove emojis
            .map { String($0) }
            .joined()
            .replacingOccurrences(of: "\\s+",                      // fix extra spaces
                                  with: " ",
                                  options: .regularExpression)
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
