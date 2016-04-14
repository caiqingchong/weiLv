//
//  ProgressView.m
//  WelLv
//
//  Created by James on 16/1/19.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "ProgressView.h"

@implementation ProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        _percent = 0;
        _width = 0;
    }
    
    return self;
}

- (void)setPercent:(float)percent
{
    _percent = percent;
    [self setNeedsDisplay];
}
-(void)setWidth:(float)width
{
    _width=width;
    [self setNeedsDisplay];
}
-(void)setTotalMoeny:(float)totalMoeny
{
    _totalMoeny=totalMoeny;
    [self setNeedsDisplay];
}
#pragma mark - 绘制图形
- (void)drawRect:(CGRect)rect
{
    //绘制外圆弧
    [self addArcOutCircle];
    
    //绘制圆弧比例图
    [self drawArc];
    
    //绘制中心圆
    [self addCenterCircle];
    
    //绘制中心圆上的文字
    [self addCenterLabel];
    
    
}


#pragma mark - 绘制中心圆
-(void)addCenterCircle
{
    float startAngle=RADIANS_TO_DEGREES(2*M_PI);
    
    //设置圆弧宽度
    float width = (_width == 0) ? 5 : _width;
    
    //设置圆弧颜色
    CGColorRef color = (_centerColor == nil) ? [UIColor whiteColor].CGColor : _centerColor.CGColor;
    
    //设置上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    //设置圆弧大小尺寸
    CGSize viewSize = self.bounds.size;
    
    //设置圆弧中心坐标
    CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
    
    //设置圆弧半径
    CGFloat radius = viewSize.width / 2 - width;
    
    //设置绘制上下文开始路径
    CGContextBeginPath(contextRef);
    
    //以圆弧中心坐标为圆心开始绘制
    CGContextMoveToPoint(contextRef, center.x, center.y);
    
    //绘制圆弧弧度
    CGContextAddArc(contextRef, center.x, center.y,radius,0,2*M_PI,0);
    
    //填充圆弧颜色
    CGContextSetFillColorWithColor(contextRef, color);
    
    //绘制圆弧完毕
    CGContextFillPath(contextRef);
}


#pragma mark - 绘制中心圆上的文字
- (void)addCenterLabel
{
    //创建总金额标题
    float fontSizes=18;
    NSString *totalMsg=@"总金额(元)";
    UIColor *arcColors=[YXTools stringToColor:@"#777b7e"];
    CGSize viewSizes = self.bounds.size;
    NSMutableParagraphStyle *paragraphs = [[NSMutableParagraphStyle alloc] init];
    paragraphs.alignment = NSTextAlignmentCenter;
    NSDictionary *attributess = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSizes],NSFontAttributeName,arcColors,NSForegroundColorAttributeName,[UIColor clearColor],NSBackgroundColorAttributeName,paragraphs,NSParagraphStyleAttributeName,nil];
    [totalMsg drawInRect:CGRectMake(5, (viewSizes.height-fontSizes)/2-30, viewSizes.width-10, fontSizes+10)withAttributes:attributess];
    
    //创建总金额
    float fontSize = 20;
    NSString *percent = [NSString stringWithFormat:@"%.2f",_totalMoeny];
    UIColor *arcColor=[YXTools stringToColor:@"#ff6600"];
    CGSize viewSize = self.bounds.size;
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:fontSize],NSFontAttributeName,arcColor,NSForegroundColorAttributeName,[UIColor clearColor],NSBackgroundColorAttributeName,paragraph,NSParagraphStyleAttributeName,nil];
    [percent drawInRect:CGRectMake(5, (viewSize.height-fontSize)/2, viewSize.width-10, fontSize)withAttributes:attributes];
    
}

#pragma mark - 绘制外圆弧
- (void)addArcOutCircle
{
    
    CGColorRef color = (_arcBackColor == nil) ? [UIColor lightGrayColor].CGColor : _arcBackColor.CGColor;
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    CGSize viewSize = self.bounds.size;
    
    CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
    
  
    CGFloat radius =viewSize.width / 2;
    
    CGContextBeginPath(contextRef);
    
    CGContextMoveToPoint(contextRef, center.x, center.y);
    
    CGContextAddArc(contextRef, center.x, center.y,radius,0,2*M_PI, 0);
    
    CGContextSetFillColorWithColor(contextRef, color);
    
    CGContextFillPath(contextRef);
    
    
    
}

#pragma mark - 绘制圆弧比例图
- (void)drawArc
{
    if (_percent == 0 || _percent > 1)
    {
        return;
    }

    if (_percent == 1)
    {
        
        CGColorRef color = (_arcFinishColor == nil) ? [UIColor greenColor].CGColor : _arcFinishColor.CGColor;
        
        CGContextRef contextRef = UIGraphicsGetCurrentContext();
        
        CGSize viewSize = self.bounds.size;
        
        CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
        
        CGFloat radius = viewSize.width / 2;
        
        CGContextBeginPath(contextRef);
        
        CGContextMoveToPoint(contextRef, center.x, center.y);
        
        CGContextAddArc(contextRef, center.x, center.y, radius,0,2*M_PI, 0);
        
        CGContextSetFillColorWithColor(contextRef, color);
        
        CGContextFillPath(contextRef);
    }
    else
    {
        
        float endAngle = 2*M_PI*_percent;
        
        float startAngle=RADIANS_TO_DEGREES(endAngle);
        
        CGColorRef color = (_arcUnfinishColor == nil) ? [UIColor blueColor].CGColor : _arcUnfinishColor.CGColor;
        
        CGContextRef contextRef = UIGraphicsGetCurrentContext();
        
        CGSize viewSize = self.bounds.size;
        
        CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
        
    
        CGFloat radius = viewSize.width / 2;
        
        CGContextBeginPath(contextRef);
        
        CGContextMoveToPoint(contextRef, center.x, center.y);
        
        CGContextAddArc(contextRef, center.x, center.y, radius,-M_PI_2+(startAngle/2/180*M_PI),-M_PI_2-(startAngle/2/180*M_PI),0);
        
        CGContextSetFillColorWithColor(contextRef, color);
        
        CGContextFillPath(contextRef);
    }
    
}



@end
