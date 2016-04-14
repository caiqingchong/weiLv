//
//  zxdRemarksViewController.h
//  WelLv
//
//  Created by liuxin on 16/1/19.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"
@class zxdRemarksViewController;
@protocol zxdRemarksViewControllerDelegate <NSObject>

-(void)zxdCountViewController:(zxdRemarksViewController *)vc number:(NSInteger)countNumber;

@end
@interface zxdRemarksViewController : XCSuperObjectViewController
{}
@property(nonatomic,strong)NSMutableArray *arrImage;
@property(nonatomic,strong)NSMutableArray *arrDate;
@property(nonatomic,strong)NSString *assId;
@property(nonatomic,strong)NSString *uid;
@property(nonatomic,assign) id <zxdRemarksViewControllerDelegate> delegate;

@end
