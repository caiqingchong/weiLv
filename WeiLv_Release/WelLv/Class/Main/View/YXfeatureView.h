//
//  YXfeatureView.h
//  WelLv
//
//  Created by lyx on 15/4/3.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@protocol YXfeatureDelegate <NSObject>
@optional
-(void)selectFeature:(NSUInteger)index;
@end
@interface YXfeatureView : UIView
{
    UIScrollView *_scrollView;
    NSMutableArray *_featureArr;
}
- (id)initWithFrame:(CGRect)frame Feature:(NSMutableArray *)feature;
@property (nonatomic,weak)id<YXfeatureDelegate> delegate;
@end
