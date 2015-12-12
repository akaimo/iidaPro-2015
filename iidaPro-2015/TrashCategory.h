//
//  TrashCategory.h
//  iidaPro-2015
//
//  Created by akaimo on 11/20/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

#import <Realm/Realm.h>

@interface TrashCategory : RLMObject
@property NSInteger num;
@property NSString *title;
@property NSString *read;
@property NSString *read_head;
@property NSString *category;
@property NSString *allCategory;
@property NSString *info;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<TrashCategory>
RLM_ARRAY_TYPE(TrashCategory)
