//
//  NewHouseKeeperListTableViewCell.m
//  WelLv
//
//  Created by daihengbin on 16/1/13.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "NewHouseKeeperListTableViewCell.h"
#define kNameFont   [UIFont systemFontOfSize:14.f]
@implementation NewHouseKeeperListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}
-(void)createView{
    self.avatarImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
    self.avatarImage.layer.cornerRadius = 40;
    self.avatarImage.layer.masksToBounds = YES;
    [self.contentView addSubview:self.avatarImage];
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.nameLabel];
    
//    self.sexImage = [[UIImageView alloc]initWithFrame:CGRectMake(ViewRight(self.nameLabel)+10, 10, 50, 50)];
    self.sexImage = [[UIImageView alloc]init];
    [self.contentView addSubview:self.sexImage];
    
    self.serviceRecordLabel = [[UILabel alloc]initWithFrame:CGRectMake(ViewRight(self.avatarImage)+10, ViewBelow(self.avatarImage)-20, (windowContentWidth-ViewRight(self.avatarImage)-30)/2, 20)];
    self.serviceRecordLabel.textColor = [UIColor grayColor];
    self.serviceRecordLabel.textAlignment = NSTextAlignmentLeft;
    self.serviceRecordLabel.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:self.serviceRecordLabel];
    
    self.productSellLabel = [[UILabel alloc]initWithFrame:CGRectMake(ViewRight(self.serviceRecordLabel)+10,ViewBelow(self.avatarImage)-20,(windowContentWidth-ViewRight(self.avatarImage)-30)/2, 20)];
    self.productSellLabel.textColor = [UIColor grayColor];
    self.productSellLabel.textAlignment = NSTextAlignmentLeft;
    self.productSellLabel.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:self.productSellLabel];
}

-(void)setHouseKeeperListModel:(NewHosekeeperListModel *)houseKeeperListModel{
    
    _houseKeeperListModel = houseKeeperListModel;
    [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://112.126.68.22/%@",self.houseKeeperListModel.avatar]] placeholderImage:[UIImage imageNamed:@"默认图1"]];
    self.serviceRecordLabel.text  = [NSString stringWithFormat:@"服务记录:%@",self.houseKeeperListModel.order_count];
    self.productSellLabel.text = [NSString stringWithFormat:@"分销产品:%@",self.houseKeeperListModel.product_count];

    self.nameLabel.text = self.houseKeeperListModel.name;
    self.nameLabel.font = [UIFont systemFontOfSize:16.f];
    CGSize size = [_nameLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_nameLabel.font,NSFontAttributeName, nil]];
    self.nameLabel.frame = CGRectMake(ViewRight(self.avatarImage)+10, 10,size.width , 20);
    
    [self.sexImage setFrame:CGRectMake(ViewRight(self.nameLabel)+10, 10, 15, 15)];
    if ([_houseKeeperListModel.gender isEqualToString:@"2"]) {
        self.sexImage.image = [UIImage imageNamed:@"♀"];
    }
    
    if ([_houseKeeperListModel.gender isEqualToString:@"1"]) {
        self.sexImage.image = [UIImage imageNamed:@"♂"];
    }
    if ([self.houseKeeperListModel.gender isEqualToString:@"0"]) {
        self.sexImage.image = [UIImage imageNamed:@"保密"];
    }
    if (self.houseKeeperListModel.gender == nil) {
        self.sexImage.image = [UIImage imageNamed:@"保密"];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
