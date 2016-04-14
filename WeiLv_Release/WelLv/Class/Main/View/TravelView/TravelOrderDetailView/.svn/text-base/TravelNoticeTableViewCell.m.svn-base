//
//  TravelNoticeTableViewCell.m
//  WelLv
//
//  Created by 张子乾 on 16/1/19.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "TravelNoticeTableViewCell.h"
#import "TravelAllHeader.h"



@implementation TravelNoticeTableViewCell

//费用标题
- (UILabel *) costTitleLabel {
    if (_costTitleLabel == nil) {
        _costTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 120, 30)];
        _costDetailLabel.textAlignment = NSTextAlignmentLeft;

    }
    return _costTitleLabel;
}

//费用详情
- (UILabel *) costDetailLabel {
    if (_costDetailLabel == nil) {
        _costDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_costTitleLabel.frame), kCostDetailWidth, kCostDetailHeight)];
        _costDetailLabel.numberOfLines = 0;

    }
    return _costDetailLabel;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.costTitleLabel];
        [self.contentView addSubview:self.costDetailLabel];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
