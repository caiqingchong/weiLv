//
//  WLStewardHomeVC.m
//  WelLv
//
//  Created by WeiLv on 15/12/1.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "WLStewardHomeVC.h"
#import "WLStewardHomeCell.h"
#import "WLSteHomeHeaderView.h"
#import "WLSteHomeFooterView.h"
#import "YXBannerView.h"
#import "WLStewardDetailVC.h"
#import "WLStewardListVC.h"

#define M_CYCLE_HEIGHT 150
#define M_STEWARD_NUM_LAB_HEIGHT 75
#define M_CELL_INDENTIFIER @"Cell"
#define M_HEADER_INDENTIFIER @"Header"
#define M_FOOTER_INDENTIFIER @"Footer"
#define M_FOOTER_CHANGE_INDENTIFIER @"Footer_change"

@interface WLStewardHomeVC ()<UICollectionViewDataSource, UICollectionViewDelegate, EScrollerViewDelegate>

@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) YXBannerView * headerView;
@property (nonatomic, strong) NSMutableArray * adArr;
@property (nonatomic, strong) NSMutableArray * dataArr;
@end

@implementation WLStewardHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"旅行管家";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame=CGRectMake(0, 0, 24, 24.5);
    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:searchBtn];

    [self createCollectionView];
    [self addCycleView];
    
    self.navigationController.view.userInteractionEnabled = NO;
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.size = CGSizeMake(80, 80);
    indicator.center = CGPointMake(self.view.width / 2, self.view.height / 2);
    indicator.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.670];
    indicator.clipsToBounds = YES;
    indicator.layer.cornerRadius = 6;
    [indicator startAnimating];
    [self.view addSubview:indicator];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [indicator removeFromSuperview];
        self.navigationController.view.userInteractionEnabled = YES;

    });
}
#pragma mark ---- 搜索
/**
 *  跳转到搜索页面。
 */
-(void)searchBtnClick
{
//    SearchViewController *seachVc=[[SearchViewController alloc] init];
//    seachVc.searchType = 6;
//    [self.navigationController pushViewController:seachVc animated:YES];
}
#pragma mark - Banner
/**
 *  加载轮播图
 */
- (void)addCycleView {
    
    if (self.headerView != nil)
    {
        [self.headerView removeFromSuperview];
    }
    NSMutableArray * arr = [NSMutableArray array];
    for (int i = 0; i < self.adArr.count; i++) {
        LXAdvertModel * model = [self.adArr objectAtIndex:i];
        [arr addObject:[self judgeImageURL:model.src]];
    }
    self.headerView = [[YXBannerView alloc] initWithFrameRect:CGRectMake(0, -(M_CYCLE_HEIGHT + M_STEWARD_NUM_LAB_HEIGHT), windowContentWidth, M_CYCLE_HEIGHT) ImageArray:arr];
    self.headerView.delegate = self;
    self.headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.collectionView addSubview:self.headerView];
}

- (void)EScrollerViewDidClicked:(NSUInteger)index {
    
}

#pragma mark - CreateCollectionView

- (void)createCollectionView {
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ControllerViewHeight) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.contentInset = UIEdgeInsetsMake((M_CYCLE_HEIGHT + M_STEWARD_NUM_LAB_HEIGHT), 0, 0, 0);
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerClass:[WLStewardHomeCell class] forCellWithReuseIdentifier:M_CELL_INDENTIFIER];
    [self.view addSubview:_collectionView];
    
    [self.collectionView registerClass:[WLSteHomeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:M_HEADER_INDENTIFIER];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:M_FOOTER_INDENTIFIER];
    
    [self.collectionView registerClass:[WLSteHomeFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:M_FOOTER_CHANGE_INDENTIFIER];
}

#pragma mark - UICollectionDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            return MIN(6, 8);
        }
            break;
        case 1:
        {
            return 3;
        }
            break;
        default:
            break;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WLStewardHomeCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:M_CELL_INDENTIFIER forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        WLSteHomeHeaderView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:M_HEADER_INDENTIFIER forIndexPath:indexPath];
        view.backgroundColor = [UIColor whiteColor];
        
        switch (indexPath.section) {
            case 0:
            {
                view.moreBut.hidden = NO;
                view.titleOneLab.userInteractionEnabled = YES;
                [view.moreBut addTarget:self action:@selector(goMoreView) forControlEvents:UIControlEventTouchUpInside];
            }
                break;
            case 1:
            {
                view.moreBut.hidden = YES;
            }
                break;
            default:
                break;
        }
        
        return view;
    } else {
        switch (indexPath.section) {
            case 0:
            {
                UICollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:M_FOOTER_INDENTIFIER forIndexPath:indexPath];
                view.backgroundColor = [UIColor groupTableViewBackgroundColor];
                return view;
            }
                break;
            case 1:
            {
                WLSteHomeFooterView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:M_FOOTER_CHANGE_INDENTIFIER forIndexPath:indexPath];
                view.backgroundColor = [UIColor whiteColor];
                [view.changeBut addTarget:self action:@selector(changePartner) forControlEvents:UIControlEventTouchUpInside];
                return view;
            }
                break;

            default:
                break;
        }
    }
    return nil;
}

#pragma mark - UICollectionDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WLStewardDetailVC * vc = [[WLStewardDetailVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return CGSizeMake(windowContentWidth / 3.0, windowContentWidth / 3.0 + 25);
            break;
            
        case 1:
            return CGSizeMake(windowContentWidth / 3.0, windowContentWidth / 3.0 + 25);;
            break;
            
        default:
            break;
    }
    
    return CGSizeMake(0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    switch (section) {
        case 0:
            return 0;
            break;
            
        case 1:
            return 0;
            break;
            
        default:
            break;
    }
    return 0;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    switch (section) {
        case 0:
            return UIEdgeInsetsMake(0, 0, 0, 0);
            break;
            
        case 1:
            return UIEdgeInsetsMake(0, 0, 0, 0);
            break;
            
            
        default:
            break;
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return CGSizeMake(windowContentWidth, 55);
            
            break;
        case 1:
            return CGSizeMake(windowContentWidth, 55);
            
            break;
            
        default:
            break;
    }
    return CGSizeMake(windowContentWidth, 55);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
             return CGSizeMake(windowContentWidth, 15);
            break;
        case 1:
            return CGSizeMake(windowContentWidth, 60);
            
            break;
            
        default:
            break;
    }
    return CGSizeMake(windowContentWidth, 0);
}

#pragma mark - 按钮点击方法

- (void)changePartner {
    NSLog(@"changePartner");
}

- (void)goMoreView {
    NSLog(@"list");
    WLStewardListVC * vc = [[WLStewardListVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 加载数据

- (void)loadData {
    
}

#pragma mark - 懒加载

- (NSMutableArray *)adArr {
    if (_adArr) {
        self.adArr = [NSMutableArray array];
    }
    return _adArr;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        self.dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


@end
