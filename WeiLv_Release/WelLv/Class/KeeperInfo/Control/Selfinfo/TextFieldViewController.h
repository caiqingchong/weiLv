//
//  TextFieldViewController.h
//  WelLv
//
//  Created by mac for csh on 15/7/15.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCSuperObjectViewController.h"

@interface TextFieldViewController : XCSuperObjectViewController<UITextFieldDelegate>{
    NSString *textt;
}
@property (nonatomic,strong)NSString *textt;
@end
