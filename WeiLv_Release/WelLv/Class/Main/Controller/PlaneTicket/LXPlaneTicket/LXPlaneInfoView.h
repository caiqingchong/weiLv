//
//  LXPlaneInfoView.h
//  WelLv
//
//  Created by liuxin on 15/9/9.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXPlaneOrderModel;
@interface LXPlaneInfoView : UIView
@property (weak, nonatomic) IBOutlet UILabel *leaveDayTime;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *name1Lab;
@property (weak, nonatomic) IBOutlet UILabel *leaveTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *arriveTimeLab;
@property (weak, nonatomic) IBOutlet UIImageView *planeImage;
@property (weak, nonatomic) IBOutlet UILabel *leaveAirdromeLab;
@property (weak, nonatomic) IBOutlet UILabel *arriceAirdromeLab;
@property (weak, nonatomic) IBOutlet UILabel *planeTypeLab;
@property (weak, nonatomic) IBOutlet UIImageView *line1;
@property (weak, nonatomic) IBOutlet UIImageView *line2;


-(void)setPlaneView:(LXPlaneOrderModel *)moedl planeType:(NSUInteger)type;
@end
