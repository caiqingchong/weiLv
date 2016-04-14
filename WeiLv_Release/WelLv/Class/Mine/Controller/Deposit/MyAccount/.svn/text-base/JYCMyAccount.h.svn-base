//
//  JYCMyAccount.h
//  WelLv
//
//  Created by lyx on 16/1/15.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"
#import "ProgressView.h"
@interface JYCMyAccount : XCSuperObjectViewController
{
    NSString *total;//总账户
    NSString *active; //可提现金额
    NSString *inactive; //冻结金额
    NSString *top_total; //单日可提现最大金额
    NSString *top_times; //单日可提现次数
    float i_percent; //可冻结金额百分比
    float distance;//底部视图距离圆的间距
    UILabel *allowCount; //可提现金额
    UILabel *unallowCount;//冻结金额
}
@property(nonatomic,strong)UIView *navigationView;
@property(nonatomic,strong)ProgressView *progress;
@property(nonatomic,strong)UILabel *lblActiveMoney; //可提现金额
@property(nonatomic,strong)UILabel *lblActiveMessage; //可提现金额（元）
@property(nonatomic,strong)UIImage *imageActiveLines;//可提现金额折线图
@property(nonatomic,strong)UIImageView *imageViewActive; //可提现金额图片视图

@property(nonatomic,strong)UILabel *lblInActiveMoney; //可冻结金额
@property(nonatomic,strong)UILabel *lblInActiveMessage; //可冻结金额（元）
@property(nonatomic,strong)UIImage *imageInActiveLines;//可冻结金额折线图
@property(nonatomic,strong)UIImageView *imageViewInActive;//可冻结金额图片视图

@end
