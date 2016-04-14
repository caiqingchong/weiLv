//
//  SearchViewController.h
//  weilvTest1
//
//  Created by 刘鑫 on 15/7/8.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "XCSuperObjectViewController.h"
@interface SearchViewController : UIViewController

/**
 *  1旅游 2邮轮 3签证 4管家  5游学 6门票
 */
@property(nonatomic, assign)NSInteger searchType;
@property(nonatomic, copy) NSString * city_id;

@end
