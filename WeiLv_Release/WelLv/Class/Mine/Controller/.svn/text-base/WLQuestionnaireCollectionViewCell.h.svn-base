//
//  QuestionnaireCollectionViewCell.h
//  WelLv
//
//  Created by 赵阳 on 16/1/1.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QuestionnaireChooseDelegate <NSObject>

- (void)didSelectedOptionWithIndexPath:(NSIndexPath *)indexPath optionData:(NSDictionary *)data andSelectStates:(NSInteger)states;

@end

@interface WLQuestionnaireCollectionViewCell : UICollectionViewCell

@property(weak, nonatomic) id<QuestionnaireChooseDelegate> delegate;

@property(weak, nonatomic) UILabel *placeNameLabel;

@property(weak, nonatomic) UIImageView *placeImageView;

@property(weak, nonatomic) UILabel *placeBriefLabel;

@property(weak, nonatomic) UIView *chooseView;

@property(weak, nonatomic) UIView *visitedView;

@property(weak, nonatomic) UIView *wantedView;

@property(weak, nonatomic) UIImageView *visitedIcon;

@property(weak, nonatomic) UIImageView *wantedIcon;

- (void)setContentWithArray:(NSArray *)content indexPath:(NSIndexPath *)indexPath contentType:(NSInteger)type selectStates:(BOOL)isSelected andSelectedOption:(NSString *)option;

@end
