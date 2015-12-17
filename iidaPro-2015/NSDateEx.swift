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
    func nowWeekday(date: NSDate) -> String {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let comps = calendar.components(.Weekday, fromDate: date)
        
        let df = NSDateFormatter()
        df.locale = NSLocale(localeIdentifier: "ja_JP")
        
        return df.shortWeekdaySymbols[comps.weekday-1]
    }
    
    // 月単位の週数を取得
    func weekdayOriginal(date: NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        let comps = calendar.components(.WeekdayOrdinal, fromDate: date)
        return comps.weekdayOrdinal
    }
}