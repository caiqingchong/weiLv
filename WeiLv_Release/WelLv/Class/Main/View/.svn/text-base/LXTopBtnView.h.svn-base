//
//  LXTopBtnView.h
//  WelLv
//
//  Created by 刘鑫 on 15/4/7.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LXTopBtnViewDelegate <NSObject>
@optional
-(void)selectBtn:(NSUInteger)index;
@end

@interface LXTopBtnView : UIView
{
    NSMutableArray *_nameArray;
    NSMutableArray *_imageArray;
}

- (id)initWithFrame:(CGRect)frame nameArray:(NSMutableArray *)name ImageArray:(NSMutableArray *)image;

@property (nonatomic,weak)id<LXTopBtnViewDelegate> delegate;
@end
