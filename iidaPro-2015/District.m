//
//  District.m
//  iidaPro-2015
//
//  Created by akaimo on 11/14/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

#import "District.h"

@implementation District

+ (nullable NSString *)primaryKey {
    return @"num";
}

+ (NSArray *)requiredProperties {
    return @[@"area", @"town", @"normal_1", @"normal_2", @"bottle", @"plasstic", @"mixedPaper",
             @"bigRefuse_date", @"bigRefuse_1", @"bigRefuse_2"];
}

//+ (NSArray *)indexedProperties {
//    return @[@"read_head"];
//}

@end
