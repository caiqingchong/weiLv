//
//  HotelListRightCell.m
//  WelLv
//
//  Created by 吴伟华 on 15/11/20.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "HotelListRightCell.h"

@interface HotelListRightCell ()
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UIImageView *selectImageView;

@end
@implementation HotelListRightCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 11, windowContentWidth * 2/ 3.0 - 50, 20)];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.nameLabel];
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        self.selectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth * 2/ 3.0 - 30, 11, 20, 20)];
        self.selectImageView.image = [UIImage imageNamed:@"筛选条件未选中"];
        
        [self.contentView addSubview:self.selectImageView];
    }
    return self;
    
}
-(void)setName:(NSString *)name
{
    _name = name;
    
    self.nameLabel.text = _name;
}

-(void)setImageSelect:(BOOL)imageSelect
{
    if (imageSelect) {
    self.selectImageView.image = [UIImage imageNamed:@"筛选条件选中"];
    }
    else
    {
    self.selectImageView.image = [UIImage imageNamed:@"筛选条件未选中"];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
