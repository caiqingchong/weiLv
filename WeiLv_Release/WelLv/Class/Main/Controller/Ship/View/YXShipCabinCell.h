//
//  YXShipCabinCell.h
//  WelLv
//
//  Created by lyx on 15/5/18.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCSuperObjectViewController.h"
@class ZFJShipRoom, ZFJAddAndMinusView;


@protocol YXShipCabinCellDelegate <NSObject>

- (void)calculateTotalAmount:(NSInteger)index number:(NSString *)number roomNum:(int)number1 totalPrice:(NSString *)price andTag:(int)tag cabinDic:(NSDictionary *)dic;
@end
@interface YXShipCabinCell : UITableViewCell
{
    UILabel *_fRoomDetail;        //四/二人房详细介绍
    UILabel *_fRoomNumber;        //四/二人房人数
    UILabel *_fRoomRoomNumber;    //四/二人房房间数
    UILabel *_cabinFourName;      //仓房名称
    UILabel *_kucunLabel;
}

@property (nonatomic,strong)UILabel *fRoomDetail;
@property (nonatomic,strong)UILabel *fRoomNumber;
@property (nonatomic,strong)UILabel *fRoomRoomNumber;
@property (nonatomic,strong)UILabel *cabinFourName;
@property (nonatomic,strong)UILabel *kucunLabel;        //库存
@property (nonatomic,strong)UILabel *price12Label;     //1、2人价格
@property (nonatomic,assign)NSInteger indexRow;
@property (nonatomic,strong)NSString *liveInNumber;       //可住人数
@property (nonatomic,strong)NSString *price12;            //1、2人价格
@property (nonatomic,strong)NSString *price34;            //3、4人价格
@property (nonatomic,strong)NSDictionary *cabinDic;
@property (nonatomic,weak)id <YXShipCabinCellDelegate> delegate;
@property (nonatomic, strong) ZFJShipRoom * roomModel;
/**
 *  修改后的
 */
@property (nonatomic, strong) ZFJAddAndMinusView * addAndMinusView;
@property (nonatomic, strong) ZFJAddAndMinusView * childAandMView;

@property (nonatomic, strong) UILabel * commissionLab;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame;
@end
