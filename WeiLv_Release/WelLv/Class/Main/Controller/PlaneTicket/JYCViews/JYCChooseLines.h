//
//  JYCChooseLines.h
//  WelLv
//
//  Created by lyx on 15/9/21.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ChooseRow)(NSInteger row);
typedef void(^ChooseRowArray)(NSArray * arr);

@interface JYCChooseLines : UIView

@property (nonatomic, assign) NSInteger defaultLineNum; //默认选中某行,  默认第0行; (从0开始）
@property (nonatomic, assign) BOOL multiRow;            //是否可以选择多行, 默认不可以;
@property (nonatomic, assign) NSInteger canChooseRow;  //可以选中的行数, 默认只可以选中多行;
//@property(nonatomic,strong)NSMutableArray *contentArr;
@property(nonatomic,strong)UIImageView * chooseIcon;
- (id)initWithFrame:(CGRect)frame withChooseLineArray:(NSArray *)lineArr;

- (void)chooseOneRow:(ChooseRow)chooseRow;

- (void)chooseRowArr:(ChooseRowArray)arr;




@end
