//
//  YXTraveAutoView.m
//  WelLv
//
//  Created by lyx on 15/4/23.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "YXTraveAutoView.h"

@implementation YXTraveAutoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    _bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:_bgImageView];
    
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    _titleLable.adjustsFontSizeToFitWidth = YES;
    _titleLable.font = systemFont(13);
    _titleLable.textAlignment = 0;
    _titleLable.textColor = TimeGreenColor;
    _titleLable.backgroundColor = [UIColor clearColor];
    [self addSubview:_titleLable];
    
    CGFloat width = self.frame.size.width - 2*Begin_X -(_titleLable.frame.size.width+_titleLable.frame.origin.x);
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLable.frame.size.width+_titleLable.frame.origin.x, _titleLable.frame.origin.y,width , 20)];
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = systemFont(13);
    _contentLabel.textAlignment = 0;
    _contentLabel.textColor = TimeGreenColor;
    _contentLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_contentLabel];

}

- (void)setContentText:(NSString *)string
{
    if (string.length == 0 ) {
        _contentLabel.frame = CGRectMake(_contentLabel.frame.origin.x, _contentLabel.frame.origin.y, _contentLabel.frame.size.width, self.frame.size.height);
        return;
    }
    NSMutableAttributedString *attribtString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *parStyle = [[NSMutableParagraphStyle alloc] init];
    [parStyle setLineSpacing:5];
    [attribtString addAttribute:NSParagraphStyleAttributeName value:parStyle range:NSMakeRange(0,[string length])];
    
    CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(_contentLabel.frame.size.width, 10000) lineBreakMode:0];
    
    
    if (size.height > 20)
    {
        _contentLabel.frame = CGRectMake(_contentLabel.frame.origin.x, _contentLabel.frame.origin.y, _contentLabel.frame.size.width, size.height);
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, size.height);
    }
    else
    {
        _contentLabel.frame = CGRectMake(_contentLabel.frame.origin.x, _contentLabel.frame.origin.y, _contentLabel.frame.size.width, self.frame.size.height);
        UIImage *img = [_bgImageView.image stretchableImageWithLeftCapWidth:16 topCapHeight:10];
        _bgImageView.frame = CGRectMake(_bgImageView.frame.origin.x,_bgImageView.frame.origin.y,_bgImageView.frame.size.width , 20 + 10);
        _bgImageView.image = img;
        
    }
    _contentLabel.attributedText = attribtString;
}


@end
