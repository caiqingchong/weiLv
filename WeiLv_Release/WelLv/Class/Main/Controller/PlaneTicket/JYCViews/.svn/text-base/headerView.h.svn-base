//
//  headerView.h
//  WelLv
//
//  Created by lyx on 15/9/9.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseModel.h"
#import "cablistModel.h"
@interface headerView : UIView


@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *startCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *discoutLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *ticketLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

@property (weak, nonatomic) IBOutlet UILabel *line;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *topLine;


@property (weak, nonatomic) IBOutlet UIButton *clickBtn;


- (void)showDataWithModel:(baseModel *)model section:(NSInteger)section;
//-(void)tapGesture:(baseModel*)model model2:(cablistModel*)Pmodel;
@property (nonatomic, copy) void (^clickHandler)(headerView *view, BOOL isFold);

@property (nonatomic,getter= isFold) BOOL fold; // fold折叠
- (id)initWithFrame:(CGRect)frame;
@end
