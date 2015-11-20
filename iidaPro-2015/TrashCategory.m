//
//  TrashCategory.m
//  iidaPro-2015
//
//  Created by akaimo on 11/20/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

#import "TrashCategory.h"

@implementation TrashCategory

+ (nullable NSString *)primaryKey {
    return @"num";
}

+ (NSArray *)requiredProperties {
    return @[@"title", @"read", @"read_head", @"classification"];
}

+ (NSArray *)indexedProperties {
    return @[@"title", @"read", @"read_head"];
}

@end
