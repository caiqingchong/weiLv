//
//  JYCselfEatCell.m
//  WelLv
//
//  Created by lyx on 15/11/28.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "JYCselfEatCell.h"

@implementation JYCselfEatCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    self.view=[[UIView alloc]initWithFrame:CGRectMake(0, 10, windowContentWidth,194-10)];
    self.view.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.view];
    
    
    
    CGFloat padding = 10.0;
    self.snLabel=[[UILabel alloc]initWithFrame:CGRectMake(padding, 0, 200, 27)];
    self.snLabel.textColor=[UIColor grayColor];
    self.snLabel.font=systemFont(11);
    [self.view addSubview:self.snLabel];
    self.statusLable=[[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth-10-100, 0, 100, 27)];
    [self.view addSubview:self.statusLable];
    self.statusLable.textAlignment=2;
    self.statusLable.textColor=[UIColor grayColor];
    self.statusLable.font=systemFont(11);
    //self.statusLable.text=@"商家已接单";
    UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(0, ViewBelow(self.snLabel)-1, windowContentWidth, 0.5)];
    line.backgroundColor=bordColor;
    [self.view addSubview:line];
    self.shopNameLable=[[UILabel alloc]initWithFrame:CGRectMake(10, ViewBelow(line)+7, 200, 16)];
    self.shopNameLable.textColor=[UIColor blackColor];
    self.shopNameLable.font=systemFont(16);
    [self.view addSubview:self.shopNameLable];
    
    
    self.timeLable=[[UILabel alloc]initWithFrame:CGRectMake(padding,ViewBelow(self.shopNameLable)+6 , 200, 11)];
    [self.view addSubview:self.timeLable];
    self.timeLable.textColor=[UIColor grayColor];
    self.timeLable.font=systemFont(11);
    self.priceLable=[[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth-10-15-150, ViewBelow(line)+16, 150, 15)];
    self.priceLable.textColor=[UIColor colorWithRed:253/255.0 green:109/255.0 blue:42/255.0 alpha:1];
    self.priceLable.textAlignment=2;
    self.priceLable.font=systemFont(15);
    [self.view addSubview:self.priceLable];
    self.rightImage=[[UIImageView alloc]initWithFrame:CGRectMake(windowContentWidth-10-10, ViewBelow(line)+15, 10, 17)];
    self.rightImage.image=[UIImage imageNamed:@"矩形-32-副本-15"];
    [self.view addSubview:self.rightImage];
    self.line2=[[UILabel alloc]initWithFrame:CGRectMake(0, ViewBelow(line)+47, windowContentWidth, 0.5)];
    self.line2.backgroundColor=bordColor;
    [self.view addSubview:self.line2];
    self.scrollow=[[UIScrollView alloc]initWithFrame:CGRectMake(0, ViewBelow(self.line2), windowContentWidth, 82)];
    self.scrollow.hidden=YES;
    [self.view addSubview:self.scrollow];
    
    self.iconImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, ViewBelow(self.line2)+10, 62, 62)];
    self.iconImage.clipsToBounds=YES;
    self.iconImage.layer.cornerRadius=8;
    [self.view addSubview:self.iconImage];
    self.nameLable=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(self.iconImage)+20, ViewY(self.line2)+14, 200, 13.5)];
    //self.nameLable.text=@"XXXXXXXX";
    self.nameLable.textColor=[UIColor grayColor];
    self.nameLable.font=systemFont(13.5);
    [self.view addSubview:self.nameLable];
    self.priceLable2=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(self.iconImage)+20, ViewBelow(self.nameLable)+10, 200, 11)];
    self.priceLable2.textColor=[UIColor colorWithRed:253/255.0 green:109/255.0 blue:42/255.0 alpha:1];
    self.priceLable2.font=systemFont(11);
    [self.view addSubview:self.priceLable2];
    self.numLable=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(self.iconImage)+20, ViewBelow(self.priceLable2)+8.5, 200, 11)];
    self.numLable.textColor=[UIColor grayColor];
    self.numLable.font=systemFont(11);
    [self.view addSubview:self.numLable];
    UILabel *line3=[[UILabel alloc]initWithFrame:CGRectMake(0, ViewBelow(self.line2)+82, windowContentWidth, 0.5)];
    line3.backgroundColor=bordColor;
    [self.view addSubview:line3];
    
    self.contactLable=[[UILabel alloc]initWithFrame:CGRectMake(10, ViewBelow(line3),50, 27)];
  //  self.contactLable.text=@"联系人：guolisha";
    self.contactLable.textColor=[UIColor grayColor];
    self.contactLable.font=systemFont(11);
    [self.view addSubview:self.contactLable];
    self.telLable=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(self.contactLable)+3, ViewBelow(line3), 150, 27)];
    self.telLable.textColor=[UIColor grayColor];
    self.telLable.font=systemFont(11);
    //self.telLable.text=@"电话:13838184917";
    [self.view addSubview:self.telLable];
    
    return self;
}

