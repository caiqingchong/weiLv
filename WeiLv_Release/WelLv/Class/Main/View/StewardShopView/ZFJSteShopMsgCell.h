//
//  ZFJSteShopMsgCell.h
//  WelLv
//
//  Created by WeiLv on 15/10/24.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZFJSteShopMsgModel;
@interface ZFJSteShopMsgCell : UITableViewCell
@property (nonatomic, strong) UILabel * timeLab;
@property (nonatomic, strong) UILabel * msgLab;
@property (nonatomic, strong) UIButton * agreeBut;
@property (nonatomic, strong) UIButton * rejectBut;
@property (nonatomic, strong) UILabel * tagLab;
@property (nonatomic,strong)UILabel *cancleLabel;

@property (nonatomic, strong) ZFJSteShopMsgModel * modelMsg;

@end
