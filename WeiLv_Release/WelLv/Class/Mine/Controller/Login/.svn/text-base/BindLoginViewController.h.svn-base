//
//  BindLoginViewController.h
//  WelLv
//
//  Created by lyx on 15/4/17.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "XCObjectViewController.h"
#import "LoginAndRegisterViewController.h"

typedef void (^bindBlock)(NSString *str);
@interface BindLoginViewController : XCObjectViewController<UITextFieldDelegate>
{
    UITextField *_phoneTextField;
    UIView *_bindView;
    UIView *_verificView;
    UILabel *_phoneLabel;
    UIButton *verificatBtn;
    UITextField *_inputTextField;
}
@property (nonatomic,strong)UIImageView *phoneImageView;
@property (nonatomic,strong)UILabel *userName;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *phoneStr;
@property (nonatomic,copy)NSString *openId;
@property (nonatomic,copy)NSString *loginType;     //登陆类型     WX---微信     QQ----qq
@property (nonatomic, strong)bindBlock block;
@end


@interface YXPasscodeField : UIView
@property (nonatomic, strong, readonly) UIView* emptyIndicator;
@property (nonatomic, strong, readonly) UILabel* textLable;
@property (nonatomic, strong) NSString* text;
@end