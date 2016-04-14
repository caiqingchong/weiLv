//
//  LXStudyTourView.h
//  WelLv
//
//  Created by 刘鑫 on 15/8/14.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//


#import <UIKit/UIKit.h>
typedef enum{
    HotCountry,
    Theme//主题
}ShowType;


@protocol LXStudyTourDelegate <NSObject>
@optional
-(void)selectHotCountry:(NSUInteger)index;
-(void)selectTheme:(NSUInteger)index;
@end

@interface LXStudyTourView : UIView
{
    
}
@property (nonatomic,assign) ShowType showType;

-(id)initWithFrame:(CGRect)frame showType:(ShowType)type data:(NSMutableArray *)dataArray;
@property(nonatomic,weak)id <LXStudyTourDelegate> delegate;
@end
