//
//  Custom_RadioButtonListRowView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-08-24.
//

import SwiftUI

struct Custom_RadioButtonListRowView<T: View>: View {
    // MARK: - INJECTED PROPERTIES
    let isSelected: Bool
    let content: T
    let action: () -> Void
    
    // MARK: - INITIALIZER
    init(isSelected: Bool, _ content: @escaping () -> T, action: @escaping () -> Void) {
        self.isSelected = isSelected
        self.content = content()
        self.action = action
    }
    
    // MARK: - BODY
    var body: some View {
        let imageName: String = isSelected ? "inset.filled.circle" : "circle"
        
        Button {
            action()
        } label: {
            HStack {
                content
                
                Spacer()
                
                Image(systemName: imageName)
                    .foregroundStyle(Color.accentColor)
            }
        }
    }
}

// MARK: - PREVIEWS
#Preview("Custom_RadioButtonListRowView") {
    @Previewable @State var isSelected: Bool = .random()
    
    List {
        Custom_RadioButtonListRowView(isSelected: isSelected) {
            Text("Content goes here...")
                .tint(.primary)
        } action: {
            isSelected.toggle()
        }
    }
    .previewModifier()
}
