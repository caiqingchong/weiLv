//
//  WeilvAnnounceDetailViewController.h
//  WelLv
//
//  Created by mac for csh on 15/11/26.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"
#import "weilvAnnounceModel.h"
#import "weilvAnnounceDetailModel.h"

@interface WeilvAnnounceDetailViewController : XCSuperObjectViewController<UIWebViewDelegate>

@property( nonatomic, strong)weilvAnnounceModel *model;
@property( nonatomic, strong)weilvAnnounceDetailModel *detailModel;

@end
