//
//  RealmController.m
//  iidaPro-2015
//
//  Created by akaimo on 2015/08/18.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "RealmController.h"
#import <Realm/Realm.h>
#import "Classification.h"
#import "Knowledge.h"

@implementation RealmController

- (void)createTestTable {
    RLMRealm *realm;
    NSLog(@"%@", [RLMRealm defaultRealmPath]);
    
    for (int i=0; i<20; i++) {
        // 豆知識
        Knowledge *knowledge = [[Knowledge alloc] init];
        knowledge.num = i;
        knowledge.title = @"huga";
        knowledge.detail = @"hugahuga";
        
        // 分別辞典
        Classification *classifi = [[Classification alloc] init];
        classifi.num = i;
        if (i == 0) {
            classifi.title = @"トレー";
            classifi.read = @"とれー";
            classifi.classification = @"プラスチック製容器包装";
            classifi.knowledge = knowledge;
        } else if (i == 1) {
            classifi.title = @"ビン";
            classifi.read = @"びん";
            classifi.classification = @"空きびん";
            classifi.knowledge = nil;
        } else {
            classifi.title = @"hoge";
            classifi.read = @"ほげ";
            classifi.classification = @"hogehoge";
            classifi.knowledge = nil;
        }
        
        realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [Knowledge createOrUpdateInRealm:realm withValue:knowledge];
        [Classification createOrUpdateInRealm:realm withValue:classifi];
        [realm commitWriteTransaction];
    }
}

- (void)deleteTestTable {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];
}

@end
