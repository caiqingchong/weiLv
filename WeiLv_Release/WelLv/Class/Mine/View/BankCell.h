//
//  BankCell.h
//  WelLv
//
//  Created by mac for csh on 15/11/19.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankCell : UITableViewCell


@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UIImageView *imageV;




- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
