//
//  CSHomeBrandScrollView.m
//  WelLv
//
//  Created by nick on 16/3/11.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "CSHomeBrandScrollView.h"

@implementation CSHomeBrandScrollView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if(self){
    
        self.backgroundColor = [UIColor whiteColor];
        
        self.showsHorizontalScrollIndicator = NO;
    }
    
    return self;
}

- (void)setLayoutWithBrands:(NSArray *)brands {

    self.contentSize = CGSizeMake(BRAND_ITEM_WIDTH * brands.count + MARGIN_WIDTH * (brands.count - 1), self.contentSize.height);
    
    for(int i = 0; i < brands.count; i++){
    
        //邮轮品牌图片
        UIImageView *brandImageView = [[UIImageView alloc] initWithFrame:CGRectMake((BRAND_ITEM_WIDTH + MARGIN_WIDTH) * i, 0, BRAND_ITEM_WIDTH, BRAND_IMAGE_HEIGHT)];
        
        brandImageView.image = [UIImage imageNamed:[brands objectAtIndex:i]];
        
        [self addSubview:brandImageView];
    }
}

@end
