//
//  zxdLockFourViewController.h
//  WelLv
//
//  Created by liuxin on 16/1/29.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"
@class zxdLockFourViewController;
@protocol zxdLockFourViewControllerDelegate <NSObject>

-(void)zxdViewController5:(zxdLockFourViewController*)zxdVC text:(NSString *)string number:(NSInteger)number;

@end
@interface zxdLockFourViewController : XCSuperObjectViewController
{
}
@property(assign,nonatomic)NSInteger type;
@property(nonatomic,strong)NSString *starString;
@property(nonatomic,strong)NSString *uid;
@property(nonatomic,assign)id<zxdLockFourViewControllerDelegate>delegate;
@end
