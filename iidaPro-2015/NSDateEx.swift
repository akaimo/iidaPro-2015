//
//  NSDateEx.swift
//  iidaPro-2015
//
//  Created by akaimo on 12/17/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

import Foundation

extension NSDate {
    // 曜日を日本語で取得
    class func nowWeekday(date: NSDate) -> String {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let comps = calendar.components(.Weekday, fromDate: date)
        
        let df = NSDateFormatter()
        df.locale = NSLocale(localeIdentifier: "ja_JP")
        
        return df.shortWeekdaySymbols[comps.weekday-1]
    }
    
    // 月単位の週数を取得
    class func weekdayOriginal(date: NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        let comps = calendar.components(.WeekdayOrdinal, fromDate: date)
        return comps.weekdayOrdinal
    }
    
    // NSDateから月をIntで取得
    class func getMonthNum(date: NSDate) -> Int {
        let cal = NSCalendar.currentCalendar()
        let comps = cal.components(.Month, fromDate: date)
        return comps.month
    }
    
    // Intから月の名前を英語で取得
    class func getMonthStr(num: Int) -> String {
        let df = NSDateFormatter()
        df.locale = NSLocale(localeIdentifier: "en")
        
        return df.monthSymbols[num-1]
    }
}