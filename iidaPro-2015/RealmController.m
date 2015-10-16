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
#import "AFNetworking.h"

@implementation RealmController

- (void)createTestTable {
    RLMRealm *realm;
//    NSLog(@"Realm: %@", [RLMRealmConfiguration defaultConfiguration].path);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://153.120.170.41:3000/api/v1/trash" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
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
        } else if (i == 2) {
            classifi.title = @"缶";
            classifi.read = @"かん";
            classifi.classification = @"空き缶";
            classifi.knowledge = nil;
        } else if (i == 3) {
            classifi.title = @"ああ";
            classifi.read = @"ああ";
            classifi.classification = @"燃えるごみ";
            classifi.knowledge = nil;
        } else if (i == 4) {
            classifi.title = @"あい";
            classifi.read = @"あい";
            classifi.classification = @"燃えるごみ";
            classifi.knowledge = nil;
        } else if (i == 5) {
            classifi.title = @"うい";
            classifi.read = @"うい";
            classifi.classification = @"燃えるごみ";
            classifi.knowledge = nil;
        } else if (i == 6) {
            classifi.title = @"いい";
            classifi.read = @"いい";
            classifi.classification = @"燃えるごみ";
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
