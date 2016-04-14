//
//  ShipCSHViewController.h
//  WelLv
//
//  Created by mac for csh on 15/10/15.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"
#import "payRequsestHandler.h"

@interface ShipCSHViewController : XCSuperObjectViewController<UIScrollViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    UIScrollView *_scrollView;//
}

@property(nonatomic,copy)NSString *order_id;
@property(nonatomic,copy)NSString *cat_id;
@property(nonatomic,copy)NSString *member_id;


@end

@interface  ShipMessage : UIView

- (id)initWithFrame:(CGRect)frame titleString:(NSString *)title timeString:(NSString *)time ariportString:(NSString *)airport;
- (id)initWithFrame:(CGRect)frame string1:(NSString *)string1 string2:(NSString *)string2 ;

@end
