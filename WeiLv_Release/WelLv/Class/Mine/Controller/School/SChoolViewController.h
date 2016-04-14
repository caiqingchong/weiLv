//
//  SChoolViewController.h
//  WelLv
//
//  Created by mac for csh on 15/9/1.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCSuperObjectViewController.h"

@interface SChoolViewController : XCSuperObjectViewController<UIScrollViewDelegate>

{
    UIScrollView * scrollVIew;
}

@property (nonatomic,strong) UIScrollView *scrollView;

@end
