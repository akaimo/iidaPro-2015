//
//  Knowledge.h
//  iidaPro-2015
//
//  Created by akaimo on 2015/08/18.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import <Realm/Realm.h>

@interface Knowledge : RLMObject
@property NSInteger num;
@property NSString *title;
@property NSString *detail;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<Knowledge>
RLM_ARRAY_TYPE(Knowledge)
