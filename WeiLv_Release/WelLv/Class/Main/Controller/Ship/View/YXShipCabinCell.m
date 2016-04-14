//
//  YXShipCabinCell.m
//  WelLv
//
//  Created by lyx on 15/5/18.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "YXShipCabinCell.h"
#import "ZFJShipDetailModel.h"
#import "ZFJAddAndMinusView.h"

@interface YXShipCabinCell ()
@property (nonatomic, strong) UILabel * adultLabel;
@property (nonatomic, strong) UILabel * childLabel;


@end

@implementation YXShipCabinCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = frame;
        [self initView];
    }
    return self;
}

- (void)initView
{
    
    _cabinFourName = [YXTools allocLabel:@"高级内仓四人房" font:systemFont(15) textColor:[UIColor blackColor] frame:CGRectMake(15, 10, 120, 30) textAlignment:0];
    _cabinFourName.numberOfLines = 0;
    [self addSubview:_cabinFourName];
    
    _fRoomDetail =[YXTools allocLabel:@"15㎡, 2,3,5层, 入住4人" font:systemFont(13) textColor:[UIColor grayColor] frame:CGRectMake(ViewX(_cabinFourName), ViewHeight(_cabinFourName)+ViewY(_cabinFourName) + 20, 150, 30) textAlignment:0];
    [self addSubview:_fRoomDetail];
    
    _kucunLabel =[YXTools allocLabel:@"剩余舱房：2间" font:systemFont(13) textColor:[UIColor grayColor] frame:CGRectMake(ViewX(_cabinFourName), ViewHeight(_fRoomDetail)+ViewY(_fRoomDetail), 150, 30) textAlignment:0];
    [self addSubview:_kucunLabel];
    
    UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(self.frame.size.width - 140, 0, 140, ViewHeight(self));
    [self addSubview:but];
    
    _price12Label = [YXTools allocLabel:@"" font:systemFont(16) textColor:[UIColor blackColor] frame:CGRectMake(self.frame.size.width - 120,ViewY(_cabinFourName), 100, 30) textAlignment:2];
    [self addSubview:_price12Label];
    
    self.commissionLab = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 115, ViewY(_cabinFourName) + 30, 100, 20)];
    self.commissionLab.font = [UIFont systemFontOfSize:12];
    self.commissionLab.adjustsFontSizeToFitWidth = YES;
    self.commissionLab.textAlignment = NSTextAlignmentRight;
    [self addSubview:_commissionLab];
    
    self.addAndMinusView = [[ZFJAddAndMinusView alloc] initWithFrame:CGRectMake(windowContentWidth - 115, ViewBelow(_commissionLab) + 20, 100, 40)and:@"1"];
    [self addSubview:self.addAndMinusView];
    
}

