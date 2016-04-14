//
//  JYCCell.h
//  WelLv
//
//  Created by lyx on 15/9/9.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cablistModel.h"
@interface JYCCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UILabel *ticketCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

- (void)showDataWithModel:(cablistModel *)model indexPath:(NSIndexPath *)indexPath;
@end
