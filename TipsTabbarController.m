//
//  TipsTabbarController.m
//  iidaPro-2015
//
//  Created by 岩村圭太 on 2015/07/18.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "TipsTabbarController.h"

@implementation TipsTabbarController

- (void)showTabbar:(BOOL)isShow
{
    UITabBar *tabBar =self.tabBar;
    tabBar.hidden =!isShow;
}
@end
