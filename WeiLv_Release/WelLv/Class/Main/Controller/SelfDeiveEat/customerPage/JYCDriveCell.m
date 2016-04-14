//
//  JYCDriveCell1.m
//  WelLv
//
//  Created by lyx on 15/11/2.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "JYCDriveCell.h"
#import "DriveModel.h"
@implementation JYCDriveCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    CGFloat padding = 10.0;
    CGRect frame=CGRectMake(padding, padding, 80, 80);
    self.iconImageView=[[UIImageView alloc]initWithFrame:frame];
    [self addSubview:self.iconImageView];
    self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(self.iconImageView)+7, padding, windowContentWidth-100, 20)];
    self.nameLabel.font=[UIFont systemFontOfSize:18];
    self.nameLabel.textColor=[UIColor blackColor];
    [self addSubview:self.nameLabel];
    self.saleLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewX(self.nameLabel), ViewBelow(self.nameLabel)+20, 70, 12)];
    self.saleLabel.font=[UIFont systemFontOfSize:12];
    self.saleLabel.textColor=[UIColor orangeColor];
    [self addSubview:self.saleLabel];
    self.distanceImageView=[[UIImageView alloc]initWithFrame:CGRectMake(windowContentWidth-72, ViewY(self.saleLabel), 12, 14)];
    self.distanceImageView.image=[UIImage imageNamed:@"location公里"];
    [self addSubview:self.distanceImageView];
    self.distanceLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(self.distanceImageView)+5, ViewY(self.saleLabel), 50, 12)];
    self.distanceLabel.font=[UIFont systemFontOfSize:10];
    self.distanceLabel.textColor=[UIColor grayColor];
    [self addSubview:self.distanceLabel];
    self.commentImageView=[[UIImageView alloc]initWithFrame:CGRectMake(ViewX(self.nameLabel), ViewBelow(self.saleLabel)+10, 18, 18)];
    self.commentImageView.image=[UIImage imageNamed:@"好评"];
    [self addSubview:self.commentImageView];
    self.commentLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(self.commentImageView)+5, ViewY(self.commentImageView)+6, 60, 12)];
    self.commentLabel.font=[UIFont systemFontOfSize:10];
    self.commentLabel.textColor=[UIColor redColor];
    [self addSubview:self.commentLabel];
   // self.tuiDanBtn=[[UIButton alloc]initWithFrame:CGRectMake(ViewX(self.nameLabel), ViewBelow(self.commentImageView)+10, 75, 17)];
   // [self.tuiDanBtn setBackgroundImage:[UIImage imageNamed:@"支付免费退单"] forState:UIControlStateNormal];
  //  [self.tuiDanBtn setTitle:@"支持免费退单" forState:UIControlStateNormal];
   // self.tuiDanBtn.titleLabel.font=[UIFont systemFontOfSize:12];
   // [self.tuiDanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   // [self addSubview:self.tuiDanBtn];
   // self.yuYueBtn=[[UIButton alloc]initWithFrame:CGRectMake(ViewRight(self.tuiDanBtn)+5, ViewBelow(self.commentImageView)+10, 40, 17)];
   // [self.yuYueBtn setBackgroundImage:[UIImage imageNamed:@"免预约"] forState:UIControlStateNormal];
    //[self.yuYueBtn setTitle:@"免预约" forState:UIControlStateNormal];
    //self.yuYueBtn.titleLabel.font=[UIFont systemFontOfSize:12];
  //  [self.yuYueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   // [self addSubview:self.yuYueBtn];
   // UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(ViewX(self.nameLabel), ViewBelow(self.yuYueBtn)+5, windowContentWidth-ViewX(self.nameLabel), 1)];
   // lineView.backgroundColor=bordColor;
  //  [self addSubview:lineView];
    self.frame = CGRectMake(0, 0, windowContentWidth, 90);
    return self;
}

