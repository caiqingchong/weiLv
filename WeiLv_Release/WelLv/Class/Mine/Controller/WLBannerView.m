//
//  WLBannerView.m
//  WelLv
//
//  Created by 赵阳 on 16/1/1.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "WLBannerView.h"
#import "UIImageView+WebCache.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation WLBannerView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 0.4);
        
        [self setSubview];
    }
    
    return self;
}

- (void)setSubview {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    [self addSubview:imageView];
    
    self.imageView = imageView;
}

- (void)setImageWithUrl:(NSString *)urlStr {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.weilv100.com%@", urlStr]];
    
    [self.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"默认图3"]];
}

@end






