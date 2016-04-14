//
//  SearchViewTopView.h
//  weilvTest1
//
//  Created by 刘鑫 on 15/7/9.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^changeSeachTypeBlock) (NSInteger type);
typedef void (^searchKeyordsBlock) (NSString *keywords);
@interface SearchViewTopView : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UIView      *_maskView;
    BOOL        _isShow;
    UIButton    *_typeBtn;
    UIView *_line;
    UITableView *_typeTabView;
    NSMutableArray     *_typeArray;
}
@property ( nonatomic , strong ) UITextField * searchTF;
@property (nonatomic, strong) UIImageView * chooseIcon;
@property ( nonatomic , strong ) changeSeachTypeBlock typeBlock;//返回选择的搜索类型
@property ( nonatomic , strong ) searchKeyordsBlock keywordsBlock;

+ (SearchViewTopView *)sharedSearchTopView;
-(id)initWithFrame:(CGRect)frame placeholderStr:(NSString *)placeholder searchType:(NSString *)type nameArr:(NSArray *)arr;

/**
 *  隐藏搜索类型列表
 */
-(void)deleteMask;

@end
