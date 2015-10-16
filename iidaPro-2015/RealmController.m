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
//    RLMRealm *realm;
//    NSLog(@"Realm: %@", [RLMRealmConfiguration defaultConfiguration].path);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://153.120.170.41:3000/api/v1/trash" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
        NSLog(@"Realm更新開始");
        for (int i=0; i<[responseObject count]; i++) {
            Classification *classifi = [[Classification alloc] init];
            classifi.num = i;
            classifi.title = [responseObject[i] valueForKey:@"title"];
            classifi.read = [responseObject[i] valueForKey:@"read"];
            classifi.classification = @"燃えるごみ";
            classifi.knowledge = nil;
            
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm beginWriteTransaction];
            [Classification createOrUpdateInRealm:realm withValue:classifi];
            [realm commitWriteTransaction];
        }
        NSLog(@"Realm更新完了");
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
