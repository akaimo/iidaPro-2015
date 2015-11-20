//
//  District.h
//  iidaPro-2015
//
//  Created by akaimo on 11/14/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

#import <Realm/Realm.h>

@interface District : RLMObject
@property NSInteger num;
@property NSString *area;
@property NSString *town;
@property NSString *read;
@property NSString *read_head;
@property NSString *office;
@property NSString *normal_1;
@property NSString *normal_2;
@property NSString *bottle;
@property NSString *plastic;
@property NSString *mixedPaper;
@property NSString *bigRefuse_date;
@property NSInteger bigRefuse_1;
@property NSInteger bigRefuse_2;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<District>
RLM_ARRAY_TYPE(District)
