//
//  BaseTableViewCell.m
//  WelLv
//
//  Created by 刘鑫 on 15/4/3.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#define LinerWidth 75

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _leftImageView=[[UIImageView alloc] init];
        _leftImageView.frame=CGRectMake(10, 10, LinerWidth, LinerWidth);
        [self addSubview:_leftImageView];
        
        _titleLab=[[UILabel alloc] init];
        float with = ViewX(_leftImageView)+ViewWidth(_leftImageView);
        _titleLab.frame=CGRectMake(with+10, ViewY(_leftImageView), windowContentWidth-with-20, 40);
        _titleLab.textAlignment=NSTextAlignmentLeft;
        _titleLab.adjustsFontSizeToFitWidth = YES;
        _titleLab.numberOfLines = 0;
        _nameLab.font=[UIFont systemFontOfSize:15];
        [self addSubview:_titleLab];
        
        _nameLab=[[UILabel alloc] init];
        _nameLab.frame=CGRectMake(ViewX(_leftImageView)+ViewWidth(_leftImageView)+10, ViewY(_titleLab)+60, windowContentWidth-LinerWidth-100, 30);
        _nameLab.font=[UIFont systemFontOfSize:14];
        _nameLab.numberOfLines = 0;
        _nameLab.textAlignment=NSTextAlignmentLeft;
        _nameLab.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_nameLab];
        
        //出售份数图片
        _soldNumberImage=[[UIImageView alloc] init];
        _soldNumberImage.frame=CGRectMake(ViewX(_nameLab), ViewY(_titleLab)+40, 20, 20);
        [self addSubview:_soldNumberImage];
        
        _soldNumberLab=[[UILabel alloc] init];
        _soldNumberLab.frame=CGRectMake(ViewX(_soldNumberImage)+10, ViewY(_soldNumberImage), 100, 20);
        _soldNumberLab.textColor=[UIColor grayColor];
        _soldNumberLab.font=[UIFont systemFontOfSize:14];
        [self addSubview:_soldNumberLab];
        
        //评分图片
        _gradeImage=[[UIImageView alloc] init];
        _gradeImage.frame=CGRectMake(ViewX(_soldNumberLab)+100, ViewY(_titleLab)+40, 20, 20);
        [self addSubview:_gradeImage];
        
        _gradeLab=[[UILabel alloc] init];
        _gradeLab.frame=CGRectMake(ViewX(_gradeImage)+10, ViewY(_titleLab)+40, 100, 20);
        _gradeLab.textColor=[UIColor grayColor];
        _gradeLab.font=[UIFont systemFontOfSize:14];
        [self addSubview:_gradeLab];
        
        _priceLab=[[UILabel alloc] init];
        _priceLab.frame=CGRectMake(windowContentWidth-100, ViewY(_titleLab)+40, 100, 30);
        _priceLab.font=[UIFont systemFontOfSize:17];
        _priceLab.textAlignment=NSTextAlignmentCenter;
        _priceLab.textColor=[UIColor orangeColor];
        [self addSubview:_priceLab];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(_nameLab)+ViewY(_nameLab)+5, windowContentWidth, 0.5)];
        line.backgroundColor = bordColor;
        [self addSubview:line];
    }
    
    return self;
}


-(void)setItem:(BaseCellModel *)item
{
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:item.leftImageUrl] placeholderImage:nil];
    _titleLab.text=item.titleStr;
    _nameLab.text=item.nameStr;
    _priceLab.text=item.priceStr;
    _soldNumberImage.image=[UIImage imageNamed:nil];
    _soldNumberLab.text=item.soldNuberStr;
    _gradeImage.image=[UIImage imageNamed:nil];
    _gradeLab.text=item.gradeStr;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
