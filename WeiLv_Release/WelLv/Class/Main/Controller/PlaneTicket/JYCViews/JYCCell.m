//
//  JYCCell.m
//  WelLv
//
//  Created by lyx on 15/9/9.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "JYCCell.h"

@implementation JYCCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)showDataWithModel:(cablistModel *)model indexPath:(NSIndexPath *)indexPath
{
    int intStr=[model.Discount intValue];
    if (intStr>=100) {
        self.discountLabel.text=[NSString stringWithFormat:@"%@",model.CabinName];
    }else if(intStr<100){
    self.discountLabel.text=[NSString stringWithFormat:@"%@ %d折",model.CabinName,intStr/10];
    }
    self.ticketCountLabel.text=[NSString stringWithFormat:@"剩余%@张",model.TicketCount];
    self.priceLabel.text=[NSString stringWithFormat:@"￥%@",model.Sale];
    
}
@end
