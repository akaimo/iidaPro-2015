//
//  AdjustNSDate.m
//  iidaPro-2015
//
//  Created by akaimo on 11/10/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

#import "AdjustNSDate.h"

@implementation AdjustNSDate

// 引数として与えられた日にちを今日と比較し、正しい年を返す
// ex) now:2015/09/10, strDate:05/20 08:30  ->  2016
// ex) now:2015/10/10, strDate:12/12 08:30  ->  2015
- (NSString *)getExactYearWithDate:(NSString *)strDate {
    NSDate *now = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    [formatter setLocale:locale];
    [formatter setDateFormat:@"MM/dd HH:mm"];
    NSDate *date = [formatter dateFromString:strDate];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger flags;
    NSDateComponents *nowComps;
    NSDateComponents *dateComps;
    
    flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    nowComps = [calendar components:flags fromDate:now];
    dateComps = [calendar components:flags fromDate:date];
    
    if (nowComps.month <= dateComps.month) {
        return [NSString stringWithFormat:@"%ld", (long)nowComps.year];
    } else {
        return [NSString stringWithFormat:@"%ld", (long)nowComps.year + 1];
    }
}

- (NSString *)getWeekday {
    NSDate *date = [NSDate date];
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents* comps = [calendar components:NSCalendarUnitWeekday fromDate:date];
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja"];
    
    NSString* weekDayStr = df.shortWeekdaySymbols[comps.weekday-1];
    NSArray *array = @[@"日", @"月", @"火", @"水", @"木", @"金", @"土"];
    
    return array[[weekDayStr intValue]];
}

@end
