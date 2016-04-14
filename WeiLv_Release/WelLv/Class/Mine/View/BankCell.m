//
//  BankCell.m
//  WelLv
//
//  Created by mac for csh on 15/11/19.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "BankCell.h"

@implementation BankCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        self.backgroundColor = [UIColor whiteColor];
        
        _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(25, 5, 35, 35)];
        //[_imageV sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"默认图2"]];
        [self addSubview:_imageV];
       
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(_imageV) + ViewWidth(_imageV)+10  , 0, windowContentWidth -25-35  , 45)];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_nameLabel];
 
        
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
