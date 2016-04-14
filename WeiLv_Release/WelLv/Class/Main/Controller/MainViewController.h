//
//  MainViewController.h
//  WelLv
//
//  Created by 刘鑫 on 15/4/1.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTViewController.h"
#import "UIImageView+WebCache.h"
#import "YXBannerView.h"
#import "NavSearchView.h"
#import "locationView.h"
#import "MJRefresh.h"
#import "AppDelegate.h"
@interface MainViewController : UIViewController<EScrollerViewDelegate,NavSearchViewDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView *_scrollView;
   
}
@property (nonatomic,strong) UIScrollView *scrollView;







@end
