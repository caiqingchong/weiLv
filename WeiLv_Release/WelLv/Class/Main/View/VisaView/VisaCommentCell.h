//
//  VisaCommentCell.h
//  WelLv
//
//  Created by 张发杰 on 15/4/11.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VisaCommentCell : UITableViewCell
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *visaTapy;
@property (nonatomic, assign) NSInteger starNumber;
@property (nonatomic, strong) UILabel *chooesCommentLabel;
@property (nonatomic, strong) UILabel *commentTextLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end
