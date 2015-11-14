//
//  Classification.h
//  iidaPro-2015
//
//  Created by akaimo on 2015/08/18.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import <Realm/Realm.h>

@interface Classification : RLMObject
@property NSInteger num;
@property NSString *title;
@property NSString *read;
@property NSString *initial;
@property NSString *classification;
@property BOOL detail;
@property NSString *category;
@property NSString *info;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<Classification>
RLM_ARRAY_TYPE(Classification)
