//
//  ZFJStewardCell.m
//  WelLv
//
//  Created by 张发杰 on 15/4/17.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//
#define LinerWidth 95

#import "ZFJStewardCell.h"
#import "LXGuanJiaModel.h"

@implementation ZFJStewardCell

/*
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //self.backgroundColor = [UIColor cyanColor];
        self.leftImageView=[[UIImageView alloc] init];
        _leftImageView.frame=CGRectMake(10, 10, LinerWidth - 10, LinerWidth - 10);
        _leftImageView.layer.cornerRadius=(LinerWidth - 10)/2;
        _leftImageView.layer.masksToBounds=YES;
        //[self.leftImageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.huabian.com/uploadfile/2014/0821/20140821101516903.jpg"]];
        
        [self addSubview:_leftImageView];
        
        _nameLab=[[UILabel alloc] init];
        float with = ViewX(_leftImageView)+ViewWidth(_leftImageView);
        _nameLab.frame=CGRectMake(with+10, ViewY(_leftImageView), 50, 20);
        _nameLab.textAlignment=NSTextAlignmentLeft;
        _nameLab.adjustsFontSizeToFitWidth = YES;
        _nameLab.numberOfLines = 0;
        _nameLab.font=[UIFont systemFontOfSize:15];
        [self addSubview:_nameLab];
        
        _gjCity=[[UILabel alloc] init];
        _gjCity.frame=CGRectMake(ViewX(_nameLab)+ViewWidth(_nameLab) , ViewY(_leftImageView), windowContentWidth-ViewX(_gjCity), 20);
        _gjCity.textAlignment=NSTextAlignmentLeft;
        _gjCity.font=[UIFont systemFontOfSize:13];
        _gjCity.textColor=[UIColor grayColor];
        [self addSubview:_gjCity];
        
        //性别和星座
        _sexView=[[UIView alloc] init];
        _sexView.frame=CGRectMake(ViewX(_nameLab), ViewY(_nameLab)+25, 30, 15);
        _sexView.layer.cornerRadius=2;
        [self addSubview:_sexView];
        
        _sexImageView=[[UIImageView alloc] init];
        _sexImageView.frame=CGRectMake(2, 3, 9, 9);
        [_sexView addSubview:_sexImageView];
        
        //年龄
        _ageLabe=[[UILabel alloc] init];
        _ageLabe.frame=CGRectMake(ViewWidth(_sexImageView), 0, ViewWidth(_sexView)-ViewWidth(_sexImageView), 15);
        _ageLabe.font=[UIFont systemFontOfSize:12];
        _ageLabe.textColor=[UIColor whiteColor];
        _ageLabe.textAlignment=1;
        [_sexView addSubview:_ageLabe];
        
        //星座图片
        _xingzuoImageView=[[UIImageView alloc] init];
        _xingzuoImageView.frame=CGRectMake(ViewX(_sexView)+ViewWidth(_sexView)+5, ViewY(_sexView), 30, 15);
        _xingzuoImageView.image=[UIImage imageNamed:@"星座.png"];
        _xingzuoImageView.layer.cornerRadius=2;
        [self addSubview:_xingzuoImageView];
        
        //星座
        _xingzuoLabe=[[UILabel alloc] init];
        _xingzuoLabe.frame=CGRectMake(1, 1, 28, 13);
        _xingzuoLabe.textColor=[UIColor whiteColor];
        _xingzuoLabe.font=[UIFont systemFontOfSize:11];
        _xingzuoLabe.textAlignment=1;
        [_xingzuoImageView addSubview:_xingzuoLabe];
        
        //提供方案
        _schemeLab=[[UILabel alloc] init];
        _schemeLab.frame=CGRectMake(ViewX(_nameLab), ViewY(_nameLab)+40, 80, 30);
        _schemeLab.font=[UIFont systemFontOfSize:13];
        _schemeLab.textColor=[UIColor grayColor];
        _schemeLab.text=@"已提供方案：";
        [self addSubview:_schemeLab];
        
        //提供方案数
        _schemeNumberLab=[[UILabel alloc] init];
        _schemeNumberLab.frame=CGRectMake(ViewX(_schemeLab)+ViewWidth(_schemeLab) - 10, ViewY(_schemeLab), 40, 30);
        _schemeNumberLab.font=[UIFont systemFontOfSize:15];
        _schemeNumberLab.textColor=kColor(255, 96, 126);
        [self addSubview:_schemeNumberLab];
        
        //评分
        _gradeLab=[[UILabel alloc] init];
        _gradeLab.frame=CGRectMake(ViewX(_schemeNumberLab)+ViewWidth(_schemeNumberLab) - 5, ViewY(_schemeLab), 50, 30);
        _gradeLab.textColor=[UIColor grayColor];
        _gradeLab.font=[UIFont systemFontOfSize:13];
        _gradeLab.text=@"评分：";
        [self addSubview:_gradeLab];
        
        //评分数
        _gradeNumberLab=[[UILabel alloc] init];
        _gradeNumberLab.frame=CGRectMake(ViewX(_gradeLab)+ViewWidth(_gradeLab) - 10, ViewY(_schemeLab), 25, 30);
        _gradeNumberLab.textColor=kColor(52, 167, 255);
        _gradeNumberLab.font=[UIFont systemFontOfSize:15];
        [self addSubview:_gradeNumberLab];
        
        //简介
        _infoLabe=[[UILabel alloc] init];
        _infoLabe.frame=CGRectMake(ViewX(_nameLab), ViewY(_schemeLab)+20, windowContentWidth-ViewX(_nameLab)-60, 40);
        _infoLabe.textColor=[UIColor grayColor];
        _infoLabe.numberOfLines=2;
        _infoLabe.font=[UIFont systemFontOfSize:13];
        //_infoLabe.text = @"拥有丰富的出境、亲子、度假策划经验，拥有丰富的出境、亲子、度假策划经验拥有丰富的出境、亲子、度假策划经验，拥有丰富的出境、亲子、度假策划经验";
        [self addSubview:_infoLabe];
        
       
        self.callButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.callButton.frame = CGRectMake(self.infoLabe.frame.origin.x + self.infoLabe.frame.size.width + 10, 10, 100, 95);
        _callButton.backgroundColor = [UIColor clearColor];
        //[self.callButton addTarget:self action:@selector(callSteward:) forControlEvents:UIControlEventTouchUpInside];
        
         UIImageView *callIcon = [[UIImageView alloc] initWithFrame:CGRectMake(self.infoLabe.frame.origin.x + self.infoLabe.frame.size.width + 20, 115 / 2 , 19, 20)];
        callIcon.image = [UIImage imageNamed:@"call@2x.png"];
        [self addSubview:callIcon];
        [self addSubview:_callButton];
        
        
    }
    
    return self;
}

//- (void)callSteward:(UIButton *)button
//{
//    NSLog(@"*******管家********%@", _item.nameStr);
//    NSString * telString = [NSString stringWithFormat:@"tel:%@",_item.phone];
//    NSURL * telUrl = [NSURL URLWithString:telString];
//    [[UIApplication sharedApplication] openURL:telUrl];
//    
//}

//-(void)setItem:(LXGuanJiaModel *)item
//{
//    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:item.leftImageUrl] placeholderImage:[UIImage imageNamed:@"默认图1"]];
//    _nameLab.text=item.nameStr;
//    _gjCity.text=item.gjCityStr;
//    _schemeNumberLab.text=[NSString stringWithFormat:@"%d",item.NuberStr];
//    _gradeNumberLab.text=item.gradeStr;
//    _infoLabe.text=item.infoStr;
//    if ([item.sex intValue]==0)
//    {
//        //女
//        _sexView.backgroundColor=kColor(250, 133, 133);
//        _sexImageView.image=[UIImage imageNamed:@"女性.png"];
//    }else
//    {
//        //男
//        _sexView.backgroundColor=kColor(103, 189, 255);
//        _sexImageView.image=[UIImage imageNamed:@"男性.png"];
//    }
//    _ageLabe.text=item.age;
//    _xingzuoLabe.text=item.xingzuo;
//    
//}
-(void)setItem:(LXGuanJiaModel *)item
{
    if (item.leftImageUrl == nil || [item.leftImageUrl isEqual:[NSNull null]])
    {
        [_leftImageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"默认图2"]];
    }
    else
    {
        [_leftImageView sd_setImageWithURL:[NSURL URLWithString:item.leftImageUrl] placeholderImage:[UIImage imageNamed:@"默认图2"]];
    }
    
    if (item.nameStr == nil || [item.nameStr isEqual:[NSNull null]])
    {
        
    }else
    {
        _nameLab.text=item.nameStr;
    }
    
    
    
    if (item.gjCityStr == nil || [item.gjCityStr isEqual:[NSNull null]])
    {
        _gjCity.hidden=YES;
    }else
    {
        _gjCity.text=item.gjCityStr;//管家所属
    }
    
    
    
    if (item.infoStr == nil || [item.infoStr isEqual:[NSNull null]])
    {
        
    }
    else
    {
        _infoLabe.text=item.infoStr;
    }
    
    
    if (item.sex == nil || [item.sex isEqual:[NSNull null]])
    {
        _sexView.hidden=YES;
        _sexImageView.hidden=YES;
        _ageLabe.hidden=YES;
    }
    else if ([item.sex intValue]==2)
    {
        //女
        _sexView.backgroundColor=kColor(250, 133, 133);
        _sexImageView.image=[UIImage imageNamed:@"女性.png"];
        if (item.age == nil || [item.age isEqual:[NSNull null]])
        {
            
        }else
        {
            _ageLabe.text=item.age;
        }
    }else if([item.sex intValue]==1)
    {
        //男
        _sexView.backgroundColor=kColor(103, 189, 255);
        _sexImageView.image=[UIImage imageNamed:@"男性.png"];
        if (item.age == nil || [item.age isEqual:[NSNull null]])
        {
            
        }else
        {
            _ageLabe.text=item.age;
        }
        
    }
    
    
    
    
    _schemeNumberLab.text=[NSString stringWithFormat:@"%d例",item.NuberStr];//案例
    
    
    
    _gradeNumberLab.text=item.gradeStr;//评分
    
    if (item.xingzuo == nil || [item.xingzuo isEqual:[NSNull null]])
    {
        _xingzuoLabe.hidden=YES;
        _xingzuoImageView.hidden=YES;
        
    }
    else
    {
        _xingzuoLabe.text=item.xingzuo;
    }
    
}
//赋值 and 自动换行,计算出cell的高度
-(void)setIntroductionText:(NSString*)text{
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
    _infoLabe.text = text;
    //设置label的最大行数
    _infoLabe.numberOfLines = 0;
    CGSize size = CGSizeMake(windowContentWidth-100, 1000);
    CGSize labelSize = [_infoLabe.text sizeWithFont:_infoLabe.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    
    
    _infoLabe.frame = CGRectMake(_infoLabe.frame.origin.x, ViewY(_schemeLab)+30, labelSize.width, labelSize.height);
    
    //计算出自适应的高度
    frame.size.height = labelSize.height+90;
    //NSLog(@"11--labelSize.width==%f.1",frame.size.height);
    self.frame = frame;
    
}
*/
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _leftImageView=[[UIImageView alloc] init];
        _leftImageView.frame=CGRectMake(10, 10, LinerWidth, LinerWidth);
        _leftImageView.layer.cornerRadius=LinerWidth/2;
        _leftImageView.layer.masksToBounds=YES;
        [self addSubview:_leftImageView];
        
        _nameLab=[[UILabel alloc] init];
        float with = ViewX(_leftImageView)+ViewWidth(_leftImageView);
        _nameLab.frame=CGRectMake(with+10, ViewY(_leftImageView), 50, 20);
        _nameLab.textAlignment=NSTextAlignmentLeft;
        _nameLab.adjustsFontSizeToFitWidth = YES;
        _nameLab.numberOfLines = 0;
        _nameLab.font=[UIFont systemFontOfSize:15];
        [self addSubview:_nameLab];
        
        _gjCity=[[UILabel alloc] init];
        _gjCity.frame=CGRectMake(ViewX(_nameLab)+ViewWidth(_nameLab) , ViewY(_leftImageView), windowContentWidth-ViewX(_gjCity), 20);
        _gjCity.textAlignment=NSTextAlignmentLeft;
        _gjCity.font=[UIFont systemFontOfSize:13];
        _gjCity.textColor=[UIColor grayColor];
        [self addSubview:_gjCity];
        
        //性别和星座
        _sexView=[[UIView alloc] init];
        _sexView.frame=CGRectMake(ViewX(_nameLab), ViewY(_nameLab)+25, 30, 15);
        _sexView.layer.cornerRadius=2;
        [self addSubview:_sexView];
        
        _sexImageView=[[UIImageView alloc] init];
        _sexImageView.frame=CGRectMake(2, 3, 9, 9);
        [_sexView addSubview:_sexImageView];
        
        //年龄
        _ageLabe=[[UILabel alloc] init];
        _ageLabe.frame=CGRectMake(ViewWidth(_sexImageView), 0, ViewWidth(_sexView)-ViewWidth(_sexImageView), 15);
        _ageLabe.font=[UIFont systemFontOfSize:12];
        _ageLabe.textColor=[UIColor whiteColor];
        _ageLabe.textAlignment=1;
        [_sexView addSubview:_ageLabe];
        
        //星座图片
        _xingzuoImageView=[[UIImageView alloc] init];
        _xingzuoImageView.frame=CGRectMake(ViewX(_sexView)+ViewWidth(_sexView)+5, ViewY(_sexView), 30, 15);
        _xingzuoImageView.image=[UIImage imageNamed:@"星座.png"];
        _xingzuoImageView.layer.cornerRadius=2;
        [self addSubview:_xingzuoImageView];
        
        //星座
        _xingzuoLabe=[[UILabel alloc] init];
        _xingzuoLabe.frame=CGRectMake(1, 1, 28, 13);
        _xingzuoLabe.textColor=[UIColor whiteColor];
        _xingzuoLabe.font=[UIFont systemFontOfSize:11];
        _xingzuoLabe.textAlignment=1;
        [_xingzuoImageView addSubview:_xingzuoLabe];
        
        //提供方案
        _schemeLab=[[UILabel alloc] init];
        _schemeLab.frame=CGRectMake(ViewX(_nameLab), ViewY(_nameLab)+40, 80, 30);
        _schemeLab.font=[UIFont systemFontOfSize:13];
        _schemeLab.textColor=[UIColor grayColor];
        _schemeLab.text=@"已提供方案：";
        [self addSubview:_schemeLab];
        
        //提供方案数
        _schemeNumberLab=[[UILabel alloc] init];
        _schemeNumberLab.frame=CGRectMake(ViewX(_schemeLab)+ViewWidth(_schemeLab), ViewY(_schemeLab), 50, 30);
        _schemeNumberLab.font=[UIFont systemFontOfSize:15];
        _schemeNumberLab.textColor=kColor(255, 96, 126);
        [self addSubview:_schemeNumberLab];
        
        //评分
        _gradeLab=[[UILabel alloc] init];
        _gradeLab.frame=CGRectMake(ViewX(_schemeNumberLab)+ViewWidth(_schemeNumberLab), ViewY(_schemeLab), 70, 30);
        _gradeLab.textColor=[UIColor grayColor];
        _gradeLab.font=[UIFont systemFontOfSize:13];
        _gradeLab.text=@"综合评分：";
        [self addSubview:_gradeLab];
        
        //评分数
        _gradeNumberLab=[[UILabel alloc] init];
        _gradeNumberLab.frame=CGRectMake(ViewX(_gradeLab)+ViewWidth(_gradeLab), ViewY(_schemeLab), 30, 30);
        _gradeNumberLab.textColor=kColor(52, 167, 255);
        _gradeNumberLab.font=[UIFont systemFontOfSize:15];
        [self addSubview:_gradeNumberLab];
        
        //简介
        _infoLabe=[[UILabel alloc] init];
        _infoLabe.frame=CGRectMake(ViewX(_nameLab), ViewY(_schemeLab)+30, windowContentWidth-ViewX(_nameLab)-10, 30);
        _infoLabe.textColor=[UIColor grayColor];
        _infoLabe.font=[UIFont systemFontOfSize:13];
        [self addSubview:_infoLabe];
        
        
    }
    
    return self;
}


