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
#import "District.h"
#import "AFNetworking.h"
#import "TipsObject.h"

@implementation RealmController

- (void)createTestTable {
    NSLog(@"HTTPRequest");
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://153.120.170.41:3000/api/v1/trash" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        dispatch_queue_t queue = dispatch_queue_create("realm", NULL);
        dispatch_async(queue, ^{
            @autoreleasepool {
                NSLog(@"Trash更新開始");
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
                    trash.allCategory = [responseObject[i] valueForKey:@"all_category"];
                    trash.info = [responseObject[i] valueForKey:@"info"];
                    
                    RLMRealm *realm = [RLMRealm defaultRealm];
                    [realm beginWriteTransaction];
                    [TrashCategory createOrUpdateInRealm:realm withValue:trash];
                    [realm commitWriteTransaction];
                }
                NSLog(@"Trash更新完了");
            }
        });
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [manager GET:@"http://153.120.170.41:3000/api/v1/district" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        dispatch_queue_t queue = dispatch_queue_create("realm", NULL);
        dispatch_async(queue, ^{
            @autoreleasepool {
                NSLog(@"District更新開始");
                int count = (int)[responseObject count];
                for (int i=0; i<count; i++) {
                    if (i % (count/10) == 0) {
                        NSLog(@"%d/%d", i, count);
                    }
                    District *district = [[District alloc] init];
                    district.num = i;
                    district.area = [responseObject[i] valueForKey:@"area"];
                    district.town = [responseObject[i] valueForKey:@"town"];
                    district.read = [responseObject[i] valueForKey:@"read"];
                    district.read_head = [responseObject[i] valueForKey:@"read_head"];
                    district.office = [responseObject[i] valueForKey:@"office"];
                    district.normal_1 = [responseObject[i] valueForKey:@"normal_1"];
                    district.normal_2 = [responseObject[i] valueForKey:@"normal_2"];
                    district.bottle = [responseObject[i] valueForKey:@"bottle"];
                    district.plastic = [responseObject[i] valueForKey:@"plastic"];
                    district.mixedPaper = [responseObject[i] valueForKey:@"mixedPaper"];
                    district.bigRefuse_date = [responseObject[i] valueForKey:@"bigRefuse_date"];
                    district.bigRefuse_1 = [[responseObject[i] valueForKey:@"bigRefuse_1"] intValue];
                    district.bigRefuse_2 = [[responseObject[i] valueForKey:@"bigRefuse_2"] intValue];
                    
                    RLMRealm *realm = [RLMRealm defaultRealm];
                    [realm beginWriteTransaction];
                    [District createOrUpdateInRealm:realm withValue:district];
                    [realm commitWriteTransaction];
                }
                NSLog(@"District更新完了");
            }
        });
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [manager GET:@"http://153.120.170.41:3000/api/v1/tip" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
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
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


- (void)deleteTestTable {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];
}

- (void)districtTableMain {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://153.120.170.41:3000/api/v1/district"]];
    NSData *json = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSArray *responseObject = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"District更新開始");
    int count = (int)[responseObject count];
    for (int i=0; i<count; i++) {
        if (i % (count/10) == 0) {
            NSLog(@"%d/%d", i, count);
        }
        District *district = [[District alloc] init];
        district.num = i;
        district.area = [responseObject[i] valueForKey:@"area"];
        district.town = [responseObject[i] valueForKey:@"town"];
        district.read = [responseObject[i] valueForKey:@"read"];
        district.read_head = [responseObject[i] valueForKey:@"read_head"];
        district.office = [responseObject[i] valueForKey:@"office"];
        district.normal_1 = [responseObject[i] valueForKey:@"normal_1"];
        district.normal_2 = [responseObject[i] valueForKey:@"normal_2"];
        district.bottle = [responseObject[i] valueForKey:@"bottle"];
        district.plastic = [responseObject[i] valueForKey:@"plastic"];
        district.mixedPaper = [responseObject[i] valueForKey:@"mixedPaper"];
        district.bigRefuse_date = [responseObject[i] valueForKey:@"bigRefuse_date"];
        district.bigRefuse_1 = [[responseObject[i] valueForKey:@"bigRefuse_1"] intValue];
        district.bigRefuse_2 = [[responseObject[i] valueForKey:@"bigRefuse_2"] intValue];
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [District createOrUpdateInRealm:realm withValue:district];
        [realm commitWriteTransaction];
    }
    NSLog(@"District更新完了");
}

- (void)otherTableBackground {
    // trash
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://153.120.170.41:3000/api/v1/trash" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        dispatch_queue_t queue = dispatch_queue_create("realm", NULL);
        dispatch_async(queue, ^{
            @autoreleasepool {
                NSLog(@"Trash更新開始");
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
                    trash.allCategory = [responseObject[i] valueForKey:@"all_category"];
                    trash.info = [responseObject[i] valueForKey:@"info"];
                    
                    RLMRealm *realm = [RLMRealm defaultRealm];
                    [realm beginWriteTransaction];
                    [TrashCategory createOrUpdateInRealm:realm withValue:trash];
                    [realm commitWriteTransaction];
                }
                NSLog(@"Trash更新完了");
            }
        });
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    // tips
    [manager GET:@"http://153.120.170.41:3000/api/v1/tip" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        dispatch_queue_t queue = dispatch_queue_create("realm", NULL);
        dispatch_async(queue, ^{
            @autoreleasepool {
                NSLog(@"Tips更新開始");
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
                NSLog(@"Tips更新完了");
            }
        });
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
