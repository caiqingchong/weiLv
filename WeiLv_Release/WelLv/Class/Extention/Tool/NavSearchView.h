//
//  NavSearchView.h
//  WelLv
//
//  Created by lyx on 15/4/7.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NavSearchViewDelegate <NSObject>
@optional
- (void)beginEdit;
- (void)cancalEdit;
- (void)beginSearch:(NSString *)text;
@end

@interface NavSearchView : UIView<UITextFieldDelegate>
{
    UITextField *_searchBar;
    UIButton *_cancalBtn;
}
- (void)cancelSearch;
@property (nonatomic,strong)UITextField *searchBar;
@property (nonatomic,strong)UIImageView *leftview;
@property (nonatomic,strong) UIButton *cancalBtn;
@property (nonatomic,weak)id <NavSearchViewDelegate>delegate;
- (id)initWithFrame:(CGRect)frame Feature:(NSString *)placeholder;
@end
