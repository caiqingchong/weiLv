//
//  WLSteFunctionCell.h
//  WelLv
//
//  Created by zhangjie on 15/12/5.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ClickItem)(NSIndexPath * index);

@interface WLSteFunctionCell : UITableViewCell

@property (nonatomic, copy) NSArray * iconArr;
@property (nonatomic, copy) NSArray * titleArr;

- (void)clickFunctionItem:(ClickItem)item;

@end
