//
//  TextToSpeechValues.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-16.
//

import Foundation

struct TextToSpeechValues {
    static func defaultText(userName: String?, locationTitle: String?) -> String {
        let userName: String = userName == nil ? "" : "\(userName!), "
        
        if let locationTitle {
            return userName + "you are close to \(locationTitle.noEmojisNSpaces)."
        } else {
            return userName + "you’ve arrived at your location."
        }
    }
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
