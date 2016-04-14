//
//  QuestionnaireCollectionReusableView.h
//  WelLv
//
//  Created by 赵阳 on 16/1/1.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QuestionnaireReusableViewDelegate <NSObject>

- (void)didSelectedAreaButtonWithTag:(NSInteger)tag;

@end

@interface WLQuestionnaireCollectionReusableView : UICollectionReusableView

@property(weak, nonatomic) id<QuestionnaireReusableViewDelegate> delegate;

@property(weak, nonatomic) UILabel *titleLabel;

@property(weak, nonatomic) UILabel *domesticBtn;

@property(weak, nonatomic) UILabel *abroadBtn;

/**
 * 设置标题
 *
 * @param - content: 标题内容; type: 内容类型.
 */
- (void)setContent:(NSString *)content andContentType:(NSInteger)type;

@end
