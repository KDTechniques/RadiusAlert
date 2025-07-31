//
//  Testing123.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-31.
//

import SwiftUI

struct Testing123: View {
    var body: some View {
        VStack {
            Button("Play") {
                DefaultToneManager.shared.playDefaultTone()
            }
            
            Button("Stop") {
                DefaultToneManager.shared.stopDefaultTone()
            }
        }
    }
}

#Preview {
    Testing123()
}
