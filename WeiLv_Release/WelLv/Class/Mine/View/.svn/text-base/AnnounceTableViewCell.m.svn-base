//
//  AnnounceTableViewCell.m
//  WelLv
//
//  Created by mac for csh on 15/9/6.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "AnnounceTableViewCell.h"
#import "LXCommonTools.h"

@implementation AnnounceTableViewCell
@synthesize timeLab,contentLab;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    
        self.timeLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, windowContentWidth - 15*2, 25)];
        self.timeLab.font = [UIFont systemFontOfSize:15];
        self.timeLab.textColor = [UIColor blackColor];
        self.timeLab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.timeLab];
        
        self.contentLab = [[UILabel alloc] initWithFrame:CGRectMake(15, ViewY(self.timeLab)+ViewHeight(self.timeLab), windowContentWidth - 15*2, 35)];
        self.contentLab.font = [UIFont systemFontOfSize:15];
        self.contentLab.textColor = [UIColor grayColor];
        self.contentLab.textAlignment = NSTextAlignmentLeft;
       // self.contentLab.numberOfLines = 2;
        [self addSubview:self.contentLab];
//       CGFloat hgt = [[LXCommonTools sharedMyTools] textHeight:contentLab.text Afont:15 width:ViewWidth(contentLab)];
//        NSLog(@"str = %@\nhgt = %f",contentLab.text,hgt);
//        if (hgt>10) {
//            self.contentLab.numberOfLines = 2;
//        }else{
//            self.contentLab.numberOfLines = 1;
//        }
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
