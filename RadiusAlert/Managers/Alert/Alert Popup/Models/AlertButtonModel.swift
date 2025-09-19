//
//  AlertButtonModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-31.
//

import SwiftUI

/// A model representing a button for use in alerts.
///
/// Each `AlertButtonModel` has a unique identifier, a role, and an associated action.
/// The role determines the button’s appearance and behavior in an alert,
/// such as `.ok`, `.cancel`, `.destructive`, or a custom label.
///
/// Returns a SwiftUI `Button` view configured according to the button’s role via the `button` property.
///
/// Example usage:
/// ```swift
/// let okButton = AlertButtonModel(role: .ok)
/// let customButton = AlertButtonModel(role: .custom("Retry")) { print("Retry tapped") }
/// ```
struct AlertButtonModel: Identifiable {
    let id: String = UUID().uuidString
    let role: AlertButtonRoles
    let action: () -> Void
    
    init(role: AlertButtonRoles, action: @escaping () -> Void = { }) {
        self.role = role
        self.action = action
    }
    
    
    var button: some View {
        switch role {
        case .custom(let label):
            return Button(label, role: .none) {
                action()
            }
            
        case .ok:
            return Button("OK", role: .none) {
                action()
            }
            
        case .cancel:
            return Button("Cancel", role: .cancel) {
                action()
            }
            
        case .destructive(let label):
            return Button(label, role: .destructive) {
                action()
            }
        }
    }
}
