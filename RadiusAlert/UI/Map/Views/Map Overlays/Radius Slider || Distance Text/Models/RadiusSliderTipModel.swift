//
//  RadiusSliderTipModel.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-23.
//

import TipKit

struct RadiusSliderTipModel: Tip {
    // Presentation
    var title: Text { .init("Adjust Radius") }
    var message: Text? { .init("Drag the slider to change the alert radius on the map.") }
    var image: Image? { .init(systemName: "circle") }
    var actions: [Action] { [
        .init(title: "Show me how") {
            NotificationCenter.default.post(
                name: .radiusSliderTipDidTrigger,
                object: nil
            )
        }
    ] }
    
    // Conditional Parameters
    @Parameter(.transient) static var isSetRadius: Bool = false
    @Parameter(.transient) static var isSliderVisible: Bool = false
    @Parameter(.transient) static var markersCount: Int = 0
    
    // Conditionals
    var rules: [Rule] { [
        #Rule(Self.$isSetRadius) { $0 },
        #Rule(Self.$isSliderVisible) { $0 },
        #Rule(Self.$markersCount) { $0 == 0 }
    ] }
}
