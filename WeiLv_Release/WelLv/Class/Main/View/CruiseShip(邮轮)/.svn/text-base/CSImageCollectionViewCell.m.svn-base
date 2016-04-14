//
//  CSImageCollectionViewCell.m
//  WelLv
//
//  Created by 吴伟华 on 16/3/16.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "CSImageCollectionViewCell.h"
@interface CSImageCollectionViewCell ()
@property (nonatomic,strong)UIImageView *imageVeiw;
@end
@implementation CSImageCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageVeiw = [[UIImageView alloc] initWithFrame:frame];
        //self.imageVeiw.backgroundColor = [UIColor redColor];
        [self addSubview:self.imageVeiw];
    }
    return self;
}

-(void)setImageStr:(NSString *)imageStr
{
    [self.imageVeiw setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"default_bg_view_750_400"]];

}
@end
