//
//  RadiusSliderTipModel.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-23.
//

import TipKit

struct RadiusSliderTipModel: Tip {
    //    let action: () -> Void
    
    @Parameter
    static var isSetRadius: Bool = false
    
    var title: Text {
        Text("Adjust Radius")
            .foregroundStyle(Color.accentColor)
    }
    
    var message: Text? {
        Text("Drag the slider to change the search radius on the map.")
    }
    
    var image: Image? {
        Image(systemName: "circle")
    }
    
    var actions: [Action] {
        [
            .init(id: "radius-slider-tip-action", title: "Show me how") {
                
                print("Tip action executed! 🙋🏻‍♂️🙋🏻‍♂️🙋🏻‍♂️🙋🏻‍♂️🙋🏻‍♂️🙋🏻‍♂️🙋🏻‍♂️🙋🏻‍♂️🙋🏻‍♂️🙋🏻‍♂️🙋🏻‍♂️🙋🏻‍♂️🙋🏻‍♂️🙋🏻‍♂️")
            }
        ]
    }
    
    var rules: [Rule] { [ #Rule(Self.$isSetRadius) { $0 } ] }
}
