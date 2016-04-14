//
//  CSLineListViewController.m
//  WelLv
//
//  Created by nick on 16/3/14.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "CSLineListViewController.h"
#import "CSNavigationBar.h"
#import "CSLineListCollectionViewDataSource.h"
#import "CSLineListCollectionViewDelegate.h"
#import "CSLineListCollectionViewCell.h"
#import "CSLineListFilterbar.h"

@interface CSLineListViewController ()

@property(strong, nonatomic) CSNavigationBar *navBar;

@property(strong, nonatomic) UICollectionView *productList;

@property(strong, nonatomic) CSLineListCollectionViewDataSource *lineListCollectionViewDataSource;

@property(strong, nonatomic) CSLineListCollectionViewDelegate *lineListCollectionViewDelegate;

@property(strong, nonatomic) CSLineListFilterbar *filterBar;

@end

@implementation CSLineListViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.lineListCollectionViewDataSource = [[CSLineListCollectionViewDataSource alloc] init];
    
    self.lineListCollectionViewDelegate = [[CSLineListCollectionViewDelegate alloc] init];
    
    [self setNavBar];
    
    [self setProductList];
    
    [self setFilterBar];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    self.navigationController.navigationBar.hidden = NO;
    
    for(id obj in [UIApplication sharedApplication].keyWindow.subviews){
    
        if([obj isKindOfClass:[UIView class]]){
        
            UIView *filterView = (UIView *)obj;
            
            if(filterView.tag == 999){
            
                [filterView removeFromSuperview];
            }
        }
    }
}

//设置导航栏
- (void)setNavBar {
    
    NSArray *contents = @[[UIImage imageNamed:@"back"], [NSString stringWithFormat:@"%@航线", self.lineName], @""];
    
    self.navBar = [[CSNavigationBar alloc] initWithStyle:CSNavBarStyleNormal leftItemSize:CGSizeMake(16, 25) rightItemSize:CGSizeMake(0, 0) andContents:contents];
    
    [self.view addSubview:self.navBar];
}

//设置产品列表
- (void)setProductList {

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.productList = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navBar.frame), SCREEN_WIDTH, SCREEN_HEIGHT - NAV_BAR_HEIGHT - FILTER_BAR_HEIGHT)collectionViewLayout:flowLayout];
    
    self.productList.dataSource = self.lineListCollectionViewDataSource;
    
    self.productList.delegate = self.lineListCollectionViewDelegate;
    
    [self.productList registerClass:[CSLineListCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    
    self.productList.backgroundColor = [UIColor whiteColor];
    
    self.productList.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.productList];
}

//设置筛选栏
- (void)setFilterBar {

    self.filterBar = [[CSLineListFilterbar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - FILTER_BAR_HEIGHT, SCREEN_WIDTH, FILTER_BAR_HEIGHT)andFilterConditions:nil];
    
    [self.view addSubview:self.filterBar];
}

@end








