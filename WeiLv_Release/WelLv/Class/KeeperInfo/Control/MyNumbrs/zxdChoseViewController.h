//
//  zxdChoseViewController.h
//  WelLv
//
//  Created by liuxin on 16/1/15.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"
@class zxdChoseViewController;
@protocol zxdChoseViewControllerDelegate <NSObject>

-(void)zxdViewController:(zxdChoseViewController*)zxdVC text:(NSString *)string number:(NSInteger)number;

@end
@interface zxdChoseViewController : XCSuperObjectViewController
{}
@property(assign,nonatomic)NSInteger type;
@property(nonatomic,strong)NSString *uid;
@property(assign,nonatomic)NSInteger didSelect;
@property(nonatomic,assign)id <zxdChoseViewControllerDelegate>delegate;
@end
