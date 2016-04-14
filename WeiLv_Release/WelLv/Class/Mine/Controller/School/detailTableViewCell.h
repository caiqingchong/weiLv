//
//  detailTableViewCell.h
//  WelLv
//
//  Created by mac for csh on 15/9/1.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface detailTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *titleLab;
@property (nonatomic,strong)UIImageView *lefImageV;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
