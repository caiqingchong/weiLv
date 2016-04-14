//
//  ZFJSteShopMsgCell.m
//  WelLv
//
//  Created by WeiLv on 15/10/24.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJSteShopMsgCell.h"
#import "ZFJSteShopMsgModel.h"

@implementation ZFJSteShopMsgCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self customView];
    }
    return self;
}
- (void)customView {
    self.timeLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, windowContentWidth - 10, 20)];
    self.timeLab.textColor = UIColorFromRGB(0x6f7278);
    self.timeLab.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_timeLab];
    
    self.msgLab = [[UILabel alloc] initWithFrame:CGRectMake(10, ViewBelow(_timeLab), windowContentWidth - 10, 40)];
    self.msgLab.textColor = UIColorFromRGB(0x6f7278);
    self.msgLab.font = [UIFont systemFontOfSize:15];
    //self.msgLab.adjustsFontSizeToFitWidth = YES;
    self.msgLab.numberOfLines = 0;
    [self.contentView addSubview:_msgLab];
    
}
- (UIButton *)agreeBut {
    if (!_agreeBut) {
        self.msgLab.frame = CGRectMake(10, ViewBelow(_timeLab), windowContentWidth - 140 - 10, 40);
        self.agreeBut = [UIButton buttonWithType:UIButtonTypeCustom];
        self.agreeBut.frame = CGRectMake(windowContentWidth - 140, 25, 60, 30);
        self.agreeBut.backgroundColor = TimeGreenColor;
        self.agreeBut.layer.cornerRadius = 3.0;
        self.agreeBut.layer.masksToBounds = YES;
        [self.agreeBut setTitle:@"同意" forState:UIControlStateNormal];
        //self.agreeBut.titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_agreeBut];
    }
    return _agreeBut;
}
- (UIButton *)rejectBut {
    
    if (!_rejectBut) {
        self.msgLab.frame = CGRectMake(10, ViewBelow(_timeLab), windowContentWidth - 140 - 10, 40);
        self.rejectBut = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rejectBut.frame = CGRectMake(windowContentWidth - 70, 25, 60, 30);
        self.rejectBut.backgroundColor = [UIColor whiteColor];
        [self.rejectBut setTitle:@"拒绝" forState:UIControlStateNormal];
        [self.rejectBut setTitleColor:TimeGreenColor forState:UIControlStateNormal];
        self.rejectBut.layer.cornerRadius = 3.0;
        self.rejectBut.layer.masksToBounds = YES;
        self.rejectBut.layer.borderWidth = 0.5;
        self.rejectBut.layer.borderColor = TimeGreenColor.CGColor;
        [self.contentView addSubview:_rejectBut];
    }
    return _rejectBut;
}
- (UILabel *)tagLab {
    if (!_tagLab) {
      //  self.msgLab.frame = CGRectMake(10, ViewBelow(_timeLab),windowContentWidth  * 3 / 4.0 - 10, 40);
        self.tagLab = [[UILabel alloc] initWithFrame:CGRectMake(windowContentWidth * 3 / 4.0 , 0, windowContentWidth / 4.0, 60)];
        self.tagLab.textAlignment = NSTextAlignmentCenter;
        self.tagLab.textColor = [UIColor blackColor];
        [self.contentView addSubview:_tagLab];
    }
    return _tagLab;
}
- (void)setModelMsg:(ZFJSteShopMsgModel *)modelMsg {
    
    NSString * timeStr = @"";
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    timeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[modelMsg.update_time integerValue]]];
    self.timeLab.text = timeStr;
    if ([self judgeString:modelMsg.realname]) {
        
        self.msgLab.text = [NSString stringWithFormat:@"%@申请成为合伙人", modelMsg.realname];
    }else {
        
        self.msgLab.text = [NSString stringWithFormat:@"%@申请成为合伙人", [self judgeReturnString:modelMsg.username withReplaceString:@""]];
    }
     //管家删除合伙人
    if ([modelMsg.sign isEqualToString:@"4"]) {
        // 如果_realname == nil  的话  取值-->self.msgLab.text = 他的userNmae
        if ([self judgeString:modelMsg.realname]) {
             self.msgLab.text = [NSString stringWithFormat:@"您已经取消%@的合伙人资格",[NSString stringWithFormat:@"%@",modelMsg.realname]];
        }else
        {
            self.msgLab.text = [NSString stringWithFormat:@"您已经取消%@的合伙人资格",[NSString stringWithFormat:@"%@",modelMsg.username]];
        }
        
    }else if ([modelMsg.sign isEqualToString:@"5"])
    {  //合伙人取消合伙人资格
         if ([self judgeString:modelMsg.realname]) {
             // 如果_realname == nil  的话  取值-->self.msgLab.text = 他的userNmae
             self.msgLab.text = [NSString stringWithFormat:@"%@ 合伙,自己取消了合伙人资格",[NSString stringWithFormat:@"%@",modelMsg.realname]];

         }else
         {
             self.msgLab.text = [NSString stringWithFormat:@"%@ 合伙,自己取消了合伙人资格",[NSString stringWithFormat:@"%@",modelMsg.username]];

         }
    
    }
   
}
@end







