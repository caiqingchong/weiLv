//
//  ZFJCallVC.h
//  WelLv
//
//  Created by 张发杰 on 15/7/16.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^MoreSteward)(UIButton *but);

@interface ZFJCallVC : UIViewController
@property (nonatomic, copy) NSString * admin_id;
@property (nonatomic, assign) BOOL isTicket;
@property (nonatomic, assign) BOOL isHousekeeper;
@property (nonatomic, assign) WLMemberType memberType;
@property (nonatomic, assign) WLProductType prodductType;


- (void)chooseMoreSteward:(MoreSteward)moreSteward;

@end
