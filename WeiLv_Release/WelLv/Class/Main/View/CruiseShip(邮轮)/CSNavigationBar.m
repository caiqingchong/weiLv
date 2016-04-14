//
//  CSNavigationBar.m
//  WelLv
//
//  Created by nick on 16/3/8.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "CSNavigationBar.h"

@implementation CSNavigationBar

- (instancetype)initWithStyle:(CSNavBarStyle)navBarstyle leftItemSize:(CGSize)leftSize rightItemSize:(CGSize)rightSize andContents:(NSArray *)contents {

    self = [super init];
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, NAV_BAR_HEIGHT);
    
    switch(navBarstyle){
    
        case CSNavBarStyleNormal:{
         
            UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1)];
            
            bottomLine.backgroundColor = kColor(212.0, 212.0, 212.0);
            
            [self addSubview:bottomLine];
            
            self.backgroundColor = [UIColor whiteColor];
        }
            
            break;
            
        case CSNavBarStyleTransparent:
            
            self.backgroundColor = [UIColor clearColor];
            
            break;
            
        case CSNavBarStyleOrder:
            
            self.backgroundColor = [UIColor colorWithRed:75.0/255.0 green:91.0/255.0 blue:105.0/255.0 alpha:1];
            
            break;
    }
    
    self.navBarStyle = navBarstyle;

    self.leftSize = leftSize;
    
    self.rightSize = rightSize;
    
    self.leftContent = [contents objectAtIndex:0];
    
    self.titleContent = [contents objectAtIndex:1];
    
    self.rightContent = [contents objectAtIndex:2];
    
    [self setLayout];
    
    return self;
}

- (void)setLayout {
    
    //状态栏
    self.statusBar = [UIView new];
    
    self.statusBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, STATUS_BAR_HEIGHT);
    
    self.statusBar.backgroundColor = [UIColor clearColor];
    
    [self addSubview:_statusBar];
    
    //导航栏左侧按钮
    if(self.leftContent){
    
        if([self.leftContent isMemberOfClass:[UIImage class]]){
            
            UIImageView *leftItem = [[UIImageView alloc] initWithFrame:CGRectMake(21, CGRectGetMaxY(self.statusBar.frame) + (NAV_BAR_HEIGHT - STATUS_BAR_HEIGHT - self.leftSize.height) / 2, self.leftSize.width, self.leftSize.height)];
            
            leftItem.image = self.leftContent;
            
            [self addSubview:leftItem];
            
            self.leftItem = leftItem;
        }
    }
    
    //导航栏右侧按钮
    if(self.rightContent){
        
        if([self.rightContent isMemberOfClass:[UIImage class]]){
        
            UIImageView *rightItem = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 21 - self.rightSize.width, CGRectGetMaxY(self.statusBar.frame) + (NAV_BAR_HEIGHT - STATUS_BAR_HEIGHT - self.leftSize.height) / 2, self.rightSize.width, self.rightSize.height)];
            
            rightItem.image = self.rightContent;
            
            [self addSubview:rightItem];
            
            self.rightItem = rightItem;
        }
    }
    
    //导航栏标题
    if(self.titleContent){
        
        CGFloat width;
        
        if([self.rightContent isKindOfClass:[NSNull class]]){
        
            width = self.frame.size.width - CGRectGetMaxX([self.leftItem frame]) - (self.frame.size.width - [self.rightItem frame].origin.x) - 30;
            
        }else{
            
            width = self.frame.size.width - CGRectGetMaxX([self.leftItem frame]) * 2 - 30;
        }
        
        UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX([self.leftItem frame]) + 15, CGRectGetMaxY(self.statusBar.frame), width, NAV_BAR_HEIGHT - CGRectGetMaxY(self.statusBar.frame))];
        
        titleView.text = self.titleContent;
        
        titleView.textAlignment = NSTextAlignmentCenter;
        
        titleView.font = [UIFont systemFontOfSize:17 weight:bold];
        
        if(self.navBarStyle == CSNavBarStyleOrder){
        
            titleView.textColor = [UIColor whiteColor];
            
        }else{
        
            titleView.textColor = [UIColor blackColor];
        }
        
        [self addSubview:titleView];
    }
}

@end








