//
//  RealmController.m
//  iidaPro-2015
//
//  Created by akaimo on 2015/08/18.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "tipsRealmController.h"
#import <Realm/Realm.h>
#import "TipsObject.h"
#import "AFNetworking.h"

@implementation tipsRealmController

- (void)createTestTable {
    //    RLMRealm *realm;
    //    NSLog(@"Realm: %@", [RLMRealmConfiguration defaultConfiguration].path);
    
    NSLog(@"HTTPRequest");
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://153.120.170.41:3000/api/v1/tip" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        dispatch_queue_t queue = dispatch_queue_create("realm", NULL);
        dispatch_async(queue, ^{
            @autoreleasepool {
                NSLog(@"TipsRealm更新開始");
                int count = (int)[responseObject count];
                for (int i=0; i<count; i++) {
                    if (i % (count/10) == 0) {
                        NSLog(@"%d/%d", i, count);
                    }
                    TipsObject *tipsObj = [[TipsObject alloc] init];
                    tipsObj.id = i;
                    tipsObj.title = [responseObject[i] valueForKey:@"title"];
                    tipsObj.detail = [responseObject[i] valueForKey:@"detail"];
                    tipsObj.genre = [responseObject[i] valueForKey:@"genre"];
                    
                    RLMRealm *realm = [RLMRealm defaultRealm];
                    [realm beginWriteTransaction];
                    [TipsObject createOrUpdateInRealm:realm withValue:tipsObj];
                    [realm commitWriteTransaction];
                }
                NSLog(@"TipsRealm更新完了");
            }
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)deleteTestTable {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];
}

@end