- (void)setRoomModel:(ZFJShipRoom *)roomModel{
    
    if ([roomModel.stock integerValue] == 0) {
        
        //[self.addAndMinusView.addBut setImage:[UIImage imageNamed:@"添加不可用"] forState:UIControlStateNormal];
     self.addAndMinusView.addBut.userInteractionEnabled = NO;
    }
    else
    {
    //[self.addAndMinusView.addBut setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
    self.addAndMinusView.addBut.userInteractionEnabled = YES;
    }
    
    if (4 <= [roomModel.num intValue]&& [self judgeString:roomModel.third_price] && [roomModel.third_price floatValue] > 0) {
        [self addChildAandMView:roomModel];
        self.addAndMinusView.maxNum = [roomModel.stock integerValue] * [roomModel.num integerValue];
        
    } else if ([roomModel.num isEqualToString:@"3"] && [self judgeString:roomModel.third_price] && [roomModel.third_price floatValue] > 0) {
        [self addChildAandMView:roomModel];
        self.addAndMinusView.maxNum = [roomModel.stock integerValue] * [roomModel.num integerValue];
        
    } else {
        [self.adultLabel removeFromSuperview];
        [self.childLabel removeFromSuperview];
        [self.childAandMView removeFromSuperview];
        _price12Label.frame = CGRectMake(self.frame.size.width - 120,ViewY(_cabinFourName), 100, 40);
        self.commissionLab.frame = CGRectMake(ViewX(_commissionLab), ViewBelow(_price12Label), ViewWidth(_commissionLab), 20);
        self.addAndMinusView.frame = CGRectMake(windowContentWidth - 115, ViewBelow(_commissionLab), 100, 40);
        self.addAndMinusView.maxNum = [roomModel.stock integerValue] * [roomModel.num integerValue];
        
    }
    
    self.liveInNumber = roomModel.num;
    self.cabinFourName.text = roomModel.cabin_name;
    NSString *detail = [NSString stringWithFormat:@"%@㎡, %@层, 入住%@人",roomModel.size, roomModel.floors,roomModel.num];
    self.fRoomDetail.text = detail;
    
    self.kucunLabel.text = [NSString stringWithFormat:@"剩余舱房：%@间",roomModel.stock];
    
    NSString *lastPriceStr = nil;
    
    if (roomModel.first_price.intValue > 0 && roomModel.second_price.intValue > 0 && roomModel.third_price.intValue > 0) {
        lastPriceStr = roomModel.third_price;
    }
    else if(roomModel.first_price.intValue > 0 && roomModel.second_price.intValue > 0 && roomModel.third_price.intValue <= 0)
    {
        lastPriceStr = roomModel.second_price;
        
    }
    else
    {
        lastPriceStr = roomModel.first_price;
    }
    
    self.price12Label.text = [NSString stringWithFormat:@"￥%@/人",lastPriceStr];
    
    
    self.price12Label.adjustsFontSizeToFitWidth = YES;
    self.price12 = roomModel.room_price2;
    self.price34 = roomModel.room_34_price2;

}

- (void)addChildAandMView:(ZFJShipRoom *)roomModel {
    _price12Label.frame = CGRectMake(ViewX(_price12Label), 0, ViewWidth(_price12Label), 20);
    self.commissionLab.frame = CGRectMake(ViewX(_commissionLab), ViewBelow(_price12Label), ViewWidth(_commissionLab), 20);
    self.addAndMinusView.frame = CGRectMake(ViewX(_addAndMinusView), ViewBelow(_commissionLab), ViewWidth(_addAndMinusView), ViewHeight(_addAndMinusView));
    if (!self.adultLabel) {
        self.adultLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(_addAndMinusView) - 40, ViewY(_addAndMinusView), 40, 40)];
        _adultLabel.font = [UIFont systemFontOfSize:15];
        _adultLabel.text = @"成人";
        [self addSubview:_adultLabel];
        
        self.childLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(_addAndMinusView) - 40, ViewBelow(_adultLabel), 40, 40)];
        _childLabel.font = [UIFont systemFontOfSize:15];
        _childLabel.text = @"儿童";
        [self addSubview:_childLabel];
        
        self.childAandMView =[[ZFJAddAndMinusView alloc] initWithFrame:CGRectMake(windowContentWidth - 115, ViewBelow(_addAndMinusView), 100, 40)and:@"child"];
        self.childAandMView.maxNum = -1;
        /*
         //self.childAandMView.maxNum = 10;
         [self.childAandMView numOfSumLabel:^(NSInteger num) {
         NSLog(@"值 = %ld", num);
         //[self.delegate calculateTotalAmount:self.indexRow number:[NSString stringWithFormat:@"%ld", num] roomNum:[roomModel.stock intValue] totalPrice:@"" andTag:2 cabinDic:self.cabinDic];
         
         
         }];
         */
        self.frame = CGRectMake(ViewX(self), ViewY(self), ViewWidth(self), ViewBelow(self.childAandMView));
        [self addSubview:self.childAandMView];
        
    }
    
    [self addSubview:_adultLabel];
    [self addSubview:_childLabel];
    [self addSubview:self.childAandMView];
}



@end
