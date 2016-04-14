//
//  VerticalScrollView.m
//  ScrollView
//
//  Created by Qianchuang on 15/11/3.
//  Copyright © 2015年 Qianchuang. All rights reserved.
//

#import "VerticalScrollView.h"

@interface VerticalScrollView () <UIScrollViewDelegate>

@property (strong, nonatomic) NSTimer *mTimer;

@end

@implementation VerticalScrollView

- (void)dealloc
{
    [_mTimer invalidate];
    self.mTimer = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.pagingEnabled = YES;
    self.scrollEnabled = NO;
    self.delegate = self;
}

- (void)setTitleArray:(NSArray *)titleArray
{
    if (_titleArray != titleArray) {
        _titleArray = titleArray;
    }
    NSString *firstObject = [_titleArray firstObject];
    NSString *lastObject = [_titleArray lastObject];
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:lastObject, nil];
    [array addObjectsFromArray:_titleArray];
    [array addObject:firstObject];
    
    self.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height*array.count);
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    for (int i = 0; i < array.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0 + 10, self.frame.size.height*i, self.frame.size.width -10 , self.frame.size.height)];
        label.text = [array objectAtIndex:i];
        label.font = [UIFont systemFontOfSize : 13];
        label.textColor = kColor(110, 115, 119);
        label.tag = i;
        label.userInteractionEnabled = YES;
        [self addSubview:label];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        [label addGestureRecognizer:tap];
    }
    
    [self setContentOffset:CGPointMake(0, self.frame.size.height)];
    //滑动时间
    _mTimer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(timerScheduledAction:) userInfo:nil repeats:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y >= ((_titleArray.count+2)-1)*self.frame.size.height) {
        scrollView.contentOffset = CGPointMake(0, self.frame.size.height);
    }
    if (scrollView.contentOffset.y <= 0) {
        scrollView.contentOffset = CGPointMake(0, ((_titleArray.count+2)-2)*self.frame.size.height);
    }
}

- (void)tapGestureAction:(UITapGestureRecognizer *)tapGesture
{
    NSInteger row;
    if (tapGesture.view.tag == 0) {
        row = _titleArray.count - 1;
    }else if(tapGesture.view.tag == _titleArray.count + 1){
        row = 0;
    }else{
        row = tapGesture.view.tag - 1;
    }
    
    if (_Verdelegate && [_Verdelegate respondsToSelector:@selector(verticalScrollViewDidSelectedRow:)]) {
        [_Verdelegate verticalScrollViewDidSelectedRow:row];
    }
}

- (void)timerScheduledAction:(NSTimer *)timer
{
    [self setContentOffset:CGPointMake(self.contentOffset.x, self.contentOffset.y+self.frame.size.height) animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
