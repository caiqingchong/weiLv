//
//  zxdLockTwoViewController.h
//  WelLv
//
//  Created by liuxin on 16/1/29.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"
@class zxdLockTwoViewController;
@protocol zxdLockTwoViewControllerDelegate <NSObject>

-(void)zxdViewController4:(zxdLockTwoViewController *)zxdVC text:(NSString *)string Number:(NSInteger)number;


@end
@interface zxdLockTwoViewController : XCSuperObjectViewController<UITextFieldDelegate>
{
    UITextField *_zxdTextField;
    NSString *_strtext;
    NSInteger _type;
}
@property(nonatomic,strong)UITextField *zxdTextField;
@property(nonatomic,strong)NSString *strtext;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,strong)NSString *uid;
@property(nonatomic,assign)id<zxdLockTwoViewControllerDelegate>delegate;
@end