-(void)setItem:(LXGuanJiaModel *)item
{
    if (item.leftImageUrl == nil || [item.leftImageUrl isEqual:[NSNull null]])
    {
        [_leftImageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"默认图2"]];
    }
    else
    {
        [_leftImageView sd_setImageWithURL:[NSURL URLWithString:item.leftImageUrl] placeholderImage:[UIImage imageNamed:@"默认图2"]];
    }
    
    if (item.nameStr == nil || [item.nameStr isEqual:[NSNull null]])
    {
        
    }else
    {
        _nameLab.text=item.nameStr;
    }
    
    
    
    if (item.gjCityStr == nil || [item.gjCityStr isEqual:[NSNull null]])
    {
        _gjCity.hidden=YES;
    }else
    {
        _gjCity.text=item.gjCityStr;//管家所属
    }
    
    
    
    if (item.infoStr == nil || [item.infoStr isEqual:[NSNull null]])
    {
        
    }
    else
    {
        _infoLabe.text=item.infoStr;
    }
    
    
    if (item.sex == nil || [item.sex isEqual:[NSNull null]])
    {
        _sexView.hidden=YES;
        _sexImageView.hidden=YES;
        _ageLabe.hidden=YES;
    }
    else if ([item.sex intValue]==2)
    {
        //女
        _sexView.backgroundColor=kColor(250, 133, 133);
        _sexImageView.image=[UIImage imageNamed:@"女性.png"];
        if (item.age == nil || [item.age isEqual:[NSNull null]])
        {
            
        }else
        {
            _ageLabe.text=item.age;
        }
    }else if([item.sex intValue]==1)
    {
        //男
        _sexView.backgroundColor=kColor(103, 189, 255);
        _sexImageView.image=[UIImage imageNamed:@"男性.png"];
        if (item.age == nil || [item.age isEqual:[NSNull null]])
        {
            
        }else
        {
            _ageLabe.text=item.age;
        }
        
    }
    
    
    
    
    _schemeNumberLab.text=[NSString stringWithFormat:@"%d例",item.NuberStr];//案例
    
    
    
    _gradeNumberLab.text=item.gradeStr;//评分
    
    if (item.xingzuo == nil || [item.xingzuo isEqual:[NSNull null]])
    {
        _xingzuoLabe.hidden=YES;
        _xingzuoImageView.hidden=YES;
        
    }
    else
    {
        _xingzuoLabe.text=item.xingzuo;
    }
    
}


- (void)returnTextCGRectText:(NSString *)str textFont:(CGFloat)font
{
    if (str == nil || [str isEqual:[NSNull null]])
    {
        //DLog(@"dsdsad");
        CGRect frame = [self frame];
        frame.size.height = 90;
        self.frame=frame;
    }
    else
    {
        CGRect frame = [self frame];
        _infoLabe.numberOfLines = 0;
        NSDictionary * textDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil];
        CGRect rect = [str boundingRectWithSize:CGSizeMake(windowContentWidth - 100, 50) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
        DLog(@"height=%f,lines=%ld，%@",rect.size.height,(long)_infoLabe.numberOfLines,str);
        
        _infoLabe.frame = CGRectMake(_infoLabe.frame.origin.x, ViewY(_schemeLab)+30, rect.size.width, rect.size.height);
        frame.size.height = rect.size.height+90;
        
        self.frame=frame;
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
