//
//  Classification.m
//  iidaPro-2015
//
//  Created by akaimo on 2015/08/18.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "Classification.h"

@implementation Classification

// Specify default values for properties

+ (nullable NSString *)primaryKey {
    return @"num";
}

+ (NSArray *)requiredProperties {
    return @[@"title", @"read", @"classification"];
}

@end
