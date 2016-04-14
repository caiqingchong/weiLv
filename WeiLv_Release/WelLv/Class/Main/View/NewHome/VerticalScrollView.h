//
//  VerticalScrollView.h
//  ScrollView
//
//  Created by Qianchuang on 15/11/3.
//  Copyright © 2015年 Qianchuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VerticalScrollViewDelegate <NSObject>
@optional
- (void)verticalScrollViewDidSelectedRow:(NSInteger)row;

@end

@interface VerticalScrollView : UIScrollView

@property (strong, nonatomic) NSArray *titleArray;
@property (assign, nonatomic) id <VerticalScrollViewDelegate> Verdelegate;

@end
