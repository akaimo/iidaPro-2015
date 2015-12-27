//
//  CalendarModel.swift
//  iidaPro-2015
//
//  Created by akaimo on 12/27/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

import UIKit

class CalendarModel: NSObject, UITableViewDataSource {
    var monthNumArray: [Int] = []
    var monthStrArray: [String] = []
    var separateMonthArray: [[NSDate]] = []
    var todayIndexPath = NSIndexPath()
    let now: NSDate

    override init() {
        self.now = NSDate()
        super.init()
        self.setupCalendarDate()
    }
    
    private func setupCalendarDate() {
        let useDate = self.setupUseDate()   // カレンダーに表示する日にち
        self.monthNumArray = self.getUseMonth(useDate)  // カレンダーに登場する月
        self.monthStrArray = self.getMonthString(self.monthNumArray)    // 月の英語
        
        // 月別にデータを分ける
        for monthNum in self.monthNumArray {
            var ary: [NSDate] = []
            for date in useDate {
                if monthNum == NSDate.getMonthNum(date) {
                    ary.append(date)
                }
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
                self.todayIndexPath = NSIndexPath(forRow: i, inSection: j)
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 45
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Calendar", forIndexPath: indexPath) as! CalendarCell
        cell.backgroundColor = UIColor.clearColor()
        
        cell.weekdayLabel.text = "hoge"
        
        return cell
    }
}
