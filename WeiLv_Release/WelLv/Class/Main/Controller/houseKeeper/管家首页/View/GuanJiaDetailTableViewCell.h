//
//  GuanJiaDetailTableViewCell.h
//  WelLv
//
//  Created by daihengbin on 16/1/14.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "service_recordModel.h"
@interface GuanJiaDetailTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *productTypelabel;
@property(nonatomic,strong)UILabel *leaveTimeLabel;
@property(nonatomic,strong)UIImageView *image;
@property(nonatomic,strong)UILabel *productNameLabel;
@property(nonatomic,strong)UILabel *singleMemberLabel;
@property(nonatomic,strong)UILabel *telLabel;
@property(nonatomic,strong)service_recordModel*serviceRecordModel;
@end
