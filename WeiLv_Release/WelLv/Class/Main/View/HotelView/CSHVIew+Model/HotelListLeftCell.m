//
//  HotelListLeftCell.m
//  WelLv
//
//  Created by 吴伟华 on 15/11/20.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "HotelListLeftCell.h"

@interface HotelListLeftCell ()
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UIImageView *selectImageView;

@end
@implementation HotelListLeftCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 11, 80, 20)];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.nameLabel];
         self.contentView.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
        UIView *whitView = [[UIView alloc] init];
        whitView.backgroundColor = [UIColor whiteColor];
        self.selectedBackgroundView = whitView;
        self.selected = NO;
        self.selectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(17, 18, 8, 8)];
        self.selectImageView.image = [UIImage imageNamed:@"价格区间圆点"];
        self.selectImageView.hidden = YES;
        [self.contentView addSubview:self.selectImageView];
    }
    return self;

}
-(void)setName:(NSString *)name
{
    _name = name;
    
    self.nameLabel.text = _name;
}

 -(void)setSelected:(BOOL)selected
{
    self.selectImageView.hidden = !selected;
}
@end
