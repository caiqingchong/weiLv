//
//  ZFJFilterDetailView.m
//  WelLv
//
//  Created by WeiLv on 15/11/5.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJFilterDetailView.h"

@interface ZFJFilterDetailView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) ZFJFilterDetailStyle style;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * blurView;
@property (nonatomic, strong) UITableViewCell * tempCell;

@end

@implementation ZFJFilterDetailView

- (instancetype)initWithFrame:(CGRect)frame style:(ZFJFilterDetailStyle)style {
    if (self = [super initWithFrame:frame]) {
        self.style = style;
     }
    return self;
}

- (void)setTitleArr:(NSArray *)titleArr {
    _titleArr = titleArr;
    CGFloat height = MIN(self.titleArr.count * 40, ViewHeight(self));
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, height)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 40;
    [self addSubview:_tableView];
    if (height < ViewHeight(self)) {
        self.blurView.frame = CGRectMake(0, ViewBelow(_tableView), windowContentWidth, ViewHeight(self) - height);
        self.tableView.scrollEnabled = NO;
    }
}


#pragma mark --- 懒加载
//- (UITableView *)tableView {
//    if (!_tableView) {
//        CGFloat height = MIN(self.titleArr.count * 40, ViewHeight(self));
//        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, height)];
//        self.tableView.dataSource = self;
//        self.tableView.delegate = self;
//        self.tableView.rowHeight = 40;
//        [self addSubview:_tableView];
//
//    }
//    return _tableView;
//}

- (UIView *)blurView {
    if (!_blurView) {
        self.blurView = [[UIView alloc] init];
        self.blurView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenView:)];
        [self.blurView addGestureRecognizer:tap];
        [self addSubview:self.blurView];
    }
    return _blurView;
}

- (void)hiddenView:(UITapGestureRecognizer *)tap {
    self.hidden = YES;
    if (self.hiddenView) {
        self.hiddenView(self);
    }
}

#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    switch (self.style) {
        case ZFJFilterDetailStyleOneListChangeColor:
        {
            if (indexPath.row == 0) {
                cell.textLabel.textColor = [UIColor orangeColor];
                self.tempCell = cell;
            }
        }
            break;
        case ZFJFilterDetailStyleOneListFlagChangeColor:
        {
            
        }
            break;
        case ZFJFilterDetailStyleOneListFlagNoChangeColor:
        {
            
        }
            break;
            
        default:
            break;
    }

    cell.textLabel.text = [self.titleArr objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark --- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.hidden = YES;
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];

    switch (self.style) {
        case ZFJFilterDetailStyleOneListChangeColor:
        {
            if ([self.tempCell isEqual:cell]) {
                cell.textLabel.textColor = [UIColor orangeColor];;
            } else {
                cell.textLabel.textColor = [UIColor orangeColor];;
                if (self.tempCell) {
                    self.tempCell.textLabel.textColor = [UIColor blackColor];
                }
            }
        }
            break;
        case ZFJFilterDetailStyleOneListFlagChangeColor:
        {
            if ([self.tempCell isEqual:cell]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                cell.tintColor = TimeGreenColor;
            } else {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                cell.tintColor = TimeGreenColor;
                if (self.tempCell) {
                    self.tempCell.accessoryType = UITableViewCellAccessoryNone;
                }

            }
        }
            break;
        case ZFJFilterDetailStyleOneListFlagNoChangeColor:
        {
            if ([self.tempCell isEqual:cell]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                cell.tintColor = TimeGreenColor;
            } else {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                cell.tintColor = TimeGreenColor;
                if (self.tempCell) {
                    self.tempCell.accessoryType = UITableViewCellAccessoryNone;
                }
            }
         }
            break;

        default:
            break;
    }
    
    self.tempCell = cell;
    if (self.chooseIndexPath) {
        self.chooseIndexPath(indexPath);
    }

}

#pragma mark --- 方法
- (void)selectFilterViewIndexPath:(ChooseFilterIndexPath)chooseIndexPath{
    self.chooseIndexPath = chooseIndexPath;
}

- (void)selectHiddenView:(HiddenView)view {
    self.hiddenView = view;
}

@end
