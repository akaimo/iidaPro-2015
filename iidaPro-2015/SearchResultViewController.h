//
//  SearchResultViewController.h
//  iidaPro-2015
//
//  Created by akaimo on 2015/08/11.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Classification.h"

@interface SearchResultViewController : UIViewController

@property (strong, nonatomic) RLMResults *resultArray;
@property (strong, nonatomic) NSString *searchText;

@end
