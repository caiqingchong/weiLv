//
//  CSHShopCell.h
//  WelLv
//
//  Created by mac for csh on 15/11/20.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CSHShopModel;
@interface CSHShopCell : UITableViewCell

@property (nonatomic,strong)UIImageView *leftImageView;
@property (nonatomic,strong)UIView *statusView;
@property (nonatomic,strong)UILabel *shordNameLab;// partner_shop_name
@property (nonatomic,strong)UILabel *mainPhoneLab;// main_phone
@property (nonatomic,strong)UILabel *statusLab;

@property (nonatomic,strong)CSHShopModel *item;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;



@end
