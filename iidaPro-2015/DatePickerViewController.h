//
//  DatePickerViewController.h
//  iidaPro-2015
//
//  Created by Rath on 07/08.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DPVDelegate <NSObject>

-(void)sendDate:(NSDate*)date;

@end

@interface DatePickerViewController : UIViewController
@property(nonatomic, assign)id<DPVDelegate>delegate;
-(void)send;
@end
