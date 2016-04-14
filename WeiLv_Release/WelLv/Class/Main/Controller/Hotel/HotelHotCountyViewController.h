//
//  HotelHotCountyViewController.h
//  WelLv
//
//  Created by mac for csh on 15/9/29.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCSuperObjectViewController.h"
#import "NavSearchView.h"

@protocol ChangeCountyDelegate <NSObject>
-(void)changeCountyTxt:(NSString *)astr;
@end

@interface HotelHotCountyViewController : XCSuperObjectViewController<UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate, NavSearchViewDelegate>
{
    NSString *hotelString;
}
@property(nonatomic ,assign) id<ChangeCountyDelegate> delegate;

@property (nonatomic , strong)NSString *hotelString;
@end

