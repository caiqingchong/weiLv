//
//  BaseNavigationViewController.m
//  tabbarDemo
//
//  Created by Shouqiang Wei on 14/12/26.
//  Copyright (c) 2014年 TabBarDemo. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setTranslucent:NO];
    // Do any additional setup after loading the view.
}

//push的时候判断到子控制器的数量。当大于零时隐藏BottomBar 也就是UITabBarController 的tababar
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self.viewControllers.count>0){
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


@end
