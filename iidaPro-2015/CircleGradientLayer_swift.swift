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
        let gradColors = self.weather.gradColors()
        let colorSpace: CGColorSpaceRef? = CGColorSpaceCreateDeviceRGB()
        
        guard let colors = gradColors else { return }
        let gradient: CGGradientRef? = CGGradientCreateWithColorComponents(colorSpace, colors, gradLocations, gradLocationsNum)
        
        let gradCenter: CGPoint = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
        let gradRadius: CGFloat = min(self.bounds.size.width, self.bounds.size.height)
        
        CGContextDrawRadialGradient(ctx, gradient, gradCenter, 0, gradCenter, gradRadius, CGGradientDrawingOptions.DrawsAfterEndLocation)
    }

}
