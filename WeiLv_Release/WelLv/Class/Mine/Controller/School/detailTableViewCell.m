//
//  detailTableViewCell.m
//  WelLv
//
//  Created by mac for csh on 15/9/1.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "detailTableViewCell.h"

@implementation detailTableViewCell
@synthesize titleLab,lefImageV;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
//        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, windowContentWidth, 110)];
//        bgView.backgroundColor = [UIColor whiteColor];
//        [self addSubview:bgView];
        
        lefImageV = [[UIImageView alloc] initWithFrame:CGRectMake(45, 15, 10, 10)];
        lefImageV.image = [UIImage imageNamed: @"分类图标2"];
        [self addSubview:lefImageV];
        
        titleLab = [[UILabel alloc] initWithFrame:CGRectMake(45+10+10, 0, self.frame.size.width - 65, self.frame.size.height)];
        [self addSubview:titleLab];
    }
    
    return self;
}


@end
