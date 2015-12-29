//
//  CalendarModel.swift
//  iidaPro-2015
//
//  Created by akaimo on 12/27/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

import UIKit

class CalendarModel: NSObject, UITableViewDataSource {
    var myAlarm: [[String:String]] = []
    var myAlarmDate: [String] = []
    var monthNumArray: [Int] = []
    var monthStrArray: [String] = []
    var separateMonthArray: [[NSDate]] = []
    var todayIndexPath = NSIndexPath()
    let now: NSDate

    override init() {
        self.now = NSDate()
        super.init()
        self.setupCalendarDate()
        self.setupAlarmDate()
    }
    
    private func setupCalendarDate() {
        let useDate = self.setupUseDate()   // カレンダーに表示する日にち
        self.monthNumArray = self.getUseMonth(useDate)  // カレンダーに登場する月
        self.monthStrArray = self.getMonthString(self.monthNumArray)    // 月の英語
        
        // 月別にデータを分ける
        for monthNum in self.monthNumArray {
            var ary: [NSDate] = []
            for date in useDate {
                if monthNum == NSDate.getMonthNum(date) { ary.append(date) }
            }
            self.separateMonthArray.append(ary)
        }
        
        self.setupTodayIndexPath(self.separateMonthArray)
    }
    
    private func setupUseDate() -> [NSDate] {
        var array: [NSDate] = []
        let showNum = 45
        let oldDate = 3
        
        for n in 0..<showNum {
            let time: NSTimeInterval = Double((-1 * oldDate + n) * 24 * 60 * 60)
            let date = NSDate.init(timeInterval: time, sinceDate: self.now)
            array.append(date)
        }
        return array
    }
    
    private func getUseMonth(useDate: [NSDate]) -> [Int] {
        var ary: [Int] = []
        
        for date in useDate {
            var insert = true
            let num = NSDate.getMonthNum(date)
            ary.filter { $0 == num }.forEach { _ in insert = false }
            if insert == true { ary.append(num) }
        }
        return ary
    }
    
    private func getMonthString(months: [Int]) -> [String] {
        var ary: [String] = []
        
        for num in months {
            let str = NSDate.getMonthStr(num)
            ary.append(str)
        }
        return ary
    }
    
    private func setupTodayIndexPath(array: [[NSDate]]) {
        array.enumerate().forEach { i, ary in
            ary.enumerate().filter { $0.1 == self.now }.forEach { j, _ in
                self.todayIndexPath = NSIndexPath(forRow: j, inSection: i)
            }
        }
    }
    
    private func setupAlarmDate() {
        self.myAlarm = NSUserDefaults.standardUserDefaults().objectForKey("myAlarm") as! [[String:String]]
        self.myAlarmDate = self.myAlarm.map { dic in
            guard let str = dic["time"] else { return "" }
            let array = str.characters.split(" ").map { String($0) }
            return array.isEmpty ? "" : array[0]
        }
    }
    
    private func trashImage(date: NSDate) -> [UIImage?] {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let areaData = NSUserDefaults.standardUserDefaults().objectForKey("district") as! [String:AnyObject]
        let weekday = NSDate.nowWeekday(date)
        var todayCategory = ""
        
        for category in app.categoryArray_en {
            if weekday == areaData[category] as! String {
                todayCategory = category
                break
            }
        }
        
        var ary: [UIImage?] = []
        ary.append(self.getCategoryImage(todayCategory))
        
        if todayCategory != "" && weekday == areaData["bigRefuse_date"] as! String {
            let original = NSDate.weekdayOriginal(date)
            if original == areaData["bigRefuse_1"] as! Int || original == areaData["bigRefuse_2"] as! Int {
                ary.append(UIImage(named: "C_BigRefuse"))
            }
        }
        
        return ary
    }
    
    private func getCategoryImage(category: String) -> UIImage? {
        var image: UIImage?
        
        switch category {
        case "normal_1", "normal_2":    image = UIImage(named: "S_Normal")
        case "bottle":                  image = UIImage(named: "C_Can")
        case "plastic":                 image = UIImage(named: "S_plastic")
        case "mixedPaper":              image = UIImage(named: "S_Mixed")
        default:                        image = UIImage()
        }
        
        return image
    }
    
    private func selectDayColor(weekday: String) -> (UIColor, UIColor) {
        var weekdayColor: UIColor
        var dayColor: UIColor
        
        switch weekday {
        case "土":
            weekdayColor = UIColor.blueColor()
            dayColor = UIColor.blueColor()
        case "日":
            weekdayColor = UIColor.redColor()
            dayColor = UIColor.redColor()
        default:
            weekdayColor = UIColor.whiteColor()
            dayColor = UIColor.whiteColor()
        }
        
        return (weekdayColor, dayColor)
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.separateMonthArray.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.monthStrArray[section]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.separateMonthArray[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Calendar", forIndexPath: indexPath) as! CalendarCell
        if self.todayIndexPath == indexPath {
            cell.backgroundColor = UIColor(red: 41/255.0, green: 52/255.0, blue: 92/255.0, alpha: 0.6)
        } else {
            cell.backgroundColor = UIColor.clearColor()
        }
        
        let today: NSDate = self.separateMonthArray[indexPath.section][indexPath.row]
        cell.weekdayLabel.text = NSDate.getShortWeekdayEn(today)
        cell.dayLabel.text = NSDate.getDayStr(today)
        
        let labelColor = self.selectDayColor(NSDate.nowWeekday(today))
        cell.weekdayLabel.textColor = labelColor.0
        cell.dayLabel.textColor = labelColor.1
        
        let ary = self.trashImage(today)
        cell.icon1ImageView.image = ary[0]
        if ary.count == 2 { cell.icon2ImageView.image = ary[1] }
        
        let monthDay = NSDate.getMonthDayStr(today)
        cell.alarmButton.hidden = true
        self.myAlarmDate.enumerate().filter { $0.1 == monthDay && self.myAlarm[$0.0]["switch"] == "on" }.forEach { _,_ in cell.alarmButton.hidden = false }
        
        return cell
    }
}
