//
//  CSHomeCollectionViewDataSource.m
//  WelLv
//
//  Created by nick on 16/3/10.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "CSHomeCollectionViewDataSource.h"
#import "CSHomeCollectionViewCell.h"
#import "CSHomeCollectionHeader.h"
#import "YXBannerView.h"
#import "CSSearchBar.h"
#import "CSHomeLineScrollView.h"
#import "CSHomeBrandScrollView.h"

@interface CSHomeCollectionViewDataSource ()<CSHomeLineScrollViewSelectedDelegate>

@end

@implementation CSHomeCollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if(section == 3){
    
        return 3;
    }
    
    return 1;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    CSHomeCollectionHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerId" forIndexPath:indexPath];
    
    for(id obj in header.subviews){
    
        [obj removeFromSuperview];
    }
    
    [header setLayoutWithTitles:@[@"邮轮航线", @"邮轮品牌", @"热推产品"] andIndexPath:indexPath];
    
    return header;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    CSHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    for(id obj in cell.contentView.subviews){
    
        [obj removeFromSuperview];
    }
    
    switch(indexPath.section){
    
        case 0:{
            
            //头部滚动图
            NSArray *images = @[@"http://101.201.211.41:8088/upload/advert/201602/14565454928565.jpg",
                                @"http://101.201.211.41:8088/upload/advert/201602/14565454928565.jpg",
                                @"http://101.201.211.41:8088/upload/advert/201602/14565454928565.jpg"];
            
            YXBannerView *bannerView = [[YXBannerView alloc] initWithFrameRect:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height - SEARCH_BAR_TYPE_VIEW_HEIGHT / 2 - MARGIN_HEIGHT) ImageArray:images];
            
            bannerView.pageControl.frame = CGRectMake(bannerView.pageControl.frame.origin.x, bannerView.pageControl.frame.origin.y - SEARCH_BAR_TYPE_VIEW_HEIGHT / 2, bannerView.pageControl.frame.size.width, bannerView.pageControl.frame.size.height);
            
            [cell.contentView addSubview:bannerView];
            
            //搜索栏
            CSSearchBar *searchBar = [[CSSearchBar alloc] initWithFrame:CGRectMake(MARGIN_WIDTH, CGRectGetMaxY(bannerView.frame) - SEARCH_BAR_TYPE_VIEW_HEIGHT / 2, cell.frame.size.width - MARGIN_WIDTH * 2, SEARCH_BAR_TYPE_VIEW_HEIGHT) SearchBarType:SearchBarTypeView andPlaceholder:@"请输入邮轮目的地/关键字"];
            
            [cell.contentView addSubview:searchBar];
        }
            
            break;
            
        case 1:{
        
            //邮轮航线滚动列表
            NSArray *contents = @[@{@"image": @"line_rh.png", @"name": @"日韩"},
                                  @{@"image": @"line_rb.png", @"name": @"日本"},
                                  @{@"image": @"line_hg.png", @"name": @"韩国"},
                                  @{@"image": @"line_dzh.png", @"name": @"地中海"},
                                  @{@"image": @"line_rh.png", @"name": @"日韩"},
                                  @{@"image": @"line_rb.png", @"name": @"日本"},
                                  @{@"image": @"line_hg.png", @"name": @"韩国"},
                                  @{@"image": @"line_dzh.png", @"name": @"地中海"}];
            
            CSHomeLineScrollView *lineScrollView = [[CSHomeLineScrollView alloc] initWithFrame:CGRectMake(MARGIN_WIDTH, 0, SCREEN_WIDTH - MARGIN_WIDTH * 2, cell.frame.size.height - MARGIN_HEIGHT)];
            
            lineScrollView.sdelegate = self;
            
            [lineScrollView setLayoutWithLineContents:contents];
            
            [cell.contentView addSubview:lineScrollView];
            
            //底边框
            UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineScrollView.frame), cell.frame.size.width, MARGIN_HEIGHT)];
            
            bottomView.backgroundColor = BgViewColor;
            
            [cell.contentView addSubview:bottomView];
        }
            
            break;
            
        case 2:{
        
            //邮轮品牌滚动列表
            NSArray *brands = @[@"brand_gsd.png", @"brand_gz.png",
                                @"brand_gsd.png", @"brand_gz.png",
                                @"brand_gsd.png", @"brand_gz.png"];
            
            CSHomeBrandScrollView *brandScrollView = [[CSHomeBrandScrollView alloc] initWithFrame:CGRectMake(MARGIN_WIDTH, 0, SCREEN_WIDTH - MARGIN_WIDTH * 2, BRAND_IMAGE_HEIGHT)];
            
            [brandScrollView setLayoutWithBrands:brands];
            
            [cell.contentView addSubview:brandScrollView];
            
            //底边框
            UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(brandScrollView.frame) + MARGIN_HEIGHT + 1, cell.frame.size.width, MARGIN_HEIGHT)];
            
            bottomView.backgroundColor = BgViewColor;
            
            [cell.contentView addSubview:bottomView];
        }
            
            break;
            
        case 3:{
        
            [cell setLayoutWithContents:nil andIndexPath:indexPath];
        }
            
            break;
    }
    
    return cell;
}

#pragma - mark CSHomeLineScrollViewSelectedDelegate
- (void)didSelectLineItemWithLineId:(NSString *)lid andLineName:(NSString *)name {

    [self.delegate pushToLineListViewControllerWithLineId:lid andLineName:name];
}

@end








