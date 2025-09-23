//
//  RadiusSliderTipModel.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-23.
//

import TipKit

struct RadiusSliderTipModel: Tip {
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
                NotificationCenter.default.post(
                    name: .radiusSliderTipDidTrigger,
                    object: nil
                )
            }
        ]
    }
    
    var rules: [Rule] { [ #Rule(Self.$isSetRadius) { $0 } ] }
    
//    var options: [any TipOption] {
//        [
//            Tips.MaxDisplayCount(1)
//        ]
//    }
}




extension Notification.Name {
    static let radiusSliderTipDidTrigger = Notification.Name("radiusSliderTipDidTrigger")
}
