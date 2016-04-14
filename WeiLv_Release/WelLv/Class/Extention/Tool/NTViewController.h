//
//  NTViewController.h
//  tabbarDemo
//
//  Created by MD101 on 14-10-8.
//  Copyright (c) 2014年 TabBarDemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTViewController : UITabBarController<UITextFieldDelegate>
//wsq
-(void)isHiddenCustomTabBarByBoolean:(BOOL)boolean;
// 导航栏
//-(void)setNavigationBar:(UIViewController *)nav index:(int)aIndex;
-(void)seleBtnIndex:(NSInteger)index;
@end
