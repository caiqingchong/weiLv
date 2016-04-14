//
//  WLResultView.h
//  WelLv
//
//  Created by 赵阳 on 16/1/1.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QuestionnaireResultDelegate <NSObject>

- (void)didClickedResultView;

- (void)pushToSubmitTest;

@end

@interface WLResultView : UIView

@property(weak, nonatomic) id<QuestionnaireResultDelegate> delegate;

@property(weak, nonatomic) UIImageView *expressionImageView;

@property(weak, nonatomic) UILabel *resultLabel;

@property(weak, nonatomic) UILabel *hintLabel;

@property(weak, nonatomic) UIButton *pushBtn;

@property(weak, nonatomic) UIImageView *noDataImage;//无数据时显示的图片

- (void)setContentWithExpression:(UIImage *)expression content:(NSString *)content userType:(NSInteger)userType status:(NSInteger)status andContentType:(NSInteger)type;

@end
