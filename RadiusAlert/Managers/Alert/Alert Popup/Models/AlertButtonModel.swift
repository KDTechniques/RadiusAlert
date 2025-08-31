//
//  AlertButtonModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-31.
//

import SwiftUI

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
