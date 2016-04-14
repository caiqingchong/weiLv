//
//  YXAutoEditVIew.m
//  ENKJ_OA
//
//  Created by lyx on 15-2-4.
//  Copyright (c) 2015年 NPHD. All rights reserved.
//

#import "YXAutoEditVIew.h"

@implementation YXAutoEditVIew

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (id)initWithFrame1:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        [self initLeftView];
    }
    return self;
}
- (void)initView
{
    _bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:_bgImageView];
    
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(Begin_X, 0, 80, self.frame.size.height)];
    _titleLable.adjustsFontSizeToFitWidth = YES;
    _titleLable.font = systemFont(14);
    _titleLable.textAlignment = 0;
    _titleLable.textColor = [UIColor blackColor];
    _titleLable.backgroundColor = [UIColor clearColor];
    [self addSubview:_titleLable];
    
    CGFloat width = self.frame.size.width - 2*Begin_X -(_titleLable.frame.size.width+_titleLable.frame.origin.x);
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLable.frame.size.width+_titleLable.frame.origin.x, _titleLable.frame.origin.y,width , 30)];
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = systemFont(14);
    _contentLabel.textAlignment = 0;
    _contentLabel.textColor = [UIColor grayColor];
    _contentLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_contentLabel];

    _line = [[UIView alloc] initWithFrame:CGRectMake(0, _contentLabel.frame.size.height+_contentLabel.frame.origin.y, self.frame.size.width, 0.5)];
    _line.backgroundColor = bordColor;
    [self addSubview:_line];
}

- (void)initLeftView
{
    
    _bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:_bgImageView];
    
    
    float y = (self.frame.size.height - 16)/2;
    _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(Begin_X, y, 16, 16)];
    [self addSubview:_leftImageView];
    
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(ViewWidth(_leftImageView)+ViewX(_leftImageView)+5, 0, 80, self.frame.size.height-1)];
    _titleLable.adjustsFontSizeToFitWidth = YES;
    _titleLable.font = systemFont(14);
    _titleLable.textAlignment = 0;
    _titleLable.textColor = [UIColor blackColor];
    _titleLable.backgroundColor = [UIColor clearColor];
    [self addSubview:_titleLable];
    
    CGFloat width = self.frame.size.width - 2*Begin_X -(_titleLable.frame.size.width+_titleLable.frame.origin.x);
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLable.frame.size.width+_titleLable.frame.origin.x, _titleLable.frame.origin.y,width , self.frame.size.height-1)];
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = systemFont(14);
    _contentLabel.textAlignment = 0;
    _contentLabel.textColor = [UIColor grayColor];
    _contentLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_contentLabel];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(0, _contentLabel.frame.size.height+_contentLabel.frame.origin.y, self.frame.size.width, 0.5)];
    _line.backgroundColor = bordColor;
    [self addSubview:_line];

}

- (void)setContentText:(NSString *)string
{
    if (string.length == 0 ) {
        _contentLabel.frame = CGRectMake(_contentLabel.frame.origin.x, _contentLabel.frame.origin.y, _contentLabel.frame.size.width, self.frame.size.height-1);
         _line.frame = CGRectMake(0, _contentLabel.frame.size.height+_contentLabel.frame.origin.y, self.frame.size.width, 0.5);
        return;
    }
    NSMutableAttributedString *attribtString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *parStyle = [[NSMutableParagraphStyle alloc] init];
    [parStyle setLineSpacing:5];
    [attribtString addAttribute:NSParagraphStyleAttributeName value:parStyle range:NSMakeRange(0,[string length])];
    
    CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:15.5] constrainedToSize:CGSizeMake(_contentLabel.frame.size.width-10, 10000) lineBreakMode:0];
    
     //NSLog(@"%f",size.height);

//    if (size.height > 30)
//    {
//       
//        _contentLabel.frame = CGRectMake(_contentLabel.frame.origin.x, _contentLabel.frame.origin.y, _contentLabel.frame.size.width, size.height+15);
//        
//        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, size.height+_contentLabel.frame.origin.y+15);
//       
//        _line.frame = CGRectMake(0, _contentLabel.frame.size.height+_contentLabel.frame.origin.y, self.frame.size.width, 0.5);
//    }
//    else
//    {
//        _contentLabel.frame = CGRectMake(_contentLabel.frame.origin.x, _contentLabel.frame.origin.y, _contentLabel.frame.size.width, self.frame.size.height-1);
//
//        UIImage *img = [_bgImageView.image stretchableImageWithLeftCapWidth:16 topCapHeight:10];
//        _bgImageView.frame = CGRectMake(_bgImageView.frame.origin.x,_bgImageView.frame.origin.y,_bgImageView.frame.size.width , 20 + 16);
//        _bgImageView.image = img;
//         _line.frame = CGRectMake(0, _contentLabel.frame.size.height+_contentLabel.frame.origin.y, self.frame.size.width, 0.5);
//    }
    if (size.height > 37)
    {
       
        _contentLabel.frame = CGRectMake(_contentLabel.frame.origin.x, _contentLabel.frame.origin.y, _contentLabel.frame.size.width, size.height+15);
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, size.height+_contentLabel.frame.origin.y+15);
       
        _line.frame = CGRectMake(0, _contentLabel.frame.size.height+_contentLabel.frame.origin.y, self.frame.size.width, 0.5);
    }
    else
    {
        _contentLabel.frame = CGRectMake(_contentLabel.frame.origin.x, _contentLabel.frame.origin.y, _contentLabel.frame.size.width, self.frame.size.height-1);

        UIImage *img = [_bgImageView.image stretchableImageWithLeftCapWidth:16 topCapHeight:10];
        _bgImageView.frame = CGRectMake(_bgImageView.frame.origin.x,_bgImageView.frame.origin.y,_bgImageView.frame.size.width , 20 + 16);
        _bgImageView.image = img;
         _line.frame = CGRectMake(0, _contentLabel.frame.size.height+_contentLabel.frame.origin.y, self.frame.size.width, 0.5);
    }
     _contentLabel.attributedText = attribtString;
}

@end
