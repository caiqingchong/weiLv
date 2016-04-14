//
//  ShaixuanTableViewCell.h
//  Lvyou
//
//  Created by 赵冉 on 16/1/13.
//  Copyright © 2016年 赵冉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Desmodel.h"
@interface ShaixuanTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel * titlelable;
@property(nonatomic,strong)UIImageView * Vc;
- (void)config:(Desmodel *)model;
@end
