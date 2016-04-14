//
//  CSHomeCollectionHeader.m
//  WelLv
//
//  Created by nick on 16/3/10.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "CSHomeCollectionHeader.h"

@interface CSHomeCollectionHeader ()

@property(strong, nonatomic) UIImageView *headerIcon;

@property(strong, nonatomic) UILabel *headerTitle;

@end

@implementation CSHomeCollectionHeader

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if(self){
    
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)setLayoutWithTitles:(NSArray *)titles andIndexPath:(NSIndexPath *)indexPath {

    //类型图标
    self.headerIcon = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN_WIDTH, 5, 30, 30)];
    
    self.headerIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"header_%li.png", indexPath.section]];
    
    self.headerIcon.layer.masksToBounds = YES;
    
    self.headerIcon.layer.cornerRadius = self.headerIcon.frame.size.width / 2;
    
    [self addSubview:self.headerIcon];
    
    //标题
    CGFloat titleOriginX = CGRectGetMaxX(self.headerIcon.frame) + MARGIN_WIDTH;
    
    self.headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(titleOriginX, 0, SCREEN_WIDTH - titleOriginX - MARGIN_WIDTH - MORE_VIEW_WIDTH, self.frame.size.height)];
    
    self.headerTitle.text = [titles objectAtIndex:indexPath.section - 1];
    
    self.headerTitle.font = [UIFont systemFontOfSize:15.0];
    
    self.headerTitle.textColor = [UIColor colorWithRed:45.0/255.0 green:45.0/255.0 blue:45.0/255.0 alpha:1];
    
    [self addSubview:self.headerTitle];
    
    //更多按钮
    if(indexPath.section == 3){
    
        UIView *moreView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headerTitle.frame), 0, MORE_VIEW_WIDTH, self.frame.size.height)];
        
        [self addSubview:moreView];
        
        UILabel *moreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 28, moreView.frame.size.height)];
        
        moreLabel.text = @"更多";
        
        moreLabel.font = [UIFont systemFontOfSize:14.0];
        
        moreLabel.textAlignment = NSTextAlignmentCenter;
        
        moreLabel.textColor =  kColor(97, 115, 120);
        
        [moreView addSubview:moreLabel];
        
        CGFloat iconSize = 12;
        
        UIImageView *moreIcon = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(moreLabel.frame) + 5, (moreView.frame.size.height - iconSize) / 2, iconSize, iconSize)];
        
        moreIcon.image = [UIImage imageNamed:@"更多"];
        
        [moreView addSubview:moreIcon];
    }
}

@end








