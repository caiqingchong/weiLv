//
//  LXPlaneInfoView.m
//  WelLv
//
//  Created by liuxin on 15/9/9.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "LXPlaneInfoView.h"
#import "LXPlaneOrderModel.h"


@implementation LXPlaneInfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//- (id)initWithFrame:(CGRect)frame model:(LXBaseModel *)model
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.frame = frame;
//        self.backgroundColor = [UIColor whiteColor];
//       //在这里赋值
//        [self addSubview:self.leaveDayTime];
//    }
//    return self;
//}


//-(void)awakeFromNib
//{
//    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"LXPlaneInfoView"owner:self options:nil];
//    LXPlaneInfoView *view = [nibView objectAtIndex:0];
//    DLog(@"view=%@",view);
//    
//   
//}

-(void)setPlaneView:(LXPlaneOrderModel *)moedl planeType:(NSUInteger)type
{
    //DLog(@"basemodel=%@,cabLitsModel=%@，真实价格=%@",moedl,cabModel, cabModel.Sale);
    NSString *leaveDay=[moedl.OffTime substringWithRange:NSMakeRange(5, 5)];
    self.leaveDayTime.text=leaveDay;
    self.nameLab.text=moedl.CarrinerName;
    self.name1Lab.text=moedl.CabinName;
    self.leaveTimeLab.text=[moedl.OffTime substringWithRange:NSMakeRange(11, 5)];
    self.arriveTimeLab.text=[moedl.ArriveTime substringWithRange:NSMakeRange(11, 5)];
    self.leaveAirdromeLab.text=moedl.StartPortName;
    self.arriceAirdromeLab.text=moedl.EndPortName;
    
    if (type==0) {
        self.planeTypeLab.text=@"去程";
    }else if (type==1){
        self.planeTypeLab.text=@"返程";
    }
    
}

@end
