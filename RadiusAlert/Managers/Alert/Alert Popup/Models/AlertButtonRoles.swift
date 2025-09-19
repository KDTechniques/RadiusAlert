//
//  AlertButtonRoles.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-31.
//

import Foundation

/// Represents the role and style of an alert button.
///
/// The role determines the button’s appearance and behavior in an alert.
///
/// Example usage:
/// ```swift
/// let okButton = AlertButtonModel(role: .ok)
/// let cancelButton = AlertButtonModel(role: .cancel)
/// let destructiveButton = AlertButtonModel(role: .destructive("Delete"))
/// let customButton = AlertButtonModel(role: .custom("Retry"))
/// ```
enum AlertButtonRoles {
    case custom(_: String), destructive(_: String)
    case ok, cancel
}
