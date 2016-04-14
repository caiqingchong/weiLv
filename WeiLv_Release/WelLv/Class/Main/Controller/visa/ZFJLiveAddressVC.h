//
//  ZFJLiveAddressVC.h
//  WelLv
//
//  Created by 张发杰 on 15/7/14.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCSuperObjectViewController.h"

typedef void(^LiveAddressBlock)(NSString * liveAddressStr);

@interface ZFJLiveAddressVC : XCSuperObjectViewController

- (id)initWithLiveAddress:(LiveAddressBlock)liveAddress;


@end
