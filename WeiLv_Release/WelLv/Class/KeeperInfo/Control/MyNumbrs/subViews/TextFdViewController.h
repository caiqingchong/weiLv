//
//  TextFdViewController.h
//  WelLv
//
//  Created by mac for csh on 15/7/24.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCSuperObjectViewController.h"

@interface TextFdViewController : XCSuperObjectViewController<UITextFieldDelegate>{
    NSString *contentString;
    UITextField *_textField;
    NSString *key;
    NSString *uid;
}
@property(nonatomic,strong) NSString *contentString;
@property(nonatomic,strong) NSString *key;
@property(nonatomic,strong) NSString *uid;
@end