-(void)setModel:(JYCselfEatOrderModel *)model
{
   
    self.snLabel.text=[NSString stringWithFormat:@"订单编号:%@",model.sn];
   self.statusLable.text=[NSString stringWithFormat:@"%@",[self returnStrWithStatus:model.order_status]];
    self.shopNameLable.text=[NSString stringWithFormat:@"%@",model.partner_shop_name];
    self.timeLable.text=[NSString stringWithFormat:@"预定日期:%@",[self returnStrFromSeconds:[model.come_time floatValue]]];
    self.contactLable.text=[NSString stringWithFormat:@"%@:",model.contacts];
    self.telLable.text=[NSString stringWithFormat:@"%@",model.phone];
    if (model.productArr.count==1) {
        self.scrollow.hidden=YES;
        self.iconImage.hidden=NO;
        self.nameLable.hidden=NO;
        self.priceLable2.hidden=NO;
        self.numLable.hidden=NO;
        self.priceLable.hidden=YES;
        
        self.nameLable.text=[NSString stringWithFormat:@"%@",model.describe];
        
        self.priceLable.hidden=YES;
        self.priceLable2.text=[NSString stringWithFormat:@"￥%@",model.price];
        NSString *str=[NSString stringWithFormat:@"%@/%@",WLHTTP,model.logo];
        //NSLog(@"%@",model.src);
      
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"默认图3"]];
        pdModel *mod=[[pdModel alloc]init];
        mod=model.productArr[0];
        
        self.numLable.text=[NSString stringWithFormat:@"人数:%@",mod.nums];
    }else if(model.productArr.count>1)
    {
    
        self.scrollow.hidden=NO;
        for (UIView *view in [self.scrollow subviews]) {
            [view removeFromSuperview];
        }
        //[self.scrollow subviews]
        self.iconImage.hidden=YES;
        self.nameLable.hidden=YES;
        self.priceLable2.hidden=YES;
        self.numLable.hidden=YES;
        self.priceLable.hidden=NO;
        self.priceLable.text=[NSString stringWithFormat:@"￥%@",model.price];
        
       
       // scrollow.backgroundColor=[UIColor redColor];
      // [self.view addSubview:scrollow];
        [self.photoArr removeAllObjects];
        for (int i=0; i<model.productArr.count; i++) {
            pdModel *mod=[[pdModel alloc]init];
            mod=model.productArr[i];
            NSString *str=mod.images;
            NSArray *imageArr=[[WLSingletonClass defaultWLSingleton]wlJsonStringToDicOrArr:str];
            [self.photoArr addObject:imageArr[0]];
        }
        NSInteger width = (self.scrollow.bounds.size.width - 5*6)/5;
        NSInteger height = self.scrollow.bounds.size.height-20;
    
        for (NSInteger i = 0; i < self.photoArr.count; i++)
        {
            
            //创建里面的button
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame =CGRectMake(5+(width+5)*i, 10, width, height);
            [button addTarget:self action:@selector(iconClick:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 301+i;
            //异步加载网络图片
            
            [button sd_setBackgroundImageWithURL:[NSURL URLWithString:self.photoArr[i]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed: @"默认图3"]];
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = 8;
            
            [self.scrollow addSubview:button];
        }
        
        self.scrollow.contentSize = CGSizeMake((width+5)*self.photoArr.count+windowContentWidth/2, height);
    }
    
    
}
-(void)iconClick:(UIButton *)button
{
    
}
-(NSMutableArray *)photoArr
{
    if (_photoArr==nil) {
        _photoArr=[[NSMutableArray alloc]init];
        
    }
    return _photoArr;
}
-(NSString *)returnStrFromSeconds:(double)seconds
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [formatter stringFromDate:date];
    return currentDateStr;
 }


-(NSString *)returnStrWithStatus:(NSString *)status
{
    NSString *str;
    switch ([status intValue]) {
        case 0:
            str= @"提交成功";
            break;
        case 1:
            str= @"商家已接单";
            break;
        case 2:
            str= @"商家拒单";
            break;
        case 3:
            str= @"订单超时";
            break;
        case 4:
            str= @"订单取消";
            break;
        case 5:
            str= @"自动取消";
            break;
        case 6:
            str= @"退款中";
            break;
        case 7:
            str= @"退款成功";
            break;
        case 8:
            str= @"退款失败";
            break;
        case 9:
            str= @"商户撤单";
            break;
        case 10:
            str= @"已核销";
            break;
        case 11:
            str= @"订单过期";
        default:
            break;
    }
    return str;
}

-(JYCselfEatOrderModel *)_model
{
    if (_model==nil) {
        _model=[[JYCselfEatOrderModel alloc]init];
        
    }
    return _model;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
