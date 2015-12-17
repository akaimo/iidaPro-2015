//
//  Weather.swift
//  iidaPro-2015
//
//  Created by akaimo on 12/17/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

import Foundation

enum Weather {
    case Sunny, Rainy, Cloudy, Snowy
    
    func menuColor() -> UIColor {
        switch self {
        case .Sunny:
            return UIColor(red: 59/255.0, green: 110/255.0, blue: 212/255.0, alpha: 1.0)
        case .Cloudy:
            return UIColor(red: 97/255.0, green: 100/255.0, blue: 106/255.0, alpha: 1.0)
        case .Rainy:
            return UIColor(red: 74/255.0, green: 144/255.0, blue: 226/255.0, alpha: 1.0)
        case .Snowy:
            return UIColor.blackColor()
        }
    }
    
    func weatherImage() -> UIImage? {
        switch self {
        case .Sunny: return UIImage(named: "Sunny")
        case .Cloudy: return UIImage(named: "Cloudy")
        case .Rainy: return UIImage(named: "Rainy")
        case .Snowy: return UIImage(named: "Snowy")
        }
    }
    
    func gradColors() -> [CGFloat]? {
        switch self {
        case .Sunny:
            let colors: [CGFloat] = [
                0/255.0, 207/255.0, 239/255.0, 1.0,
                68/255.0, 169/255.0, 243/255.0, 1.0
            ]
            return colors
        case .Cloudy:
            let colors: [CGFloat] = [
                136/255.0, 141/255.0, 150/255.0, 1.0,
                97/255.0, 100/255.0, 106/255.0, 1.0
            ]
            return colors
        case .Rainy: return nil
        case .Snowy:
            let colors: [CGFloat] = [
                37/255.0, 60/255.0, 99/255.0, 1.0,
                3/255.0, 10/255.0, 21/255.0, 1.0
            ]
            return colors
        }
    }
}