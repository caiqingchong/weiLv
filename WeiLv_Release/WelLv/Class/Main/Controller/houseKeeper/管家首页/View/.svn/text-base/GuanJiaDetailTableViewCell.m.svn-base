//
//  GuanJiaDetailTableViewCell.m
//  WelLv
//
//  Created by daihengbin on 16/1/14.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "GuanJiaDetailTableViewCell.h"

@implementation GuanJiaDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;

}
//320x568 375x667 414x736
-(void)createView{
    _productTypelabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 50, 20)];
    _productTypelabel.font = [UIFont systemFontOfSize:12.f];
    _productTypelabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_productTypelabel];
    
    
    UIView *line1=[[UIView alloc] initWithFrame:CGRectMake(ViewRight(_productTypelabel)+5,_productTypelabel.top + 2.5 , 1 , 15)];
    line1.backgroundColor=[UIColor blackColor];
    
    [self.contentView addSubview:line1];
    
    _leaveTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(ViewRight(line1)+5, 5,windowContentWidth- line1.right -85 , 20)];
    _leaveTimeLabel.font = [UIFont systemFontOfSize:12.f];
    _leaveTimeLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_leaveTimeLabel];
    
    
    
    UIView *line2=[[UIView alloc] initWithFrame:CGRectMake(0, _leaveTimeLabel.bottom + 5, windowContentWidth, 0.5)];
    line2.backgroundColor=TableLineColor;
    [self.contentView addSubview:line2];
  
    
    _image = [[UIImageView alloc]initWithFrame:CGRectMake(20,ViewBelow(line2)+10 , 80, 80)];
    _image.backgroundColor = [UIColor yellowColor];
    _image.layer.cornerRadius = 0.5;
    [self.contentView addSubview:_image];
    
    
    _productNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(ViewRight(_image)+10, _image.top, windowContentWidth-_image.right-30, 40)];
    _productNameLabel.font = [UIFont systemFontOfSize:16.f];
    _productNameLabel.textAlignment = NSTextAlignmentLeft;
    _productNameLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_productNameLabel];
    
    _telLabel = [[UILabel alloc]initWithFrame:CGRectMake(ViewRight(_image)+10, ViewBelow(_image)-15, 200, 15)];
    
    _telLabel.font = [UIFont systemFontOfSize:12.f];
    _telLabel.textAlignment = NSTextAlignmentLeft;
    _telLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_telLabel];
    
    _singleMemberLabel = [[UILabel alloc]initWithFrame:CGRectMake(ViewRight(_image)+10,_telLabel.top - 15, 300, 15)];
    _singleMemberLabel.font = [UIFont systemFontOfSize:12.f];
    _singleMemberLabel.textAlignment = NSTextAlignmentLeft;
    _singleMemberLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_singleMemberLabel];
    
    
}
-(void)setServiceRecordModel:(service_recordModel *)serviceRecordModel{
    _productTypelabel.text = serviceRecordModel.category_name;
    if (_serviceRecordModel.setoff_time == nil) {
        _leaveTimeLabel.text = @"出发时间:未知";
    }else{
    NSTimeInterval time = [serviceRecordModel.setoff_time doubleValue];
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:time];
   
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
   
   NSString *setOffTime = [formatter stringFromDate:date1];
    _leaveTimeLabel.text = [NSString stringWithFormat:@"出发时间:%@",setOffTime];
    }
    
    
    [_image sd_setImageWithURL:[NSURL URLWithString:serviceRecordModel.img] placeholderImage:[UIImage imageNamed:@"默认图1"]];
    _productNameLabel.numberOfLines = 0;
    _productNameLabel.text = serviceRecordModel.product_name;
   NSString *string1 = [serviceRecordModel.username substringToIndex:2];
    //NSString *string2 = [serviceRecordModel.username substringFromIndex:];
    _singleMemberLabel.text = [NSString stringWithFormat:@"下单会员:%@xxx",string1];
    //没有登录或 管家登录状态下，隐藏手机号中间四位数字
    NSString *mobile =[serviceRecordModel.phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    _telLabel.text = [NSString stringWithFormat:@"电话:%@",mobile];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
