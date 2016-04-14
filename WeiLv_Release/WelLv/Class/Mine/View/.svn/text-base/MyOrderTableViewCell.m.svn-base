//
//  MyOrderTableViewCell.m
//  WelLv
//
//  Created by 刘鑫 on 15/4/11.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//
#define LinerWidth 75

#import "MyOrderTableViewCell.h"
#import "MyOrderModel.h"
#import "LXCommonTools.h"

@implementation MyOrderTableViewCell



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
//        _catLabel.text = @"订单分类";
//        CGSize size = [_catLabel.text sizeWithFont:_catLabel.font constrainedToSize:CGSizeMake(10, _catLabel.frame.size.height)];
//        //根据计算结果重新设置UILabel的尺寸
//        [_catLabel setFrame:CGRectMake(10, 0, size.width, 20)];
        [bgView addSubview:_catLabel];
        
//        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(ViewX(_catLabel)+ViewWidth(_catLabel)+5, 2 , 0.5, ViewHeight(_catLabel) -4)];
//        line.backgroundColor = [UIColor grayColor];
//        line.alpha = 0.8;
//        [bgView addSubview:line];
//        
//        //出发日期
//        _timeStringLab = [[UILabel alloc] init];
//        _timeStringLab.frame = CGRectMake(ViewX(line)+ViewWidth(line)+5, 0, ViewWidth(bgView) - ViewX(line)-ViewWidth(line), 20);
//        _timeStringLab.textAlignment=NSTextAlignmentLeft;
//        _timeStringLab.textColor = [UIColor blackColor];
//        _timeStringLab.font=[UIFont systemFontOfSize:13];
//        _timeStringLab.text = @"出发日期：";
//        CGSize size1 = [_timeStringLab.text sizeWithFont:_timeStringLab.font constrainedToSize:CGSizeMake(10, _timeStringLab.frame.size.height)];
//        //根据计算结果重新设置UILabel的尺寸
//        [_timeStringLab setFrame:CGRectMake(ViewX(line)+ViewWidth(line)+5, 0,ViewWidth(bgView)- 5 - size1.width - ViewX(line)-ViewWidth(line), 20)];
//        [bgView addSubview:_timeStringLab];
        
        //订单状态
        _orderStateLab=[[UILabel alloc] init];
        _orderStateLab.frame=CGRectMake(windowContentWidth-80, 0, 70, 20);
        _orderStateLab.textColor=[UIColor colorWithRed:92/255.0 green:157/255.0 blue:255/255.0 alpha:1];
//        _orderStateLab.alpha = 0.5;
        _orderStateLab.textAlignment = NSTextAlignmentRight;
        _orderStateLab.font=[UIFont systemFontOfSize:13];
        [bgView addSubview:_orderStateLab];

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
       // _titleLab.numberOfLines = 0;
        _titleLab.text = @"标题";
      //  CGFloat xheight = [[LXCommonTools sharedMyTools] textHeight:_titleLab.text Afont:16 width:windowContentWidth-with-20];
      //  _titleLab.frame=CGRectMake(with+10, ViewY(_leftImageView) , windowContentWidth-with-20, xheight);
        [bgView addSubview:_titleLab];
        
        //联系人
        _constactsLab = [[UILabel alloc] init];
        _constactsLab.frame = CGRectMake(with+10, ViewHeight(bgView)-7.5-26-4, ViewWidth(bgView)-10 - with, 13);
        _constactsLab.textAlignment=NSTextAlignmentLeft;
        _constactsLab.textColor = [UIColor grayColor];
        _constactsLab.font=[UIFont systemFontOfSize:12];
        _constactsLab.text = @"联系人：";
        _constactsLab.adjustsFontSizeToFitWidth = YES;
        CGSize size2 = [_constactsLab.text sizeWithFont:_constactsLab.font constrainedToSize:CGSizeMake(10, _constactsLab.frame.size.height)];
        //根据计算结果重新设置UILabel的尺寸
        [_constactsLab setFrame:CGRectMake(with+10, ViewHeight(bgView)-7.5-26-4,ViewWidth(bgView)- 10 - size2.width - with, 13)];
        [bgView addSubview:_constactsLab];
        
        //电话
        _phoneLab = [[UILabel alloc] init];
        _phoneLab.frame = CGRectMake(with+10, ViewHeight(bgView)-7.5-13, ViewWidth(bgView)-10 - with, 13);
        _phoneLab.textAlignment=NSTextAlignmentLeft;
        _phoneLab.textColor = [UIColor grayColor];
        _phoneLab.font=[UIFont systemFontOfSize:12];
        _phoneLab.text = @"电话：";
        _phoneLab.adjustsFontSizeToFitWidth = YES;
        CGSize size3 = [_phoneLab.text sizeWithFont:_phoneLab.font constrainedToSize:CGSizeMake(10, _phoneLab.frame.size.height)];
        //根据计算结果重新设置UILabel的尺寸
        [_phoneLab setFrame:CGRectMake(with+10, ViewHeight(bgView)-7.5-13,ViewWidth(bgView)- 10 - size3.width - with, 13)];
        [bgView addSubview:_phoneLab];
        
        //价格
        _priceLab=[[UILabel alloc] init];
        _priceLab.frame=CGRectMake(windowContentWidth -130, ViewY(_phoneLab)+ViewHeight(_phoneLab) -25, 120, 25);
        _priceLab.font=[UIFont systemFontOfSize:19];
        _priceLab.textAlignment=NSTextAlignmentRight;
        _priceLab.textColor=[UIColor orangeColor];
        [bgView addSubview:_priceLab];
        
//        //出行人数
//        _NumberLab=[[UILabel alloc] init];
//        _NumberLab.frame=CGRectMake(ViewX(_titleLab), ViewY(_priceLab)+30, 140, 20);
//        _NumberLab.textColor=[UIColor grayColor];
//        _NumberLab.font=[UIFont systemFontOfSize:13];
//        _NumberLab.adjustsFontSizeToFitWidth =YES;
//        _NumberLab.numberOfLines=0;
//        [bgView addSubview:_NumberLab];
        
        
        
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
    
    if (!(item.priceStr == nil || [item.priceStr isEqual:[NSNull null]])) {
        _priceLab.text=item.priceStr;
    }
   
    if (!(item.orderState == nil || [item.orderState isEqual:[NSNull null]])) {
        _orderStateLab.text=item.orderState;
    }
    
    if (!(item.catName == nil || [item.catName isEqual:[NSNull null]])) {
        _catLabel.text=item.catName;
    }
    
    if (!(item.timeStr == nil || [item.timeStr isEqual:[NSNull null]])) {
        _timeStringLab.text=item.timeStr;
    }
    
    if (!(item.contactsStr == nil || [item.contactsStr isEqual:[NSNull null]])) {
        _constactsLab.text=item.contactsStr;
    }
    
    if (!(item.phoneStr == nil || [item.phoneStr isEqual:[NSNull null]])) {
        _phoneLab.text=item.phoneStr;
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
