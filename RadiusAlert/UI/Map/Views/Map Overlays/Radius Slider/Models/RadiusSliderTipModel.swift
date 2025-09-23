//
//  RadiusSliderTipModel.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-23.
//

import TipKit

struct RadiusSliderTipModel: Tip {
    var title: Text {
        Text("Adjust Radius")
            .foregroundStyle(Color.accentColor)
    }
    
    var message: Text? {
        Text("Drag the slider to change the search radius on the map.")
    }
    
    var image: Image? {
        Image(systemName: "circle.fill")
    }
    
    var actions: [Action] {
        [
            .init(id: "radius-slider-tip-action", title: "Show me how") {
                print("Tip action executed!")
            }
        ]
    }
    
    var options: [any TipOption] {
        [
            
        ]
    }
}
