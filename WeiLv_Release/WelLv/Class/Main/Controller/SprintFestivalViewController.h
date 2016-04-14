//
//  SprintFestivalViewController.h
//  WelLv
//
//  Created by James on 16/1/25.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTViewController.h"
#import "UIImageView+WebCache.h"
#import "YXBannerView.h"
#import "NavSearchView.h"
#import "locationView.h"
#import "MJRefresh.h"
#import "AppDelegate.h"

@interface SprintFestivalViewController : UIViewController<EScrollerViewDelegate,NavSearchViewDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView *_scrollView;
    
}
@property (nonatomic,strong) UIScrollView *scrollView;

@end
