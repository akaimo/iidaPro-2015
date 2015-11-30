
//
//  TipsClassification.h
//  iidaPro-2015
//
//  Created by 岩村圭太 on 2015/11/17.
//  Copyright © 2015年 akaimo. All rights reserved.
//

#import <Realm/Realm.h>

@interface TipsObject : RLMObject
@property NSInteger id;
@property NSString *title;
@property NSString *detail;
@property NSString *genre;

@end

RLM_ARRAY_TYPE(TipsObject)




