//
//  CSLineListCollectionViewDataSource.m
//  WelLv
//
//  Created by nick on 16/3/14.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "CSLineListCollectionViewDataSource.h"
#import "CSLineListCollectionViewCell.h"

@implementation CSLineListCollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    CSLineListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    for(id obj in cell.contentView.subviews){
    
        [obj removeFromSuperview];
    }
    
    [cell setLayoutWithContents:nil andIndexPath:indexPath];
    
    return cell;
}

@end
