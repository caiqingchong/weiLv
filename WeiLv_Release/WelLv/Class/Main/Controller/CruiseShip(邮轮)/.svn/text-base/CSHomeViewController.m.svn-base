//
//  CSHomeViewController.m
//  WelLv
//
//  Created by nick on 16/3/8.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "CSHomeViewController.h"
#import "CSNavigationBar.h"
#import "CSHomeCollectionViewDataSource.h"
#import "CSHomeCollectionViewDelegate.h"
#import "CSHomeCollectionViewCell.h"
#import "CSHomeCollectionHeader.h"
#import "CSLineListViewController.h"
#import "CSProductDetailViewController.h"

@interface CSHomeViewController ()<CSHomeDelegate>

@property(strong, nonatomic) CSNavigationBar *navBar;

@property(strong, nonatomic) UICollectionView *collectionView;

@property(strong, nonatomic) CSHomeCollectionViewDataSource *homeCollectionViewDataSource;

@property(strong, nonatomic) CSHomeCollectionViewDelegate *homeCollectionViewDelegate;

@end

@implementation CSHomeViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.homeCollectionViewDataSource = [[CSHomeCollectionViewDataSource alloc] init];
    
    self.homeCollectionViewDelegate = [[CSHomeCollectionViewDelegate alloc] init];
    
    self.homeCollectionViewDataSource.delegate = self;
    
    self.homeCollectionViewDelegate.delegate = self;
    
    [self setCollectionView];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    [self setNavBar];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    self.navigationController.navigationBar.hidden = NO;
}

//设置导航栏
- (void)setNavBar {

    NSArray *contents = @[[UIImage imageNamed:@"登录注册返回键"], @"", @""];
    
    self.navBar = [[CSNavigationBar alloc] initWithStyle:CSNavBarStyleTransparent leftItemSize:CGSizeMake(16, 25) rightItemSize:CGSizeMake(0, 0) andContents:contents];
                               
    [self.view addSubview:self.navBar];
}

- (void)setCollectionView {

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, -STATUS_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT + STATUS_BAR_HEIGHT) collectionViewLayout:flowLayout];
    
    self.collectionView.dataSource = self.homeCollectionViewDataSource;
    
    self.collectionView.delegate = self.homeCollectionViewDelegate;
    
    [self.collectionView registerClass:[CSHomeCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    
    [self.collectionView registerClass:[CSHomeCollectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerId"];
    
    self.collectionView.backgroundColor = BgViewColor;
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_collectionView];
}

#pragma - mark CSHomeDelegate
- (void)pushToLineListViewControllerWithLineId:(NSString *)lid andLineName:(NSString *)name {

    CSLineListViewController *lineListController = [[CSLineListViewController alloc] init];
    
    lineListController.lineName = name;
    
    [self.navigationController pushViewController:lineListController animated:YES];
}

- (void)pushToProductInfoViewControllerWithProductId:(NSInteger)pid {
    
    CSProductDetailViewController *productVC = [[CSProductDetailViewController alloc] init];
    
    productVC.productID = [NSString stringWithFormat:@"%ld",pid];
    
    [self.navigationController pushViewController:productVC animated:YES];
}

@end








