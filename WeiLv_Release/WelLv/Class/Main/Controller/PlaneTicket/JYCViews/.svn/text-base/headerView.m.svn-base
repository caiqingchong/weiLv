//
//  headerView.m
//  WelLv
//
//  Created by lyx on 15/9/9.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "headerView.h"
#import "LXPlaneTicketOrderViewController.h"

@implementation headerView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"headerView"owner:self options:nil];
        //NSLog(@"sddsdas%@",nibView);
        headerView *view = [nibView lastObject];
        view.frame=CGRectMake(0, 0, windowContentWidth, 90);
        view.backgroundColor=[UIColor whiteColor];

        [self addSubview:self.priceLabel];
        [self addSubview:self.startTimeLabel];
        [self addSubview:self.startCityLabel];
        [self addSubview:self.endTimeLabel];
        [self addSubview:self.endCityLabel];
        [self addSubview:self.discoutLabel];
        [self addSubview:self.ticketLabel];
        [self addSubview:self.companyLabel];
        [self addSubview:self.moreBtn];
        [self addSubview:self.line];
        [self addSubview:self.topLine];
        [self addSubview:self.image];
        self.image.image=[UIImage imageNamed:@""];
        self.image.tag=100;
        [self addSubview:self.clickBtn];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
//        // tap.numberOfTouchesRequired = 1;
//        // tap.numberOfTapsRequired    = 1;
//        [self addGestureRecognizer:tap];
    }
    return self;

}
- (IBAction)clickBtn:(id)sender {

    self.fold = !self.isFold;
    UIImageView *image = (id)[self viewWithTag:100];
    image.image = self.isFold ? [UIImage imageNamed:@"订单明细按钮"] : [UIImage imageNamed:@"订单明细按钮down"];
    [self.moreBtn setTitle:self.isFold ? @"更多舱位":@"低价舱位" forState:UIControlStateNormal];
    if (self.clickHandler) {
        self.clickHandler(self, self.isFold);
    }


}


- (void)showDataWithModel:(baseModel *)model section:(NSInteger)section
{
    NSString *str=[model.OffTime substringWithRange:NSMakeRange(11,5)];
    self.startTimeLabel.text=str;
    self.startCityLabel.text=[NSString stringWithFormat:@"%@机场",model.StartPortName];
    self.priceLabel.text=[NSString stringWithFormat:@"￥%@",model.MinFare];
    //NSLog(@"%@",self.priceLabel.text);
    NSString *str2=[model.ArriveTime substringWithRange:NSMakeRange(11,5)];
    self.endTimeLabel.text=str2;
    self.endCityLabel.text=[NSString stringWithFormat:@"%@机场",model.EndPortName];
    int intStr=[model.MinDiscount intValue];
    if(intStr>=100){
      self.discoutLabel.text=[NSString stringWithFormat:@"%@",model.MinCabin];
    }else if(intStr<100)
    {
    self.discoutLabel.text=[NSString stringWithFormat:@"%@ %d折",model.MinCabin,intStr/10];
    }
    self.ticketLabel.text=[NSString stringWithFormat:@"剩余%@张",model.MinTicketCount];
    self.companyLabel.text=[NSString stringWithFormat:@"%@ %@",model.CarrinerName,model.FlightNo];
    

}
- (void)setFold:(BOOL)fold {
    _fold = fold;
    UIImageView *image = (UIImageView *)[self viewWithTag:100];
    image.image = _fold ? [UIImage imageNamed:@"订单明细按钮"] : [UIImage imageNamed:@"订单明细按钮down"];
    [self.moreBtn setTitle:self.isFold ?@"更多舱位":@"低价舱位" forState:UIControlStateNormal];
}


- (IBAction)moreLabel:(id)sender {
//    self.fold = !self.isFold;
//    UIImageView *image = (id)[self viewWithTag:100];
//    image.image = self.isFold ? [UIImage imageNamed:@"订单明细按钮"] : [UIImage imageNamed:@"订单明细按钮down"];
//    [self.moreBtn setTitle:self.isFold ? @"更多舱位":@"低价舱位" forState:UIControlStateNormal];
//    if (self.clickHandler) {
//        self.clickHandler(self, self.isFold);
//    }

}
@end
