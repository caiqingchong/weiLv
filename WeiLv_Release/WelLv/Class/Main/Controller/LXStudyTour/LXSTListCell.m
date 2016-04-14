//
//  LXSTListCell.m
//  WelLv
//
//  Created by 刘鑫 on 15/8/17.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//
#define LinerWidth 75
#import "LXSTListCell.h"
#import "LXSTListModel.h"
#import "LXCommonTools.h"

@implementation LXSTListCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initCellView];
    }
    
    return self;
}

-(void)initCellView
{
    _leftImageView=[[UIImageView alloc] init];
    _leftImageView.frame=CGRectMake(10, 10, LinerWidth, LinerWidth);
    _leftImageView.clipsToBounds=YES;
    _leftImageView.layer.cornerRadius=5.0;
    _leftImageView.layer.masksToBounds=YES;
    _leftImageView.contentMode=UIViewContentModeScaleAspectFill;
    _leftImageView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self addSubview:_leftImageView];
    
    _nameLab=[[UILabel alloc] init];
    float with = ViewX(_leftImageView)+ViewWidth(_leftImageView);
    _nameLab.frame=CGRectMake(with+10, ViewY(_leftImageView), windowContentWidth-with-20, 20);
    _nameLab.textAlignment=NSTextAlignmentLeft;
//_nameLab.adjustsFontSizeToFitWidth = YES;
    _nameLab.numberOfLines = 0;
    _nameLab.font=[UIFont systemFontOfSize:15];
    [self addSubview:_nameLab];
    
    //最近发团日期
    _lastestDate=[[UILabel alloc] init];
    _lastestDate.frame=CGRectMake(ViewX(_nameLab), 70, 80, 20);
    _lastestDate.textColor=kColor(115, 115, 120);
    _lastestDate.font=[UIFont systemFontOfSize:12];
    [self addSubview:_lastestDate];
    
    UILabel *strLab=[[UILabel alloc] initWithFrame:CGRectMake(ViewX(_nameLab), 50, 100, 20)];
    strLab.textColor=kColor(93, 156, 255);
    strLab.text=@"发团日期";
    strLab.font=[UIFont systemFontOfSize:13];
   // [self addSubview:strLab];
    
    _priceLab=[[UILabel alloc] init];
    _priceLab.frame=CGRectMake( windowContentWidth - 160, ViewY(_leftImageView)+ViewHeight(_leftImageView)-20, 150, 20);
    _priceLab.textAlignment=NSTextAlignmentRight;
    _priceLab.adjustsFontSizeToFitWidth = YES;
    _priceLab.font=[UIFont systemFontOfSize:18];
    _priceLab.textColor=kColor(255, 102, 0);
    [self addSubview:_priceLab];
    
    
    //返佣
    _gj_commissionLab=[[UILabel alloc] init];
    _gj_commissionLab.frame= CGRectMake(windowContentWidth-150, ViewY(_priceLab)-20, 135, 15);
    _gj_commissionLab.textAlignment=NSTextAlignmentRight;
    _gj_commissionLab.adjustsFontSizeToFitWidth = YES;
    _gj_commissionLab.font=[UIFont systemFontOfSize:10];
    _gj_commissionLab.textColor= kColor(255, 102, 0);
//    if ([[[LXUserTool alloc] getuserGroup] isEqualToString:@"assistant"])
//    {
//        [self addSubview:_gj_commissionLab];
//    }
    
    
}

-(void)setModel:(LXSTListModel *)model
{
    //DLog(@"数据==%@",model.thumb);
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/upload/thumb/%@",WLHTTP,model.thumb]] placeholderImage:[UIImage imageNamed:@"默认图1.png"]];
    _nameLab.text=model.name;
    CGFloat hgt = [[LXCommonTools sharedMyTools] textHeight:_nameLab.text Afont:15 width:ViewWidth(_nameLab)];
    // NSLog(@"str = %@\nhgt = %f",_titleLab.text,hgt);
    if (hgt>30) {
        _nameLab.numberOfLines = 2;
        _nameLab.frame = CGRectMake(_nameLab.frame.origin.x, _nameLab.frame.origin.y, _nameLab.frame.size.width,40);
    }else{
        _nameLab.numberOfLines = 1;
        _nameLab.frame = CGRectMake(_nameLab.frame.origin.x, _nameLab.frame.origin.y, _nameLab.frame.size.width,20);
    }

    
    if ([YXTools stringReturnNull:model.camper_price]==YES) {
        _priceLab.text=@"￥0";
    }else{
        _priceLab.text=[NSString stringWithFormat:@"￥%@",model.camper_price];
    }
    
    model.camper_rebate=[NSString stringWithFormat:@"%@",model.camper_rebate];

    if ([YXTools stringReturnNull:model.camper_rebate]==YES)
    {
        _gj_commissionLab.text=@"返佣：￥0";
    }else
    {
        _gj_commissionLab.text=[NSString stringWithFormat:@"返佣：￥%@",model.camper_rebate];
    }

    
    if ([YXTools  stringReturnNull:model.setoff_date]==YES) {
        _lastestDate.text=@"暂无班期";
    }else{
        _lastestDate.text=[NSString stringWithFormat:@"%@",model.setoff_date];
    }
if ([[[LXUserTool alloc] getuserGroup] isEqualToString:@"assistant"])
    {
            [self addSubview:_gj_commissionLab];
    }

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
