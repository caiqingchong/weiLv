//
//  LXSingletonClass.h
//  WelLv
//
//  Created by liuxin on 15/9/2.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXSingletonClass : NSObject


/**
 *用于判断支付结果页面是否是支付的定金
 */
@property (nonatomic,assign)BOOL isYouXue;
+(instancetype) shareInstance;

@end
