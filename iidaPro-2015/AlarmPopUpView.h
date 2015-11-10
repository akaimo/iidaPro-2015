//
//  AlarmPopUpView.h
//  iidaPro-2015
//
//  Created by akaimo on 2015/11/05.
//  Copyright © 2015年 akaimo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AlarmPopUpView;

@protocol AlarmPopUpViewDelegate <NSObject>

@required
- (void)alarmPopUpView:(AlarmPopUpView *)alarmPopUpView didTappedEnterButton:(UIButton *)button;

@optional
- (void)alarmPopUpView:(AlarmPopUpView *)alarmPopUpView didTappedCancelButton:(UIButton *)button;

@end

typedef NS_ENUM(NSInteger, PopupStyle){
    PopupDefaultStyle = 0, // default
    PopupNewMyAlarmStyle,
    PopupEditMyAlarmStyle
};

@interface AlarmPopUpView : UIView

@property (nonatomic, weak) id<AlarmPopUpViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame style:(PopupStyle)style row:(NSInteger)row;

@end
