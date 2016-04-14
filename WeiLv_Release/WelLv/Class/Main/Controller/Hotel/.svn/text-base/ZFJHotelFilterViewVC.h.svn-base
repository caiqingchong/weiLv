//
//  ZFJHotelFilterViewVC.h
//  WelLv
//
//  Created by zhangjie on 15/10/2.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZFJHotelFilterViewVC;
@protocol  ZFJHotelFilterViewVCDelegate <NSObject>
-(void)cellClickWithModel:(id)model withFirstCell:(NSInteger)firstCell secendCell:(NSInteger)secendCell andIsSelect:(BOOL)isSelect;
@end

@interface ZFJHotelFilterViewVC : XCSuperObjectViewController
@property (nonatomic,strong) NSString *citycode;//城市值
@property (nonatomic,weak) id<ZFJHotelFilterViewVCDelegate>delegate;

@end
