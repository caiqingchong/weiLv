//
//  foodShowViewController.h
//  WelLv
//
//  Created by liuxin on 15/11/13.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"

@interface foodShowViewController : XCSuperObjectViewController
{
    UIScrollView *_zxdScrollview;
    NSInteger count;//标志添加的图片
    NSInteger imageNum;
    NSMutableArray *_arrText;
    NSMutableArray *_arrimage;
    NSMutableArray *_ziparrimage;
    
    
}
@property(nonatomic,strong)NSMutableArray *arrText;
@property(nonatomic,strong)UIScrollView *zxdScrollview;
@property(nonatomic,strong)NSMutableArray *arrimage;
@property(nonatomic,strong)NSMutableArray *ziparrimage;

@end
