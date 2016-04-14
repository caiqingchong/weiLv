//
//  TravelChangeCountView.h
//  bottomView
//
//  Created by 张子乾 on 16/1/21.
//  Copyright © 2016年 张子乾. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravelChangeCountView : UIImageView<UITextFieldDelegate>

//背景框
@property (nonatomic, strong) UIImageView *backImageView;
//加
@property (nonatomic, strong) UIImageView *addView;
//减
@property (nonatomic, strong) UIImageView *minusView;
//数目
@property (nonatomic, strong) UITextField *countTextField;

//完成按钮
@property (nonatomic, strong) UIBarButtonItem *doneButton;

-(id)initWithFrame:(CGRect)frame and:(NSString *)type;

@end
