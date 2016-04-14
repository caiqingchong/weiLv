//
//  ShaixuanTableViewCell.m
//  Lvyou
//
//  Created by 赵冉 on 16/1/13.
//  Copyright © 2016年 赵冉. All rights reserved.
//

#import "ShaixuanTableViewCell.h"

@implementation ShaixuanTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
       return self;
}



- (void)makeUI {
    _titlelable = [[UILabel alloc]initWithFrame:CGRectMake(20, windowContentHeight / 16.67 / 3 , 100, windowContentHeight / 16.67 / 3)];
    _titlelable.font = [UIFont systemFontOfSize:windowContentWidth /26.7];
    _Vc = [[UIImageView alloc]initWithFrame:CGRectMake(windowContentWidth / 1.6 - 20 - windowContentHeight / 16.67 / 3 , windowContentHeight / 16.67 / 3 +5, 14, 10)];
    
    [self.contentView addSubview:_Vc];

    [self.contentView addSubview:_titlelable];
    
}


- (void)config:(Desmodel *)model{
    
    _titlelable.text = model.region_name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        _Vc.hidden = NO;
    } else {
        self.contentView.backgroundColor = [UIColor whiteColor];
        _Vc.hidden = YES;
    }
}


@end
