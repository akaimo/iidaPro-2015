//
//  Classification.h
//  iidaPro-2015
//
//  Created by akaimo on 2015/08/18.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import <Realm/Realm.h>
#import "Knowledge.h"

@interface Classification : RLMObject
@property NSInteger num;
@property NSString *title;
@property NSString *read;
@property NSString *classification;
@property Knowledge *knowledge;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<Classification>
RLM_ARRAY_TYPE(Classification)
