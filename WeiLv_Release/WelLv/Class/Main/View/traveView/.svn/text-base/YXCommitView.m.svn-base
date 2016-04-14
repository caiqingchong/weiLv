//
//  YXCommitView.m
//  WelLv
//
//  Created by lyx on 15/4/20.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "YXCommitView.h"

@implementation YXCommitView
@synthesize leftImageVIew = _leftImageVIew;
@synthesize houseName = _houseName,date = _date,content = _content;

- (id)initWithFrame:(CGRect)frame commentArr:(NSArray *)arr
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        if (arr.count==0)
        {
            [self showNullView];
        }else
        {
           [self initView];
        }
    }
    return self;
}
- (void)showNullView
{
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, windowContentWidth, 497/2)];
    bgImage.contentMode = UIViewContentModeScaleAspectFit;
    bgImage.backgroundColor = [UIColor whiteColor];
    bgImage.image = [UIImage imageNamed:@"没找到相关内容"];
    [self addSubview:bgImage];
}
- (void)initView
{
    _leftImageVIew = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 15, 15)];
    _leftImageVIew.image = [UIImage imageNamed:@"data1"];
    [self addSubview:_leftImageVIew];
    
    _houseName = [[UILabel alloc] initWithFrame:CGRectMake(_leftImageVIew.frame.origin.x + _leftImageVIew.frame.size.width + 5, 5, 200, 20)];
    _houseName.text = @"南笙";
    _houseName.font = [UIFont systemFontOfSize:12];
    [self addSubview:_houseName];
    
    _date = [[UILabel alloc] initWithFrame:CGRectMake(windowContentWidth - 80, 5, 70, 20)];
    _date.textColor = [UIColor grayColor];
    _date.font = [UIFont systemFontOfSize:12];
    _date.textAlignment = NSTextAlignmentCenter;
    _date.text = @"2015-04-11";
    [self addSubview:_date];
    
    _content = [[UILabel alloc] initWithFrame:CGRectMake(10, _houseName.frame.origin.y + _houseName.frame.size.height, windowContentWidth - 20, 100)];
    _content.font = [UIFont systemFontOfSize:12];
    _content.numberOfLines = 0;
    _content.text = @"客服虽然很忙，但是有问必答，真的很有耐心，签证也很快，我拍正常签证，3天就签了，一出签就寄回来了，服务很好，下次还会再来！客服虽然很忙，但是有问必答，真的很有耐心，签证也很快，我拍正常签证，3天就签了，一出签就寄回来了，服务很好，下次还会再来！";
    CGFloat textY = _houseName.frame.origin.y + _houseName.frame.size.height;
    _content.frame = CGRectMake(10, textY, windowContentWidth - 20, [YXTools returnTextCGRectText:_content.text textFont:12].size.height);
    //self.commentTextLabel.backgroundColor = [UIColor orangeColor];
    [self addSubview:_content];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(_content)+ViewY(_content), windowContentWidth, 0.5)];
    line.backgroundColor = bordColor;
    [self addSubview:line];
}



@end


@implementation YXSelectBtn
@synthesize leftView = _leftView;
@synthesize title = _title;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _leftView = [[UIImageView alloc] initWithFrame:CGRectMake(5, (ViewHeight(self)-25)/2, 25, 25)];
        _leftView.backgroundColor = [UIColor clearColor];
        [self addSubview:_leftView];
        
        _title = [YXTools allocLabel:@"" font:systemFont(14) textColor:[UIColor blackColor] frame:CGRectMake(ViewX(_leftView)+ViewWidth(_leftView)+5, 0, 150, self.frame.size.height) textAlignment:0];
        [self addSubview:_title];
        
        UIImageView *arrowMarkTime = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth - 40, (ViewHeight(self)-30)/2 +5, 30, 20)];
        arrowMarkTime.contentMode = UIViewContentModeScaleAspectFit;
        arrowMarkTime.image = [UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"];
        [self addSubview:arrowMarkTime];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, windowContentWidth, 0.5)];
        line.backgroundColor = bordColor;
        [self addSubview:line];
        
    }
    return self;
}

@end
