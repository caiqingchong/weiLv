//
//  CyYLTableViewCell.h
//  WelLv
//
//  Created by 赵冉 on 16/1/19.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYYLModel.h"

@protocol Godelegate <NSObject>

- (void)Goto:(CYYLModel *)model;

@end

@interface CyYLTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView * imagevc;
@property (nonatomic, strong) UILabel * namelable;
@property (nonatomic, strong) UILabel * number;
@property (assign,nonatomic) BOOL selectState;//选中状态


- (void)config:(CYYLModel *)model;
@property(nonatomic,weak) id<Godelegate>delegate;
@end
