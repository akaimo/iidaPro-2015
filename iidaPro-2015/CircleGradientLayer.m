//
//  CircleGradientLayer.m
//  iidaPro-2015
//
//  Created by akaimo on 11/27/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

#import "CircleGradientLayer.h"

@interface CircleGradientLayer ()

@property (nonatomic) weatherThema thema;

@end

@implementation CircleGradientLayer

- (id)init {
    self = [super init];
    if (self) {
        [self setNeedsDisplay];
    }
    return self;
}

- (id)initWithWeatherThema:(weatherThema)thema {
    self = [super init];
    if (self) {
        [self setNeedsDisplay];
        _thema = thema;
    }
    return self;
}

- (void)drawInContext:(CGContextRef)ctx {
    size_t gradLocationsNum = 2;
    CGFloat gradLocations[] = {0.0f, 1.0f};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorSpaceRelease(colorSpace);
    
    CGPoint gradCenter= CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    float gradRadius = MIN(self.bounds.size.width , self.bounds.size.height) ;
    
    switch (_thema) {
        case weatherThemaSunny: {
            CGFloat gradColors[] = {0/255.0, 207/255.0, 239/255.0, 1.0f,
                                    68/255.0, 169/255.0, 243/255.0, 1.0f};
            CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, gradColors, gradLocations, gradLocationsNum);
            CGContextDrawRadialGradient (ctx, gradient, gradCenter, 0, gradCenter, gradRadius, kCGGradientDrawsAfterEndLocation);
            CGGradientRelease(gradient);
            
            break;
        }
            
        case weatherThemaCloudy: {
            CGFloat gradColors[] = {136/255.0, 141/255.0, 150/255.0, 1.0f,
                                    97/255.0, 100/255.0, 106/255.0, 1.0f};
            CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, gradColors, gradLocations, gradLocationsNum);
            CGContextDrawRadialGradient (ctx, gradient, gradCenter, 0, gradCenter, gradRadius, kCGGradientDrawsAfterEndLocation);
            CGGradientRelease(gradient);
            
            break;
        }
            
        default:
            break;
    }
}

@end
