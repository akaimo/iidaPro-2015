//
//  CircleGradientLayer.swift
//  iidaPro-2015
//
//  Created by akaimo on 12/16/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

import UIKit

class CircleGradientLayer_swift: CALayer {
    
    var weather: Weather
    
    init(weather: Weather) {
        self.weather = weather
        super.init()
        self.setNeedsDisplay()
    }
    
    convenience override init() {
        self.init(weather: Weather.Sunny)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawInContext(ctx: CGContext) {
        let gradLocationsNum: size_t = 2
        let gradLocations: [CGFloat] = [0.0, 1.0]
        let colorSpace: CGColorSpaceRef? = CGColorSpaceCreateDeviceRGB()
        let gradCenter: CGPoint = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
        let gradRadius: CGFloat = min(self.bounds.size.width, self.bounds.size.height)
        
        switch weather {
        case .Sunny:
            let gradColors: [CGFloat] = [
                0/255.0, 207/255.0, 239/255.0, 1.0,
                68/255.0, 169/255.0, 243/255.0, 1.0
            ]
            let gradient: CGGradientRef? = CGGradientCreateWithColorComponents(colorSpace, gradColors, gradLocations, gradLocationsNum)
            CGContextDrawRadialGradient(ctx, gradient, gradCenter, 0, gradCenter, gradRadius, CGGradientDrawingOptions.DrawsAfterEndLocation)
            
        case .Cloudy:
            print("cloudy")
        case .Rainy: break
        case .Snowy:
            print("snowy")
        }
    }

}
