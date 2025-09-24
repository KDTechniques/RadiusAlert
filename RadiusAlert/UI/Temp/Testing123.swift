//
//  Testing123.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-09-24.
//

import Foundation
import SwiftUI
import TipKit

import SwiftUI
import TipKit

struct TipDemoView: View {
   let tip = RadiusSliderTipModel()
    
    var body: some View {
        VStack {
            Text("Hello")
                .popoverTip(tip)
            
            Button("Trigger Tip") {
                RadiusSliderTipModel.isSetRadius.toggle()
            }
            
            Button("Manually Invalidate") {
                tip.invalidate(reason: .actionPerformed)
            }
        }
    }
}


#Preview {
    TipDemoView()
}
