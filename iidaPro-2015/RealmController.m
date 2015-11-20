//
//  RealmController.m
//  iidaPro-2015
//
//  Created by akaimo on 2015/08/18.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "RealmController.h"
#import <Realm/Realm.h>
#import "TrashCategory.h"
#import "Knowledge.h"
#import "District.h"
#import "AFNetworking.h"

@implementation RealmController

- (void)createTestTable {
//    RLMRealm *realm;
//    NSLog(@"Realm: %@", [RLMRealmConfiguration defaultConfiguration].path);
    
    NSLog(@"HTTPRequest");
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://153.120.170.41:3000/api/v1/trash" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        dispatch_queue_t queue = dispatch_queue_create("realm", NULL);
        dispatch_async(queue, ^{
            @autoreleasepool {
                NSLog(@"Realm更新開始");
                int count = (int)[responseObject count];
                for (int i=0; i<count; i++) {
                    if (i % (count/10) == 0) {
                        NSLog(@"%d/%d", i, count);
                    }
                    TrashCategory *trash = [[TrashCategory alloc] init];
                    trash.num = i;
                    trash.title = [responseObject[i] valueForKey:@"title"];
                    trash.read = [responseObject[i] valueForKey:@"read"];
                    trash.read_head = [responseObject[i] valueForKey:@"read_head"];
                    trash.category = [responseObject[i] valueForKey:@"category"];
                    
                    RLMRealm *realm = [RLMRealm defaultRealm];
                    [realm beginWriteTransaction];
                    [TrashCategory createOrUpdateInRealm:realm withValue:trash];
                    [realm commitWriteTransaction];
                }
                NSLog(@"Realm更新完了");
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