//- (void)setArr:(NSArray *)arr {
//   
//    for (int i=0; i< arr.count; i++) {
//        
//        
//        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(ViewX(self.nameLabel), 90+5, windowContentWidth-ViewX(self.nameLabel), 1)];
//         lineView.backgroundColor=bordColor;
//          [self addSubview:lineView];
//        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(ViewX(self.nameLabel), i*(15+10)+100, 15, 15)];
//        //NSLog(@"%@",self.arr);
//        NSString * str = [arr objectAtIndex:i];
//        imageView.image=[UIImage imageNamed:str];
//        [self addSubview:imageView];
//        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(imageView)+7, i*(15+10)+100, 120, 15)];
//        label.font=[UIFont systemFontOfSize:10];
//        label.textColor=[UIColor grayColor];
//        [self addSubview:label];
//        
//    }
//   
//    UIView *botomView=[[UIView alloc]initWithFrame:CGRectMake(0, 25  * arr.count + 100-10+5, windowContentWidth, 10)];
//    botomView.backgroundColor=[UIColor colorWithRed:221 /255.0 green:230/255.0 blue:235/255.0 alpha:1.0];
//    [self addSubview:botomView];
//    self.frame = CGRectMake(0, 0, windowContentWidth, 25 * arr.count + 100+5);
//}
-(void)setModel:(DriveModel *)model
{
    //判断满，评，进，送 应该如何显示
    if ([model.deduct intValue]==0&&[model.appointment intValue]==0) {
         self.tuiDanBtn=[[UIButton alloc]initWithFrame:CGRectMake(ViewX(self.nameLabel), ViewBelow(self.commentImageView)+10, 75, 17)];
         [self.tuiDanBtn setBackgroundImage:[UIImage imageNamed:@"支付免费退单"] forState:UIControlStateNormal];
          [self.tuiDanBtn setTitle:@"支持免费退单" forState:UIControlStateNormal];
         self.tuiDanBtn.titleLabel.font=[UIFont systemFontOfSize:12];
         [self.tuiDanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         [self addSubview:self.tuiDanBtn];
         self.yuYueBtn=[[UIButton alloc]initWithFrame:CGRectMake(ViewRight(self.tuiDanBtn)+5, ViewBelow(self.commentImageView)+10, 40, 17)];
         [self.yuYueBtn setBackgroundImage:[UIImage imageNamed:@"免预约"] forState:UIControlStateNormal];
        [self.yuYueBtn setTitle:@"免预约" forState:UIControlStateNormal];
        self.yuYueBtn.titleLabel.font=[UIFont systemFontOfSize:12];
        [self.yuYueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         [self addSubview:self.yuYueBtn];
      
        self.lineView=[[UIView alloc]initWithFrame:CGRectMake(ViewX(self.nameLabel), ViewBelow(self.tuiDanBtn)+5, windowContentWidth-ViewX(self.nameLabel), 1)];
        self.lineView.backgroundColor=bordColor;
        [self addSubview:self.lineView];
     
    }else if([model.deduct intValue]==0&&[model.appointment intValue]!=0)
    {
        self.tuiDanBtn=[[UIButton alloc]initWithFrame:CGRectMake(ViewX(self.nameLabel), ViewBelow(self.commentImageView)+10, 75, 17)];
        [self.tuiDanBtn setBackgroundImage:[UIImage imageNamed:@"支付免费退单"] forState:UIControlStateNormal];
        [self.tuiDanBtn setTitle:@"支持免费退单" forState:UIControlStateNormal];
        self.tuiDanBtn.titleLabel.font=[UIFont systemFontOfSize:12];
        [self.tuiDanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:self.tuiDanBtn];
        
       
        self.lineView=[[UIView alloc]initWithFrame:CGRectMake(ViewX(self.nameLabel), ViewBelow(self.tuiDanBtn)+5, windowContentWidth-ViewX(self.nameLabel), 1)];
        self.lineView.backgroundColor=bordColor;
        [self addSubview:self.lineView];
   
    }else if([model.deduct intValue]!=0&&[model.appointment intValue]==0)
    {
        self.yuYueBtn=[[UIButton alloc]initWithFrame:CGRectMake(ViewX(self.nameLabel), ViewBelow(self.commentImageView)+10, 40, 17)];
        [self.yuYueBtn setBackgroundImage:[UIImage imageNamed:@"免预约"] forState:UIControlStateNormal];
        [self.yuYueBtn setTitle:@"免预约" forState:UIControlStateNormal];
        self.yuYueBtn.titleLabel.font=[UIFont systemFontOfSize:12];
        [self.yuYueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:self.yuYueBtn];
     
       self.lineView=[[UIView alloc]initWithFrame:CGRectMake(ViewX(self.nameLabel), ViewBelow(self.yuYueBtn)+5, windowContentWidth-ViewX(self.nameLabel), 1)];
        self.lineView.backgroundColor=bordColor;
        [self addSubview:self.lineView];
      
    }else if([model.deduct intValue]!=0&&[model.appointment intValue]!=0)
    {
      self.lineView=[[UIView alloc]initWithFrame:CGRectMake(ViewX(self.nameLabel), ViewBelow(self.commentImageView)+5, windowContentWidth-ViewX(self.nameLabel), 1)];
        self.lineView.backgroundColor=bordColor;
        [self addSubview:self.lineView];
    
    }
    
    for (int i=0; i< model.offline_infoArr.count; i++) {
        
        //NSLog(@"----%d+++++",model.offline_infoArr.count);
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(ViewX(self.nameLabel), i*(15+10)+ViewBelow(self.lineView)+5, 15, 15)];
        //NSLog(@"%@",self.arr);
        offline_infoModel *mod=[[offline_infoModel alloc]init];
        mod=model.offline_infoArr[i];
    
        NSString * str;
        
        if ([mod.type intValue]==1) {
            str=@"满";
        }if ([mod.type intValue]==2) {
            str=@"评";
        }if ([mod.type intValue]==3) {
            str=@"进";
        }if ([mod.type intValue]==4) {
            str=@"送";
        }
        
        imageView.image=[UIImage imageNamed:str];
        [self addSubview:imageView];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(imageView)+7, i*(15+10)+ViewBelow(self.lineView)+5, 180, 15)];
        label.font=[UIFont systemFontOfSize:10];
        label.textColor=[UIColor grayColor];
        label.text=[NSString stringWithFormat:@"%@",mod.info];
        [self addSubview:label];
        
    }
    UIView *botomView=[[UIView alloc]initWithFrame:CGRectMake(0, 25  * model.offline_infoArr.count + ViewBelow(self.lineView)-1, windowContentWidth, 10)];
    botomView.backgroundColor=[UIColor colorWithRed:221 /255.0 green:230/255.0 blue:235/255.0 alpha:1.0];
    [self addSubview:botomView];
    self.frame = CGRectMake(0, 0, windowContentWidth, 25 * model.offline_infoArr.count + ViewBelow(self.lineView)+5);
    NSString *str=[NSString stringWithFormat:@"%@/%@",WLHTTP,model.logo];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"默认图3"]];
    self.nameLabel.text=model.partner_shop_name;
    self.distanceLabel.text=[NSString stringWithFormat:@"%0.1f公里",[model.distance floatValue]/1000];
    self.saleLabel.text=[NSString stringWithFormat:@"月售%@单",model.mon_sales];
    
    
    self.commentLabel.text=[NSString stringWithFormat:@"%@%@好评",model.appraise,@"%"];
}
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//    self.lineView.backgroundColor=bordColor;
//    // Configure the view for the selected state
//}
//- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
//{
//    [super setHighlighted:highlighted animated:animated];
//    self.lineView.backgroundColor = bordColor;
//}
@end
