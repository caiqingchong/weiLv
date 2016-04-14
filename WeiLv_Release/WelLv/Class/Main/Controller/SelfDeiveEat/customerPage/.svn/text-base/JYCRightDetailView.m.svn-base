//
//  JYCRightDetailView.m
//  WelLv
//
//  Created by lyx on 15/11/23.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "JYCRightDetailView.h"
#import "TimeLogModel.h"


@interface JYCRightDetailView()
{
    AFHTTPRequestOperationManager *manager;
    BOOL decut;
    UIView *detailView;
}
@property(nonatomic,strong)NSDictionary *downDict;
@property(nonatomic,strong)NSDictionary *partnerDict;
@property(nonatomic,strong)NSMutableArray *productArr;
@property(nonatomic,strong)NSArray *timeLog;
@end

@implementation JYCRightDetailView
- (id)initWithFrame:(CGRect)frame and:(NSMutableDictionary *)dict with:(NSMutableArray *)arr
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // self.backgroundColor=[UIColor blueColor];
        //_timeLog=[[NSMutableArray alloc]init];
        self.backgroundColor=BgViewColor;
        _productArr=[[NSMutableArray alloc]init];
        _productArr=arr;
        self.downDict=dict;
        NSLog(@"%@",dict);
        _timeLog=(NSArray *)self.downDict[@"timeLog"];
        self.partnerDict=self.downDict[@"partner"];
        NSLog(@"%@",self.downDict);
        [self initUI];
    }
    return self;

}
-(void)initUI
{
    UIButton *nameBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 10, windowContentWidth, 40)];
    [nameBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:nameBtn];
    nameBtn.backgroundColor=[UIColor whiteColor];
    UIImageView *leftView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    leftView.image=[UIImage imageNamed:@"店家-副本"];
    [nameBtn addSubview:leftView];
    UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(leftView)+10, 0, windowContentWidth-60, 40)];
    nameLabel.text=[NSString stringWithFormat:@"%@",self.partnerDict[@"partner_shop_name"]];
    nameLabel.textColor=[UIColor blackColor];
    [nameBtn addSubview:nameLabel];
    //矩形-32-副本-15
    UIImageView *rightView=[[UIImageView alloc]initWithFrame:CGRectMake(windowContentWidth-20, 11.5, 10, 17)];
    rightView.image=[UIImage imageNamed:@"矩形-32-副本-15"];
    [nameBtn addSubview:rightView];
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(0, 39, windowContentWidth, 1)];
    line1.backgroundColor=bordColor;
    [nameBtn addSubview:line1];
    
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(nameBtn), windowContentWidth, self.productArr.count*40)];
    topView.backgroundColor=[UIColor whiteColor];
    [self addSubview:topView];
    for (int i=0; i<self.productArr.count; i++) {
        productsModel *model=[[productsModel alloc]init];
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 15+40*i, 10, 10)];
        imageView.backgroundColor=[UIColor greenColor];
        imageView.layer.cornerRadius=5.0;
        [topView addSubview:imageView];
        UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(imageView)+10, 0+i*40, 100, 40)];
        nameLabel.font=systemFont(18);
        nameLabel.textColor=[UIColor blackColor];
        model=self.productArr[i];
        nameLabel.text=model.describe;
        [topView addSubview:nameLabel];
        UILabel *numBerLabel=[[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth/3*2, 0+40*i, 40, 40)];
        numBerLabel.textColor=[UIColor blackColor];
        numBerLabel.text=[NSString stringWithFormat:@"%@",model.nums];
        numBerLabel.font=systemFont(18);
        [topView addSubview:numBerLabel];
        UILabel *priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth-120-10, 0+i*40, 120, 40)];
        priceLabel.textColor=[UIColor colorWithRed:227/255.0 green:67/255.0 blue:34/255.0 alpha:1];
        priceLabel.textAlignment=NSTextAlignmentRight;
        
        priceLabel.text=[NSString stringWithFormat:@"￥%0.1f",[model.price floatValue]];
        priceLabel.font=systemFont(18);
        [topView addSubview:priceLabel];
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(ViewX(nameLabel), 39+i*40, windowContentWidth-ViewX(nameLabel), 1)];
        line.backgroundColor=bordColor;
        [topView addSubview:line];
        if (i==self.productArr.count-1) {
            line.hidden=YES;
        }
    }
    UIView *hejiView=[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(topView)+10, windowContentWidth, 40)];
    hejiView.backgroundColor=[UIColor whiteColor];
    [self addSubview:hejiView];
    UILabel *hejiLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 40, 40)];
    hejiLabel.textColor=[UIColor blackColor];
    hejiLabel.text=@"合计";
    hejiLabel.font=systemFont(18);
    [hejiView addSubview:hejiLabel];
    UILabel *hejiLabel2=[[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth-10-120, 0, 120, 40)];
    hejiLabel2.text=[NSString stringWithFormat:@"￥%@",self.downDict[@"price"]];
    hejiLabel2.textColor=[UIColor colorWithRed:227/255.0 green:67/255.0 blue:34/255.0 alpha:1];
    hejiLabel2.font=systemFont(18);
    hejiLabel2.textAlignment=NSTextAlignmentRight;
    [hejiView addSubview:hejiLabel2];
    
    if([self.downDict[@"order_status"]intValue]==4)
    {
        for (int i=0;i<self.timeLog.count; i++)
        {
            TimeLogModel *model2=[[TimeLogModel alloc]init];
            NSDictionary *dic  =self.timeLog[i];
            [model2 setValuesForKeysWithDictionary:dic];
                   //  NSLog(@"%@",model2.status);
            NSString *resultStr =[NSString stringWithFormat:@"%@",[model2 status]];
            if ([resultStr isEqualToString:@"3"]) {
                decut=YES;
            }
        }
    }
    
    if (decut==YES) {
      
    double price=[self.downDict[@"price"]doubleValue]*[self.downDict[@"deduct"]doubleValue];
    NSString *strPrice1=[NSString stringWithFormat:@"%0.1f",price];
    NSString *strPrice2=[NSString stringWithFormat:@"%0.1f",[self.downDict[@"price"]doubleValue]-price];
    UIView *refundView=[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(hejiView)+10, windowContentWidth, 80)];
        refundView.backgroundColor=[UIColor whiteColor];
     [self addSubview:refundView];
       NSArray *nameArr=[NSArray arrayWithObjects:@"扣款",@"应退款", nil];
      NSArray *priceArr=[NSArray arrayWithObjects:strPrice1,strPrice2, nil];
       for (int i=0; i<nameArr.count; i++)
       {
           UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10, 0+i*40, 80, 40)];
           label1.textColor=[UIColor blackColor];
           label1.text=[NSString stringWithFormat:@"%@",nameArr[i]];
           label1.font=systemFont(18);
           [refundView addSubview:label1];
           UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(0, 39, windowContentWidth, 1)];
           line.backgroundColor=bordColor;
           [refundView addSubview:line];
           
           UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth-120-10, 0+i*40, 120, 40)];
           label2.text=[NSString stringWithFormat:@"￥%@",priceArr[i]];
           label2.textAlignment=NSTextAlignmentRight;
           label2.textColor=[UIColor colorWithRed:227/255.0 green:67/255.0 blue:34/255.0 alpha:1];
           label2.font=systemFont(18);
           [refundView addSubview:label2];
       }
        detailView=[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(refundView)+10, windowContentWidth, 160)];
        detailView.backgroundColor=[UIColor whiteColor];
        [self addSubview:detailView];
    }else{
    detailView=[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(hejiView)+10, windowContentWidth, 160)];
  
    detailView.backgroundColor=[UIColor whiteColor];
    [self addSubview:detailView];
        
    }
    NSLog(@"%lf",[self.downDict[@"create_time"] doubleValue]);
    NSString *str=[self returnStrFromSeconds:[self.downDict[@"come_time"] doubleValue]];
    NSArray *detailArr=[NSArray arrayWithObjects:self.downDict[@"sn"],str,self.downDict[@"phone"],@"支付宝支付", nil];
    NSArray *nameArr=[NSArray arrayWithObjects:@"订单编号",@"订单时间",@"手机号",@"支付方式", nil];
    for (int i=0; i<nameArr.count; i++) {
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10, 0+i*40, 80, 40)];
        label1.textColor=[UIColor blackColor];
        label1.text=[NSString stringWithFormat:@"%@",nameArr[i]];
        label1.font=systemFont(18);
        [detailView addSubview:label1];
        UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(label1)+20, 0+i*40, windowContentWidth-110, 40)];
        label2.text=[NSString stringWithFormat:@"%@",detailArr[i]];
        label2.textColor=[UIColor grayColor];
        label2.font=systemFont(18);
        [detailView addSubview:label2];
    };
    
}

-(NSString *)returnStrFromSeconds:(double)seconds
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [formatter stringFromDate:date];
    return currentDateStr;
}
-(void)btnClick
{
    NSLog(@"1111");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
