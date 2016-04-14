//
//  ZFJDatePickerView.h
//  WelLv
//
//  Created by WeiLv on 15/11/4.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZFJDatePickerDateStr)(NSString * dateStr);
typedef void(^ZFJChooseCanceBut)(UIButton * but);

typedef NS_ENUM(NSInteger, ZFJDatePickerViewStyle) {
    ZFJDatePickerViewStyleYM,
    ZFJDatePickerViewStyleYMDhm
};

@interface ZFJDatePickerView : UIView
@property (nonatomic, copy) ZFJDatePickerDateStr dateStr;
@property (nonatomic, strong) UIPickerView * pickView;
@property (nonatomic, copy) ZFJChooseCanceBut canceBut;
@property (nonatomic, strong) UIDatePicker * datePicker;

- (instancetype)initWithFrame:(CGRect)frame style:(ZFJDatePickerViewStyle)style;

- (void)chooseConfirmBut:(ZFJDatePickerDateStr)dateStr;
- (void)chooseCancelBut:(ZFJChooseCanceBut)canceBut;
@end
