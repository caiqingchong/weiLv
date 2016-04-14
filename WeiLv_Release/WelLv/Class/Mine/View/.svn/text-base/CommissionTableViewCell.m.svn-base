//
//  CommissionTableViewCell.m
//  WelLv
//
//  Created by mac for csh on 15/9/6.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#define LinerWidth 75

#import "CommissionTableViewCell.h"
#import "MyOrderModel.h"
#import "LXCommonTools.h"

@implementation CommissionTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = BgViewColor;
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, windowContentWidth, 110)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        
        //产品分类
        _catLabel= [[UILabel alloc] init];
        _catLabel.frame = CGRectMake(10, 0, ViewWidth(bgView), 20);
        _catLabel.textAlignment=NSTextAlignmentLeft;
        _catLabel.textColor = [UIColor blackColor];
        _catLabel.font=[UIFont systemFontOfSize:12];
        _catLabel.text = @"订单分类";
        //CGSize size = [_catLabel.text sizeWithFont:_catLabel.font constrainedToSize:CGSizeMake(10, _catLabel.frame.size.height)];
        //根据计算结果重新设置UILabel的尺寸
        [_catLabel setFrame:CGRectMake(10, 0, 50, 20)];
        [bgView addSubview:_catLabel];
        
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(ViewX(_catLabel)+ViewWidth(_catLabel)+5, 2 , 0.5, ViewHeight(_catLabel) -4)];
                line.backgroundColor = [UIColor grayColor];
                line.alpha = 0.8;
                [bgView addSubview:line];
        
                //出发日期
                _timeStringLab = [[UILabel alloc] init];
                _timeStringLab.frame = CGRectMake(ViewX(line)+ViewWidth(line)+5, 0, ViewWidth(bgView) - ViewX(line)-ViewWidth(line), 20);
                _timeStringLab.textAlignment=NSTextAlignmentLeft;
                _timeStringLab.textColor = [UIColor blackColor];
                _timeStringLab.font=[UIFont systemFontOfSize:13];
                _timeStringLab.text = @"出发日期：";
                CGSize size1 = [_timeStringLab.text sizeWithFont:_timeStringLab.font constrainedToSize:CGSizeMake(10, _timeStringLab.frame.size.height)];
                //根据计算结果重新设置UILabel的尺寸
                [_timeStringLab setFrame:CGRectMake(ViewX(line)+ViewWidth(line)+5, 0,ViewWidth(bgView)- 5 - size1.width - ViewX(line)-ViewWidth(line), 20)];
                [bgView addSubview:_timeStringLab];
        
               
        UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 20-1, ViewWidth(bgView), 1)];
        vv.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:0.8];
        [bgView addSubview:vv];
        
        //左侧图片
        _leftImageView=[[UIImageView alloc] init];
        _leftImageView.frame=CGRectMake(10,ViewY(vv)+ViewHeight(vv)+7.5, LinerWidth, LinerWidth);
        _leftImageView.layer.masksToBounds = YES;
        _leftImageView.layer.cornerRadius = 3.5; //设置图片圆角的尺度
        [bgView addSubview:_leftImageView];
        
        //标题
        _titleLab=[[UILabel alloc] init];
        float with = ViewX(_leftImageView)+ViewWidth(_leftImageView);
        _titleLab.frame=CGRectMake(with+10, ViewY(_leftImageView), windowContentWidth-with-20, 40);
        _titleLab.textAlignment=NSTextAlignmentLeft;
        _titleLab.adjustsFontSizeToFitWidth = YES;
        _titleLab.font=[UIFont systemFontOfSize:16];
        _titleLab.numberOfLines = 0;
        _titleLab.text = @"标题";
        //  CGFloat xheight = [[LXCommonTools sharedMyTools] textHeight:_titleLab.text Afont:16 width:windowContentWidth-with-20];
        //  _titleLab.frame=CGRectMake(with+10, ViewY(_leftImageView) , windowContentWidth-with-20, xheight);
        [bgView addSubview:_titleLab];
        
        
        
        //返佣
        _commissionLab=[[UILabel alloc] init];
        _commissionLab.frame=CGRectMake(windowContentWidth -180, ViewY(_leftImageView)+ViewHeight(_leftImageView) -25, 170, 25);
        _commissionLab.font=[UIFont systemFontOfSize:17];
        _commissionLab.textAlignment=NSTextAlignmentRight;
        _commissionLab.textColor=[UIColor orangeColor];
        [bgView addSubview:_commissionLab];
        
        //订单编号
        _orderSNLab = [[UILabel alloc] init];
        _orderSNLab.frame = CGRectMake(with +10, ViewY(_leftImageView)+ViewHeight(_leftImageView) -20, windowContentWidth -with -10 -100, 20);
        _orderSNLab.font = [UIFont systemFontOfSize:13];
        _orderSNLab.textAlignment = NSTextAlignmentLeft;
       // _orderSNLab.adjustsFontSizeToFitWidth = YES;
        _orderSNLab.textColor = [UIColor grayColor];
        _orderSNLab.lineBreakMode = NSLineBreakByCharWrapping;
        [bgView addSubview:_orderSNLab];
    }
    
    return self;
}


