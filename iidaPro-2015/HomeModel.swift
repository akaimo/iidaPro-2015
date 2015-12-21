//
//  HomeModel.swift
//  iidaPro-2015
//
//  Created by akaimo on 12/21/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

import UIKit

class HomeModel: NSObject {
    
    var weatherThema: Weather
    var areaData: [String:AnyObject]?
    
    override init() {
        self.weatherThema = .Sunny
        self.areaData = NSUserDefaults.standardUserDefaults().objectForKey("district") as? [String:AnyObject]
        
        super.init()
    }
    
    
    func updateAreaData() {
        self.areaData = NSUserDefaults.standardUserDefaults().objectForKey("district") as? [String:AnyObject]
    }
    
    func fetchWeatherThema() {
        // TODO: 天気APIから取得
        self.weatherThema = Weather.Sunny
    }

}
