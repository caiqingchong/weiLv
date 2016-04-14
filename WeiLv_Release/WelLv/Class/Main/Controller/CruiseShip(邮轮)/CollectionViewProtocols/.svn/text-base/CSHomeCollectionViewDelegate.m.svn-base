//
//  CSHomeCollectionViewDelegate.m
//  WelLv
//
//  Created by nick on 16/3/10.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "CSHomeCollectionViewDelegate.h"
#import "CSHomeLineScrollView.h"
#import "CSHomeBrandScrollView.h"
#import "CSSearchBar.h"
#import "CSHomeCollectionViewCell.h"

@implementation CSHomeCollectionViewDelegate

#pragma - mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if(section > 1){
        
        return CGSizeMake(SCREEN_WIDTH, HEADER_HEIGHT);
    }
    
    return CGSizeMake(0.0, 0.0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {

    return 0.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    switch(indexPath.section){
    
        case 0:
            
            return CGSizeMake(SCREEN_WIDTH, 150.0 + SEARCH_BAR_TYPE_VIEW_HEIGHT / 2 + MARGIN_HEIGHT);
            
        case 1:
            
            return CGSizeMake(SCREEN_WIDTH, LINE_ITEM_HEIGHT);
            
        case 2:
            
            return CGSizeMake(SCREEN_WIDTH, BRAND_VIEW_HEIGHT);
            
        case 3:
            
            return CGSizeMake(SCREEN_WIDTH, 150.0 + 67.0 + MARGIN_HEIGHT);
            
        default:
            
            return CGSizeMake(0.0, 0.0);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CSHomeCollectionViewCell *cell = (CSHomeCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    [self.delegate pushToProductInfoViewControllerWithProductId:cell.tag];
}

@end








