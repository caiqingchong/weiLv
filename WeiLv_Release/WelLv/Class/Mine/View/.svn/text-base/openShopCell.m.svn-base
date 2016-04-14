//
//  openShopCell.m
//  WelLv
//
//  Created by mac for csh on 15/11/14.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "openShopCell.h"

@implementation openShopCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        self.backgroundColor = [UIColor whiteColor];
        float cellHeight = 45;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, windowContentWidth/2 -10, cellHeight)];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_titleLabel];
        
        _detailtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(windowContentWidth/2 , 0,windowContentWidth/2 -30, cellHeight)];
        _detailtitleLabel.textAlignment = NSTextAlignmentRight;
        _detailtitleLabel.textColor = [UIColor grayColor];
        _detailtitleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_detailtitleLabel];
        
         UIImageView *rightIGV = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-45 , cellHeight/2-15, 45, 30)];
        [rightIGV setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
        [self addSubview:rightIGV];
 
        //  framesize 40*40
//        _IGV = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth -45 -40,cellHeight/2-40/2, 40, 40)];
//        _IGV.backgroundColor = [UIColor clearColor];
//        [self addSubview:_IGV];
       
    }
    
    return self;
}

//-(void)setTitle:(NSString *)tt{
//    NSLog(@"%@",self.title);
//
//    self.title = tt;
//}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
