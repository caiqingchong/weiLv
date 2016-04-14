//
//  WLSubmitView.h
//  WelLv
//
//  Created by 赵阳 on 16/1/1.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SubmitQuestionnaireDelegate <NSObject>

- (void)didClickedSubmitView;

@end

@interface WLSubmitView : UIView

@property(weak, nonatomic) id<SubmitQuestionnaireDelegate> delegate;

@end
