//
//  PhotoViewCell.m
//  WelLv
//
//  Created by WeiLv on 16/1/24.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "PhotoViewCell.h"

@implementation PhotoViewCell

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.photoImage];
    }
    return self;
}

- (UIImageView *)photoImage{
    if (!_photoImage) {
        self.photoImage = [[UIImageView alloc]initWithFrame:self.bounds];
    }
    return _photoImage;
}

@end
