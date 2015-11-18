//
//  TipsClassification.m
//  iidaPro-2015
//
//  Created by 岩村圭太 on 2015/11/17.
//  Copyright © 2015年 akaimo. All rights reserved.
//

#import "TipsClassification.h"

@implementation TipsClassification

+ (nullable NSString *)primaryKey {
    return @"id";
}

+ (NSArray *)requiredProperties {
    return @[@"title", @"detail", @"genre"];
}

@end
