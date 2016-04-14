//
//  ZFJShipShoreTravelCell.h
//  WelLv
//
//  Created by zhangjie on 15/10/11.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IconAndTitleView;

typedef void(^ViewHeight)(CGFloat height);
typedef void(^ChooseShoreTravelRow)(NSInteger shoreTravelRow);

@interface ZFJShipShoreTravelCell : UITableViewCell
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIView * lineView;

@property (nonatomic, strong) UITableView * shoreTravelTableView;
@property (nonatomic, strong) NSArray * modelArr;
@property (nonatomic, strong) NSString * dayStr;

@property (nonatomic, copy) ViewHeight height;
@property (nonatomic, assign) BOOL isOpen;

/*新改字段*/
@property (nonatomic, strong) UILabel * dayLabel;
@property (nonatomic, strong) UIView * addressLineView;
@property (nonatomic, strong) UILabel * addressLabel;

@property (nonatomic, strong) IconAndTitleView * timeLabel;
@property (nonatomic, strong) IconAndTitleView * shipNameLabel;
@property (nonatomic, strong) IconAndTitleView * shoreTravelLabel;
@property (nonatomic, copy) ChooseShoreTravelRow chooseShoreTraveRow;

- (void)chooseOneDayShoreTravelRow:(ChooseShoreTravelRow)chooseRow;

@end
