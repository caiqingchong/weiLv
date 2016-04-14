//
//  HouseSearchController.h
//  WelLv
//
//  Created by mac for csh on 16/2/18.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "XCSuperObjectViewController.h"
typedef void(^pBlock)(NSString *str);
@interface HouseSearchController : UIViewController
/**
 *  1旅游 2邮轮 3签证 4管家  5游学 6门票 7自驾吃
 */
@property(nonatomic, assign)NSInteger searchType;
@property(nonatomic, copy) NSString * city_id;
@property(nonatomic, copy)pBlock block;
@end
