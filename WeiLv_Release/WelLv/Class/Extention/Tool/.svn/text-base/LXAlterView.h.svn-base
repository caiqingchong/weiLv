//
//  LXAlterView.h
//  WelLv
//
//  Created by 刘鑫 on 15/4/18.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXAlterView : NSObject
{
    UIView *_tiShiView;
    UILabel *_tishiLabel;
    
    UIImageView *_hudView;
    UIImageView *_iconImage;
    NSTimer *_hudTimer;
}
@property(nonatomic,strong)UIView *tiShiView;
@property(nonatomic,strong)UILabel *tishiLabel;
@property(nonatomic,strong)UIImageView *hudView;
@property(nonatomic,strong)UIImageView *iconImage;
@property(nonatomic,strong)NSTimer *hudTimer;
+ (LXAlterView*)sharedMyTools;
#pragma mark -- 提示框
-(void)createTishi:(NSString *)tishiStr;
@end
