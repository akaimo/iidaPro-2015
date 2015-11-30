//
//  tipsObject.m
//  iidaPro-2015
//
//  Created by 岩村圭太 on 2015/11/29.
//  Copyright © 2015年 akaimo. All rights reserved.
//
#import "TipsObject.h"

@implementation TipsObject

+ (nullable NSString *)primaryKey {
    return @"id";
}

+ (NSArray *)requiredProperties {
    return @[@"title", @"detail", @"genre"];
}

@end