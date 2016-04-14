//
//  LiveAddressVC.h
//  WelLv
//
//  Created by 张发杰 on 15/4/9.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavSearchView.h"
#import "XCSuperObjectViewController.h"

typedef void(^backViewBlock)(NSString * liveAddressStr);

@interface LiveAddressVC : XCSuperObjectViewController<UITableViewDataSource, UITableViewDelegate, NavSearchViewDelegate>
@property (nonatomic, strong) NSIndexPath * chooesIndexPath;

- (id)initWithLiveAddress:(backViewBlock)liveAddressStr;

@end
