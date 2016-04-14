//
//  VisaCommentCell.m
//  WelLv
//
//  Created by 张发杰 on 15/4/11.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "VisaCommentCell.h"

@implementation VisaCommentCell


//@property (nonatomic, strong) UILabel *userNameLabel;
//@property (nonatomic, strong) UILabel *visaTapy;
//@property (nonatomic, assign) NSInteger starNumber;
//@property (nonatomic, strong) UILabel *chooesCommentLabel;
//@property (nonatomic, strong) UILabel *commentTextLabel;
//@property (nonatomic, strong) UILabel *timeLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView * userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
        [self.contentView addSubview:userIcon];
        self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(userIcon.frame.origin.x + userIcon.frame.size.width + 5, 5, 200, 20)];
        self.userNameLabel.text = @"15469875";
        self.userNameLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_userNameLabel];
        
        self.visaTapy = [[UILabel alloc] initWithFrame:CGRectMake(windowContentWidth - 70, 5, 60, 20)];
        self.visaTapy.textAlignment = NSTextAlignmentCenter;
        self.visaTapy.layer.cornerRadius = 5.0;
        self.visaTapy.layer.masksToBounds = YES;
        self.visaTapy.backgroundColor = [UIColor grayColor];
        self.visaTapy.font = [UIFont systemFontOfSize:12];
        self.visaTapy.text = @"旅游签证";
        [self addSubview:self.visaTapy];
        
        for (int i = 0; i < 3; i++) {
            UIImageView * starIcon = [[UIImageView alloc] initWithFrame:CGRectMake(20 * i, self.userNameLabel.frame.origin.y + self.userNameLabel.frame.size.height, 20, 20)];
            starIcon.backgroundColor = [UIColor grayColor];
            [self addSubview:starIcon];
        }
        
        self.chooesCommentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, windowContentWidth + 20, 10)];
        self.chooesCommentLabel.textColor = [UIColor grayColor];
        self.chooesCommentLabel.numberOfLines = 0;
        self.chooesCommentLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_chooesCommentLabel];
        
        self.commentTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.chooesCommentLabel.frame.origin.y + _chooesCommentLabel.frame.size.height, windowContentWidth - 20, 100)];
        self.commentTextLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_commentTextLabel];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(windowContentWidth - 100, self.commentTextLabel.frame.size.height + _commentTextLabel.frame.origin.y, 90, 20)];
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.text = @"2015-04-11";
        [self addSubview:_timeLabel];
        
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
