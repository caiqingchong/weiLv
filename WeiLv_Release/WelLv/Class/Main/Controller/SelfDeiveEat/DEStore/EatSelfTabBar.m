//
//  EatSelfTabBar.m
//  WelLv
//
//  Created by liuxin on 15/11/6.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//
#import "NTButton.h"
#import "BaseNavigationViewController.h"

#import "DPViewController.h"
#import "SHViewController.h"
#import "MYselfViewController.h"
#import "DDViewController.h"
#import "EatSelfTabBar.h"

@interface EatSelfTabBar ()
{
    UIImageView *_zxdTabBarView;
    NTButton *_zxdButton;
}

@end

@implementation EatSelfTabBar


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //wsq
}


- (void)viewDidLoad {
    [super viewDidLoad];
    for (UIView *obj in self.tabBar.subviews) {
        if (obj != _zxdTabBarView) {
            [obj removeFromSuperview];
        }
    }
    _zxdTabBarView = [[UIImageView alloc] initWithFrame:self.tabBar.bounds];
    _zxdTabBarView.userInteractionEnabled = YES;
    _zxdTabBarView.backgroundColor = [UIColor whiteColor];
    [self.tabBar bringSubviewToFront:_zxdTabBarView];
    [self.tabBar addSubview:_zxdTabBarView];
    DPViewController *frist = [[DPViewController alloc] init];
    UINavigationController *nav1 = [[BaseNavigationViewController alloc] initWithRootViewController:frist];
    DDViewController *second = [[DDViewController alloc] init];
    UINavigationController *nav2 = [[BaseNavigationViewController alloc] initWithRootViewController:second];
    SHViewController *thrid = [[SHViewController alloc] init];
    UINavigationController *nav3 = [[BaseNavigationViewController alloc] initWithRootViewController:thrid];
    MYselfViewController *fourth = [[MYselfViewController alloc] init];
    UINavigationController *nav4 = [[BaseNavigationViewController alloc] initWithRootViewController:fourth];
    self.viewControllers = [NSArray arrayWithObjects:nav1,nav2,nav3,nav4, nil];
    [self creatButtonWithNormalName:@"店铺" andSelectName:@"店铺副本" andTitle:@"店铺" andIndex:100];
    [self creatButtonWithNormalName:@"订单" andSelectName:@"订单副本" andTitle:@"订单" andIndex:101];
    [self creatButtonWithNormalName:@"上货" andSelectName:@"上货副本" andTitle:@"上货" andIndex:102];
    [self creatButtonWithNormalName:@"data1" andSelectName:@"data2" andTitle:@"我得" andIndex:103];
    // Do any additional setup after loading the view.
}

-(void)creatButtonWithNormalName:(NSString *)normal andSelectName:(NSString *)selected andTitle:(NSString *)title andIndex:(int)index
{
    NTButton *customButton = [NTButton buttonWithType:UIButtonTypeCustom];
    customButton.tag = index;
    CGFloat buttonw = _zxdTabBarView.frame.size.width/self.viewControllers.count;
    CGFloat buttonh = _zxdTabBarView.frame.size.height;
    customButton.frame = CGRectMake(buttonw * (index - 100), 0, buttonw, buttonh);
    [customButton setTitle:title forState:UIControlStateNormal];
    [customButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [customButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [customButton setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [customButton setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    [customButton addTarget:selected action:@selector(changeViewController:) forControlEvents:UIControlEventTouchUpInside];
    customButton.imageView.contentMode = UIViewContentModeCenter;
    customButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    customButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.tabBar addSubview:customButton];
    if (index == 100) {
        _zxdButton = customButton;
        _zxdButton.selected = YES;
    }
}


- (void)zxdisHiddenCustomTabBarByBoolean:(BOOL)boolean
{
    _zxdTabBarView.hidden =boolean;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 按钮点击是被调用
-(void)changeViewController:(NTButton *)sender
{
    
    if (self.selectedIndex != sender.tag - 100) {
        self.selectedIndex = sender.tag - 100;
        _zxdButton.selected = !_zxdButton.selected;
        _zxdButton = sender;
        _zxdButton.selected = YES;
    }
}


@end
