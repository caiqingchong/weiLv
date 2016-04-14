//
//  NTViewController.m
//  tabbarDemo
//
//  Created by MD101 on 14-10-8.
//  Copyright (c) 2014年 TabBarDemo. All rights reserved.
//

#import "NTViewController.h"
#import "NTButton.h"
#import "BaseNavigationViewController.h"

#import "MainViewController.h"
#import "SprintFestivalViewController.h"
#import "GuanJiaViewController.h"
#import "MineViewController.h"
#import "SheQuViewController.h"
#import "MyOrderTableViewCOntroller.h"

#import "NewGuanjiaViewController.h"

#import "SearchHotelViewController.h"
#import "JYCPlaneTicketViewController.h"

#import "HouseKeeperViewController.h"
#import "YXHouseDetailViewController.h"
#import "ShouyeHouseViewController.h"

@interface NTViewController ()
{

    UIImageView *_tabBarView;//自定义的覆盖原先的tarbar的控件
    
    NTButton * _previousBtn;//记录前一次选中的按钮
    UILabel *_city;
    UITextField *_searchBar;
    UIButton *cancalBtn;
}

@end

@implementation NTViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    for (UIView* obj in self.tabBar.subviews)
    {
        if (obj != _tabBarView)
        {
            [obj removeFromSuperview];
        }
    }
    _tabBarView = [[UIImageView alloc]initWithFrame:self.tabBar.bounds];
    _tabBarView.userInteractionEnabled = YES;
    _tabBarView.backgroundColor = [UIColor whiteColor];

    [self.tabBar bringSubviewToFront:_tabBarView];
    [self.tabBar addSubview:_tabBarView];
    
    //【首页】实例化
    MainViewController * first = [[MainViewController alloc]init];
    BaseNavigationViewController * navi1 = [[BaseNavigationViewController alloc]initWithRootViewController:first];
    //【管家】首页实例化
    //NewGuanjiaViewController *second = [[NewGuanjiaViewController alloc]init];
    ShouyeHouseViewController *second = [[ShouyeHouseViewController alloc] init];
    BaseNavigationViewController *navi2 = [[BaseNavigationViewController alloc] initWithRootViewController:second];
    
    //【订单】首页实例化
    MyOrderTableViewCOntroller * third = [[MyOrderTableViewCOntroller alloc]init];
    BaseNavigationViewController * navi3 = [[BaseNavigationViewController alloc]initWithRootViewController:third];

    //【我的】首页实例化
    MineViewController * four = [[MineViewController alloc]init];
    BaseNavigationViewController * navi4 = [[BaseNavigationViewController alloc]initWithRootViewController:four];
    
    
    //创建四个导航模块
    self.viewControllers = [NSArray arrayWithObjects:navi1,navi2,navi3,navi4,nil];
    
    [self creatButtonWithNormalName:@"首页_首页" andSelectName:@"首页_首页选中" andTitle:@"首页" andIndex:0];
    [self creatButtonWithNormalName:@"首页_管家" andSelectName:@"首页_管家选中" andTitle:@"管家" andIndex:1];
    [self creatButtonWithNormalName:@"首页_订单" andSelectName:@"首页_订单选中" andTitle:@"订单" andIndex:2];
    [self creatButtonWithNormalName:@"首页_个人" andSelectName:@"首页_个人选中" andTitle:@"我的" andIndex:3];

}

#pragma mark 创建一个按钮

- (void)creatButtonWithNormalName:(NSString *)normal andSelectName:(NSString *)selected andTitle:(NSString *)title andIndex:(int)index
{
    
    NTButton * customButton = [NTButton buttonWithType:UIButtonTypeCustom];
    customButton.tag = index;
    
    CGFloat buttonW = _tabBarView.frame.size.width / self.viewControllers.count;
    CGFloat buttonH = _tabBarView.frame.size.height;
    
    customButton.frame = CGRectMake(buttonW * index,0, buttonW, buttonH);
    [customButton setTitle:title forState:UIControlStateNormal];
    [customButton setTitleColor:[YXTools stringToColor:@"#6f7378"] forState:UIControlStateNormal];
    [customButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [customButton setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [customButton setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    
   
    
    [customButton addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchDown];
    
    customButton.imageView.contentMode = UIViewContentModeCenter;
    customButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    customButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [self.tabBar addSubview:customButton];
    
    if(index == 0)//设置第一个选择项。（默认选择项） wsq
    {
        _previousBtn = customButton;
        _previousBtn.selected = YES;
    }

}

#pragma mark 按钮被点击时调用
- (void)changeViewController:(NTButton *)sender
 {
     if(self.selectedIndex != sender.tag)
     {
         self.selectedIndex = sender.tag; //切换不同控制器的界面
         _previousBtn.selected = ! _previousBtn.selected;
         _previousBtn = sender;
         _previousBtn.selected = YES;
     }
}
-(void)seleBtnIndex:(NSInteger)index
{
    _previousBtn.selected = NO;
    //切换不同控制器的界面

      NSMutableArray *ntvBtnArray = [NSMutableArray array];
    for (UIView *ntvBtnView in self.tabBar.subviews) {
        if ([ntvBtnView isKindOfClass:[NTButton class]]) {
            NTButton *selectBtn = (NTButton *)ntvBtnView;
            selectBtn.selected = NO;
            [ntvBtnArray addObject:ntvBtnView];
        
        }
    }
    self.selectedIndex = 2;
    NTButton *selectBtn = (NTButton *)ntvBtnArray[2];
    
    //[selectBtn setImage:[UIImage imageNamed:@"首页_订单选中"] forState:UIControlStateSelected];
    selectBtn.selected = YES;
    _previousBtn = selectBtn;

}
#pragma mark 是否隐藏tabBar
-(void)isHiddenCustomTabBarByBoolean:(BOOL)boolean
{
    _tabBarView.hidden=boolean;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_searchBar endEditing:NO];
}
@end
