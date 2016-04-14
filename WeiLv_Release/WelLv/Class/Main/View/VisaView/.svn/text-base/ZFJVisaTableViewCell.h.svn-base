//
//  ZFJVisaTableViewCell.h
//  WelLv
//
//  Created by 张发杰 on 15/4/13.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IamgeAndLabelView, ZFJVisaModel;

typedef NS_ENUM(NSInteger, ZFJVisaTableViewCellStyle){
    ZFJVisaTableViewCellStyleOne,
    ZFJVisaTableViewCellStyleTwo,
    ZFJVisaTableViewCellStyleThree
};


@interface ZFJVisaTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView * iconCountryImage;
@property (nonatomic, strong) UILabel * visaListNameLabel;
@property (nonatomic, strong) UILabel * LengthOfTimeLabel;
@property (nonatomic, strong) IamgeAndLabelView * imageAndLabelView;
@property (nonatomic, strong) UIButton * detailBut;
@property (nonatomic, strong) UILabel *  priceLabel;
@property (nonatomic, strong) UILabel * startLabel;
@property (nonatomic, strong) UILabel * stewardPrice;//管家返佣价；

@property (nonatomic, strong) UILabel * isNeedInterview;//是否需要面试；

@property (nonatomic, strong) ZFJVisaModel * visaModel;
@property (nonatomic, assign) ZFJVisaTableViewCellStyle cellStyle;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier customStyle:(ZFJVisaTableViewCellStyle)cellStyle;


@end
