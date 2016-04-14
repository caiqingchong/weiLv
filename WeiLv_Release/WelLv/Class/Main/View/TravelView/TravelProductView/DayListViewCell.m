//
//  DayListViewCell.m
//  TraveDetail
//
//  Created by WeiLv on 16/1/17.
//  Copyright © 2016年 WeiLv. All rights reserved.
//

#import "DayListViewCell.h"

#define UISCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

@implementation DayListViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.dayLable];
        
    }
    return self;
}

- (UILabel *)dayLable{
    if (!_dayLable) {
        self.dayLable = [[UILabel alloc]initWithFrame:CGRectMake(6, 0, UISCREEN_HEIGHT / 21.846, UISCREEN_HEIGHT / 21.846)];
        self.dayLable.textColor = [UIColor whiteColor];
    }
    return _dayLable;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
         self.dayLable.backgroundColor = [UIColor colorWithRed:254 / 255.0 green:181 / 255.0 blue:76 / 255.0 alpha:1.0];
        
    }else{
       self.dayLable.backgroundColor = [UIColor colorWithRed:146 / 255.0 green:146 / 255.0 blue:144 / 255.0 alpha:1.0];
    }
 
}

@end
