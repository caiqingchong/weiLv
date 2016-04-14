//
//  CSHShopCell.m
//  WelLv
//
//  Created by mac for csh on 15/11/20.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "CSHShopCell.h"
#import "CSHShopModel.h"
#define cellHeight 95
#define LinerWidth 75

@implementation CSHShopCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        //左侧图片
        _leftImageView=[[UIImageView alloc] init];
        _leftImageView.frame=CGRectMake(10,10, LinerWidth, LinerWidth);
        _leftImageView.layer.masksToBounds = YES;
        _leftImageView.layer.cornerRadius = 3.5; //设置图片圆角的尺度
        [self addSubview:_leftImageView];
        
        //标题
        _shordNameLab =[[UILabel alloc] init];
        float with = ViewX(_leftImageView)+ViewWidth(_leftImageView);
        _shordNameLab.frame=CGRectMake(with+10, ViewY(_leftImageView), windowContentWidth-with-20, 40);
        _shordNameLab.textAlignment=NSTextAlignmentLeft;
        _shordNameLab.adjustsFontSizeToFitWidth = YES;
        _shordNameLab.font=[UIFont systemFontOfSize:16];
        _shordNameLab.numberOfLines = 0;
        [self addSubview:_shordNameLab];
        
        //手机号
        _mainPhoneLab =[[UILabel alloc] init];
        _mainPhoneLab.frame=CGRectMake(with+10, ViewY(_leftImageView)+ViewHeight(_leftImageView) -20, windowContentWidth-with-20, 20);
        _mainPhoneLab.textAlignment=NSTextAlignmentLeft;
        _mainPhoneLab.font=[UIFont systemFontOfSize:13];
        _mainPhoneLab.textColor = [UIColor grayColor];
        [self addSubview:_mainPhoneLab];
        
        //审核状态
        _statusLab =[[UILabel alloc] init];
        _statusLab.frame=CGRectMake(windowContentWidth -10 - 60, ViewY(_leftImageView)/2+ViewHeight(_leftImageView)/2 -30/2, 60, 30);
        _statusLab.textAlignment=NSTextAlignmentLeft;
        _statusLab.font=[UIFont systemFontOfSize:15];
        _statusLab.textColor = [UIColor grayColor];
        [self addSubview:_statusLab];
        
        float radius = 4;
        _statusView = [[UIView alloc] init];
        _statusView.frame=CGRectMake(ViewX(_statusLab) -radius*2 -5,ViewY(_leftImageView)/2+ViewHeight(_leftImageView)/2-radius, radius*2, radius*2);
         _statusView.backgroundColor = [UIColor redColor];
        _statusView.layer.cornerRadius = radius; //设置图片圆角的尺度
        [self addSubview:_statusView];
}
    
    return self;
}


-(void)setItem:(CSHShopModel *)item
{
    NSLog(@"%@",[self GetImageUrLStringWithString:item.logo]);
    //if (!(item.logo ==nil || [item.logo isEqualToString:@""])) {
        [_leftImageView sd_setImageWithURL:[NSURL URLWithString:[self GetImageUrLStringWithString:item.logo]] placeholderImage:[UIImage imageNamed:@"默认图1"]];
  //  }
    
    if (!(item.partner_shop_name ==nil || [item.partner_shop_name isEqualToString:@""])) {
        _shordNameLab.text =item.partner_shop_name;
    }
    
    if (!(item.main_phone ==nil || [item.main_phone isEqualToString:@""])) {
        _mainPhoneLab.text = item.main_phone;
    }
    
    if (!(item.status ==nil || [item.status isEqualToString:@""])) {
        if ([item.status integerValue] == 0) {
            _statusView.hidden = NO;
            _statusLab.text = @"待审核";
        }else{
            _statusView.hidden = YES;
            _statusLab.text = @"";
        }
    }
}


-(NSString *)GetImageUrLStringWithString:(NSString *)string{
    NSString *newStr;
    if ([string hasPrefix:@"http://"] || [string hasPrefix:@"https://"]) {
        newStr = string;
    }else{
        newStr = [WLHTTP stringByAppendingString:[NSString stringWithFormat:@"/%@",[self judgeReturnString:string withReplaceString:@""]]];
    }
    
    return newStr;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