-(void)setItem:(MyOrderModel *)item
{
    if ([item.cat_id integerValue] == -3){
        [_leftImageView setImage:[UIImage imageNamed:@"订单机票"]];
    }else{
        if ([item.leftImageUrl isEqualToString: @""]) {
            [_leftImageView setImage:[UIImage imageNamed:@"默认图1"]];
        }else{
            [_leftImageView sd_setImageWithURL:[NSURL URLWithString:item.leftImageUrl] placeholderImage:[UIImage imageNamed:@"默认图1"]];
        }
    }
    
    if (!(item.titleStr == nil || [item.titleStr isEqual:[NSNull null]])) {
        
        _titleLab.text=item.titleStr;
        CGFloat hgt = [[LXCommonTools sharedMyTools] textHeight:_titleLab.text Afont:16 width:ViewWidth(_titleLab)];
        // NSLog(@"str = %@\nhgt = %f",_titleLab.text,hgt);
        if (hgt>30) {
            _titleLab.numberOfLines = 2;
            _titleLab.frame = CGRectMake(_titleLab.frame.origin.x, _titleLab.frame.origin.y, _titleLab.frame.size.width,40);
        }else{
            _titleLab.numberOfLines = 1;
            _titleLab.frame = CGRectMake(_titleLab.frame.origin.x, _titleLab.frame.origin.y, _titleLab.frame.size.width,20);
        }
    }
    
    if (!(item.commissionStr == nil || [item.commissionStr isEqual:[NSNull null]])) {
        _commissionLab.text=item.commissionStr;
    }
    
    if (!(item.catName == nil || [item.catName isEqual:[NSNull null]])) {
        _catLabel.text=item.catName;
    }
    
    if (!(item.timeStr == nil || [item.timeStr isEqual:[NSNull null]])) {
        _timeStringLab.text=item.timeStr;
    }
    
    if (!(item.orderSN == nil || [item.orderSN isEqual:[NSNull null]])) {
        _orderSNLab.text=item.orderSN;
        CGFloat hgt = [[LXCommonTools sharedMyTools] textHeight: _orderSNLab.text Afont:13 width:ViewWidth(_orderSNLab)];
        CGFloat xxx = [[LXCommonTools sharedMyTools] textHeight: @"" Afont:13 width:ViewWidth(_orderSNLab)];
//NSLog(@"hgt = %f\nxxx = %f",_orderSNLab.text,hgt,xxx);
        float with = ViewX(_leftImageView)+ViewWidth(_leftImageView);
        if (hgt != xxx) {
            _orderSNLab.numberOfLines = 2;
            _orderSNLab.frame = CGRectMake(with +10, ViewY(_leftImageView)+ViewHeight(_leftImageView) -40, windowContentWidth -with -10 -100,40);
        }else{
            _orderSNLab.numberOfLines = 1;
            _orderSNLab.frame = CGRectMake(with +10, ViewY(_leftImageView)+ViewHeight(_leftImageView) -20, windowContentWidth -with -10 -100,20);
        }
    }
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
