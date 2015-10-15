//
//  Knowledge.m
//  iidaPro-2015
//
//  Created by akaimo on 2015/08/18.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "Knowledge.h"

@implementation Knowledge

// Specify default values for properties

+ (nullable NSString *)primaryKey {
    return @"num";
}

+ (NSArray *)requiredProperties {
    return @[@"title", @"detail"];
}

@end
