//
//  CSSearchBar.h
//  WelLv
//
//  Created by nick on 16/3/11.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MARGIN_WIDTH 10.0

#define MARGIN_HEIGHT 10.0

#define SEARCH_BAR_TYPE_VIEW_HEIGHT 35.0

typedef NS_ENUM(NSInteger, SearchBarType){

    SearchBarTypeView = 0,
    
    SearchBarTypeTextField
};

@interface CSSearchBar : UIView

@property(assign, nonatomic) SearchBarType type;

@property(strong, nonatomic) NSString *placeholder;

/**
 * 初始化搜索栏
 *
 * @params - frame:搜索框尺寸值; type: 搜索框类型; placeholder: 默认显提示文本.
 */
- (instancetype)initWithFrame:(CGRect)frame SearchBarType:(SearchBarType)type andPlaceholder:(NSString *)placeholder;

@end
