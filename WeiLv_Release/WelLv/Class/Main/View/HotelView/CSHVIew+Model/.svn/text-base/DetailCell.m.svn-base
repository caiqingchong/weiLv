//
//  DetailCell.m
//  WelLv
//
//  Created by mac for csh on 15/10/10.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "DetailCell.h"

@implementation DetailCell
@synthesize lab1;
@synthesize lab2;
@synthesize lab3;
@synthesize priceLab;
@synthesize igv;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = BgViewColor;
      //  self.frame = CGRectMake(0, 0, windowContentWidth, 65);
        
        self.lab1=[[UILabel alloc] init];
        self.lab1.frame=CGRectMake(10, 7.5, windowContentWidth-20, 20);
        self.lab1.textAlignment=NSTextAlignmentLeft;
        self.lab1.adjustsFontSizeToFitWidth = YES;
        self.lab1.textColor = [UIColor blackColor];
        self.lab1.font=[UIFont systemFontOfSize:16];
        [self addSubview:self.lab1];

        self.lab2=[[UILabel alloc] init];
        self.lab2.frame=CGRectMake(10, ViewY(lab1)+ViewHeight(lab1), windowContentWidth-20, 15);
        self.lab2.textAlignment=NSTextAlignmentLeft;
        self.lab2.adjustsFontSizeToFitWidth = YES;
        self.lab2.textColor = kColor(134, 134, 134);
        self.lab2.font=[UIFont systemFontOfSize:12];
        [self addSubview:self.lab2];
        
        self.lab3=[[UILabel alloc] init];
        self.lab3.frame=CGRectMake(10, ViewY(lab2)+ViewHeight(lab2), windowContentWidth-20, 15);
        self.lab3.textAlignment=NSTextAlignmentLeft;
        self.lab3.adjustsFontSizeToFitWidth = YES;
        self.lab3.textColor = [UIColor whiteColor];
        self.lab3.backgroundColor = kColor(55, 250, 162);
        self.lab3.font=[UIFont systemFontOfSize:12];
        [self addSubview:self.lab3];
        
        
        self.priceLab=[[UILabel alloc] init];
        self.priceLab.frame=CGRectMake(windowContentWidth -110,65/2 - 25/2, 90, 25);
        self.priceLab.font=[UIFont systemFontOfSize:19];
        self.priceLab.textAlignment=NSTextAlignmentLeft;
        self.priceLab.textColor= kColor(255, 91, 38);
        [self addSubview:self.priceLab];
        
        //右侧图片
        self.igv =[[UIImageView alloc] init];
        self.igv.frame=CGRectMake(windowContentWidth -30-10, 65/2 - 30/2, 30, 30 );
        [self addSubview: self.igv];
      
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
