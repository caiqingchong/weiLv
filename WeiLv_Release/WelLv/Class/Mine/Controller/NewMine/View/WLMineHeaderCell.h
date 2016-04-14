//
//  WLMineHeaderCell.h
//  WelLv
//
//  Created by WeiLv on 15/12/3.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLMineHeaderCell : UITableViewCell

@property (nonatomic, strong) UIImageView * bgIcon;             //背景图片
@property (nonatomic, strong) UIImageView * headIcon;           //头像
@property (nonatomic, strong) UIButton * loginBut;              //登录按钮
@property (nonatomic, strong) UILabel * nameLab;                //名字
@property (nonatomic, strong) UILabel * companyLab;             //公司

@property (nonatomic, copy) NSString * companyStr;

@end
