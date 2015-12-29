//
//  HomeModel.swift
//  iidaPro-2015
//
//  Created by akaimo on 12/21/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

import UIKit

protocol HomeModelDelegate {
    func setLocation(location: String)
    func setTrashImage(image: UIImage?)
    func changeWeatherThema(weather: Weather)
    func setEvent(title: String, url: String)
}

class HomeModel: NSObject {
    
    var delegate: HomeModelDelegate?
    
    var weatherThema: Weather
    var areaData: [String:AnyObject]?
    var eventTitle: String?
    var eventURL: String?
    
    override init() {
        self.weatherThema = .Sunny
        self.areaData = NSUserDefaults.standardUserDefaults().objectForKey("district") as? [String:AnyObject]
        
        super.init()
    }
    
    
    func updateAreaData() {
        self.areaData = NSUserDefaults.standardUserDefaults().objectForKey("district") as? [String:AnyObject]
        
        self.updateLocation()
        self.updateTrashImage()
    }
    
    func fetchWeatherThema() {
        // TODO: 天気APIから取得
        self.weatherThema = Weather.Sunny
        
        self.delegate?.changeWeatherThema(self.weatherThema)
    }
    
    func fetchEvent() {
        // TODO: APIから取得
        self.eventTitle = "年末年始のごみ収集日程のお知らせ"
        self.eventURL = ""
        
        if let title = self.eventTitle, url = self.eventURL {
            self.delegate?.setEvent(title, url: url)
        }
    }
    
    
    // MARK: - private
    private func updateLocation() {
        guard let areaData = self.areaData else { return }
        let location = areaData["area"] as? String ?? "NoArea"
        
        self.delegate?.setLocation(location)
    }
    
    private func updateTrashImage() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let weekDay = NSDate.nowWeekday(NSDate())
        let weekdayOriginal = NSDate.weekdayOriginal(NSDate())
        var todayCategory: String = ""
        
        guard let areaData = self.areaData else { return }
        
        for category in appDelegate.categoryArray_en {
            guard let categoryDate = areaData[category] as? String else { continue }
            
            if weekDay == categoryDate {
                todayCategory = category
                break
            }
        }
        
        var image = UIImage(named: "T_NoImage")
        switch todayCategory {
        case "normal_1", "normal_2":
            image = UIImage(named: "T_Normal")
        case "bottle":
            image = UIImage(named: "T_Can")
        case "plastic":
            image = UIImage(named: "T_Plastic")
        case "mixedPaper":
            image = UIImage(named: "T_Mixed")
        case "bigRefuse_date":
            if weekdayOriginal == areaData["bigRefuse_1"] as! Int || weekdayOriginal == areaData["bigRefuse_2"] as! Int {
                image = UIImage(named: "T_BigRefuse")
            }
        default: break
        }
        
        if todayCategory != "" && weekDay == areaData["bigRefuse_date"] as! String {
            if weekdayOriginal == areaData["bigRefuse_1"] as! Int || weekdayOriginal == areaData["bigRefuse_2"] as! Int {
                switch todayCategory {
                case "normal_1", "normal_2":
                    image = UIImage(named: "T_W_Normal")
                case "bottle":
                    image = UIImage(named: "T_W_Can")
                case "plastic":
                    image = UIImage(named: "T_W_Plastic")
                case "mixedPaper":
                    image = UIImage(named: "T_W_Mixed")
                default: break
                }
            }
        }
        
        self.delegate?.setTrashImage(image)
    }

}
