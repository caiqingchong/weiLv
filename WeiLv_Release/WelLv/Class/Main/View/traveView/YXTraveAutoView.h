//
//  YXTraveAutoView.h
//  WelLv
//
//  Created by lyx on 15/4/23.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXTraveAutoView : UIView
{
    UIImageView *_bgImageView;
    UILabel     *_titleLable;
    UILabel     *_contentLabel;
    UIView      *_line;
}
@property (nonatomic,readonly) UIImageView *bgImageView;
@property (nonatomic,readonly) UILabel     *titleLable;
@property (nonatomic,readonly) UILabel     *contentLabel;
@property (nonatomic,readonly) UIView *line;

- (void)setContentText:(NSString *)string;
@end
