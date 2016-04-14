//
//  PriceTableViewCell.m
//  WelLv
//
//  Created by 赵冉 on 16/1/15.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "PriceTableViewCell.h"

@implementation PriceTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}

- (void)makeUI {
    //    static int left = 42 /2;
    //    static int height = 50 /2;
    //    static int cellheight = 67 /2;
    //    switch ((int)windowContentHeight) {
    //        case 667:
    //            left = 50 / 2;
    //            height = 25 /2 ;
    //            cellheight = 79 /2;
    //            break;
    //        case 736:
    //            left = 80 / 2;
    //            height = 44 / 2;
    //            cellheight = 130 /2;
    //            break;
    //        default:
    //            break;
    //    }
    //
    
    _titlelable = [[UILabel alloc]initWithFrame:CGRectMake(20, windowContentHeight / 16.67 / 3 , 200, windowContentHeight / 16.67 / 3)];
    _Vc = [[UIImageView alloc]initWithFrame:CGRectMake(windowContentWidth / 1.6 - 20 - windowContentHeight / 16.67 / 3 , windowContentHeight / 16.67 / 3 + 5, 14, 10)];
    _titlelable.font = [UIFont systemFontOfSize:windowContentWidth / 26.7];

    
    [self.contentView addSubview:_Vc];
    
    [self.contentView addSubview:_titlelable];
    
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
