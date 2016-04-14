//
//  LXTraveCellTableViewCell.m
//  WelLv
//
//  Created by 刘鑫 on 15/4/23.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//
#define LinerWidth 75

#import "LXTraveCellTableViewCell.h"
#import "LXTraveModel.h"
#import "LXCommonTools.h"

@implementation LXTraveCellTableViewCell


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
    _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    _leftImageView.clipsToBounds = YES;
    _leftImageView.layer.cornerRadius = 5.0;
    _leftImageView.layer.masksToBounds = YES;
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
    _lastestDate.font=[UIFont systemFontOfSize:13];
    [self addSubview:_lastestDate];
    
    UILabel *strLab=[[UILabel alloc] initWithFrame:CGRectMake(ViewX(_nameLab), 50, 100, 20)];
    strLab.textColor=kColor(93, 156, 255);
    strLab.text=@"发团日期";
    strLab.font=[UIFont systemFontOfSize:10];
  //  [self addSubview:strLab];
    
    _priceLab=[[UILabel alloc] init];
    _priceLab.frame=CGRectMake( windowContentWidth - 150, ViewY(_leftImageView)+ViewHeight(_leftImageView) -20, 140, 20);
    _priceLab.textAlignment=NSTextAlignmentRight;
    _priceLab.adjustsFontSizeToFitWidth = YES;
    _priceLab.font=[UIFont systemFontOfSize:18];
    _priceLab.textColor=kColor(255, 102, 0);
    [self addSubview:_priceLab];
    
    
    //返佣
    _gj_commissionLab=[[UILabel alloc] init];
    _gj_commissionLab.frame=CGRectMake(windowContentWidth-150, ViewY(_priceLab)-20, 135, 15);
    _gj_commissionLab.textAlignment=NSTextAlignmentRight;
    _gj_commissionLab.adjustsFontSizeToFitWidth = YES;
    _gj_commissionLab.font=[UIFont systemFontOfSize:10];
    _gj_commissionLab.textColor=kColor(255, 102, 0);
    //if ([[[LXUserTool alloc] getuserGroup] isEqualToString:@"assistant"])
    //{
        [self addSubview:_gj_commissionLab];
    //}
    
    
//    
//    _infoLab=[[UILabel alloc] init];
//    _infoLab.frame=CGRectMake(with+10, ViewY(_leftImageView)+50, windowContentWidth-with-20, 30);
//    _infoLab.textAlignment=NSTextAlignmentLeft;
//    //_infoLab.adjustsFontSizeToFitWidth = YES;
//    _infoLab.numberOfLines=1;
//    _infoLab.font=[UIFont systemFontOfSize:13];
//    _infoLab.textColor=[UIColor grayColor];
//    [self addSubview:_infoLab];
    
    UIView *line=[[UIView alloc] init];
    line.frame=CGRectMake(0, 94.5, windowContentWidth, 0.5);
    line.backgroundColor=TableLineColor;
    [self addSubview:line];
}

-(void)setItem:(LXTraveModel *)item
{
    //图片
    if ([item.leftImage hasPrefix:@"http"]) {
        [_leftImageView sd_setImageWithURL:[NSURL URLWithString:item.leftImage] placeholderImage:[UIImage imageNamed:@"默认图1"]];
    } else {
        NSString *imageUrl = [NSString stringWithFormat:@"%@%@",WLHTTP,item.leftImage];
        [_leftImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]placeholderImage:[UIImage imageNamed:@"默认图1"]];
    }
    _nameLab.text=item.name;
    CGFloat hgt = [[LXCommonTools sharedMyTools] textHeight:_nameLab.text Afont:15 width:ViewWidth(_nameLab)];

    if (hgt>30)
    {
        _nameLab.numberOfLines = 2;
        _nameLab.frame = CGRectMake(_nameLab.frame.origin.x, _nameLab.frame.origin.y, _nameLab.frame.size.width,40);
    }
    else
    {
        _nameLab.numberOfLines = 1;
        _nameLab.frame = CGRectMake(_nameLab.frame.origin.x, _nameLab.frame.origin.y, _nameLab.frame.size.width,20);
    }
    DLog(@"%@",item.price);
    
    
    
    _priceLab.text=[NSString stringWithFormat:@"￥%0.2f",[item.price floatValue]];
     DLog(@"%@",_priceLab.text);
    //NSString *houseAdmin_ID=[[LXUserTool alloc] getHouseAdmin_id];
    
   // if ([item.admin_id intValue] == [houseAdmin_ID intValue])
    //{
        _gj_commissionLab.hidden=NO;
        if (item.gj_commission==nil)
        {
            _gj_commissionLab.text=@"返佣：￥0.00";
        }
        else
        {
            _gj_commissionLab.text=[NSString stringWithFormat:@"返佣：￥%.2f",[item.gj_commission floatValue]];
        }
  
    if (![[[LXUserTool alloc] getuserGroup] isEqual:@"assistant"]) {
         _gj_commissionLab.hidden=YES;
    }
    
    
    
    
    //}
//    else
//    {
//        _gj_commissionLab.hidden=YES;
//    }
    
    if ([YXTools  stringReturnNull:item.lastest]==YES)
    {
        _lastestDate.text=@"暂无班期";
    }
    else
    {
        _lastestDate.text=[NSString stringWithFormat:@"%@",item.lastest];
    }
    

    //uilabe加载html
    if (item.info == nil || [item.info isEqual:[NSNull null]])
    {
        _infoLab.text=nil;
    }
    else
    {
        //去掉标签，首尾空格
        _infoLab.text=[[[self filterHTML:item.info] stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
    }
    
}

#pragma mark -
#pragma mark 去掉字符串中的标签
-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}

- (CGRect)returnTextCGRectText:(NSString *)str textFont:(CGFloat)font
{
    NSDictionary * textDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil];
    CGRect rect = [str boundingRectWithSize:CGSizeMake(0, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
    return rect;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
