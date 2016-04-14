//
//  ZFJShipShoreTravelCell.m
//  WelLv
//
//  Created by zhangjie on 15/10/11.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJShipShoreTravelCell.h"
#import "ZFJShipShoreTravelOneCell.h"
#import "ZFJShipShoreTravelTitleView.h"
#import "ZFJShipDetailModel.h"
#import "IconAndTitleView.h"
#import "ZFJShoreTraveTitleCell.h"

#define M_LEFT_GAP 15

@interface ZFJShipShoreTravelCell ()<UITableViewDataSource, UITableViewDelegate>
{
   bool flag[100];
}

@property (nonatomic, strong) NSMutableDictionary * cellHeightDic;


@end

@implementation ZFJShipShoreTravelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //[self customView];
        [self addNewCustomView];
    }
    return self;
}

- (void)addNewCustomView {
    
    UIImageView * dayIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 15, 70, 30)];
    dayIcon.image = [UIImage imageNamed:@"圆角矩形"];
    [self.contentView addSubview:dayIcon];
    self.dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 2.5, 50, 25)];
    self.dayLabel.font = [UIFont systemFontOfSize:16];
    self.dayLabel.textColor = [UIColor whiteColor];
    self.dayLabel.text = @"第一天";
    [dayIcon addSubview:_dayLabel];
    
    
    
    self.addressLineView = [[UIView alloc] initWithFrame:CGRectMake(40, 15, 90, 30)];
    self.addressLineView.layer.cornerRadius = 15;
    self.addressLineView.layer.masksToBounds = YES;
    self.addressLineView.layer.borderWidth = 1.0;
    self.addressLineView.layer.borderColor = UIColorFromRGB(0x2bd999).CGColor;
    [self.contentView addSubview:_addressLineView];
    
    
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(dayIcon) + 5, ViewY(_addressLineView), 40, ViewHeight(_addressLineView))];
    //    self.addressLabel.layer.cornerRadius = 15;
    //    self.addressLabel.layer.masksToBounds = YES;
    //    self.addressLabel.layer.borderWidth = 1.0;
    //    self.addressLabel.layer.borderColor = UIColorFromRGB(0x2bd999).CGColor;
    self.addressLabel.font = [UIFont systemFontOfSize:15];
    self.addressLabel.textAlignment = NSTextAlignmentCenter;
    self.addressLabel.text = @"上海";
    [self.contentView addSubview:_addressLabel];
    [self.contentView addSubview:dayIcon];
    
    self.timeLabel = [[IconAndTitleView alloc] initWithFrame:CGRectMake(0, ViewBelow(dayIcon) + 5, windowContentWidth, 25) iconImageName:@"ship_Itinerary_time" titleLabel:@"航程：17:00出发"];
    [self.contentView addSubview:_timeLabel];
    
    self.shipNameLabel = [[IconAndTitleView alloc] initWithFrame:CGRectMake(0, ViewBelow(_timeLabel), windowContentWidth, 25) iconImageName:@"ship_Itinerary_ship_name" titleLabel:@"海洋量子号邮轮"];
    [self.contentView addSubview:_shipNameLabel];
    
    self.shoreTravelLabel =[[IconAndTitleView alloc] initWithFrame:CGRectMake(0, ViewBelow(_shipNameLabel), windowContentWidth, 25) iconImageName:@"ship_shore_travel" titleLabel:@"岸上观光"];
    [self.contentView addSubview:_shoreTravelLabel];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0,ViewBelow(self.shoreTravelLabel) - 0.5, windowContentWidth, 0.5)];
    lineView.backgroundColor = UIColorFromRGB(0x6f7378);
    [self.contentView addSubview:lineView];
    
    self.shoreTravelTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ViewBelow(self.shoreTravelLabel), windowContentWidth, 100)];
    //self.shoreTravelTableView.backgroundColor = [UIColor orangeColor];
    self.shoreTravelTableView.dataSource = self;
    self.shoreTravelTableView.delegate = self;
    self.shoreTravelTableView.rowHeight = 50;
    self.shoreTravelTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.shoreTravelTableView.scrollEnabled = NO;
    [self.contentView addSubview:_shoreTravelTableView];
    
}





- (void)customView {
    UIImageView * locationIcon = [[UIImageView alloc] initWithFrame:CGRectMake(M_LEFT_GAP, 0, 14, 16)];
    locationIcon.image = [UIImage imageNamed:@"日程"];
    [self.contentView addSubview:locationIcon];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(M_LEFT_GAP + 6.5, ViewBelow(locationIcon), 0.5, ViewHeight(self) - ViewBelow(locationIcon))];
    _lineView.backgroundColor = TimeGreenColor;
    [self.contentView addSubview:_lineView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(locationIcon), 0, windowContentWidth - ViewRight(locationIcon), 30)];
    self.titleLabel.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_titleLabel];

    
    self.shoreTravelTableView = [[UITableView alloc] initWithFrame:CGRectMake(ViewRight(locationIcon), ViewBelow(self.titleLabel), windowContentWidth - ViewRight(locationIcon), 100) style:UITableViewStyleGrouped];
    self.shoreTravelTableView.backgroundColor = [UIColor orangeColor];
    self.shoreTravelTableView.dataSource = self;
    self.shoreTravelTableView.delegate = self;
    self.shoreTravelTableView.rowHeight = 50;
    self.shoreTravelTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.shoreTravelTableView.scrollEnabled = NO;
    [self.contentView addSubview:_shoreTravelTableView];
}
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.modelArr.count;
    
}
 */


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (flag[section]) {
//        return 1;
//    } else {
//        return 0;
//    }}
    return self.modelArr.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"Cell";
    ZFJShoreTraveTitleCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ZFJShoreTraveTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.separatorInset = UIEdgeInsetsZero;
//        cell.preservesSuperviewLayoutMargins = NO;
//        cell.layoutMargins = UIEdgeInsetsZero;

    }
    ZFJShoreTraveModel * model = [self.modelArr objectAtIndex:indexPath.row];
    NSString * priceStr = @"";
    //NSLog(@"%@", [self.dataDic objectForKey:@"fee_status"]);
    if ([model.fee_status isEqualToString:@"0"]) {
        priceStr = [NSString stringWithFormat:@"¥%@", [self judgeReturnString:model.tour_price withReplaceString:@""]];
    } else if ([model.fee_status isEqualToString:@"1"]) {
        priceStr = @"免费";
    }

    cell.titleLabel.text = [NSString stringWithFormat:@"%@    %@", model.tour_name, priceStr];
    cell.checkBut.tag = indexPath.row;
    [cell.checkBut addTarget:self action:@selector(checkShoreMsg:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)checkShoreMsg:(UIButton *)button {
    
    if (self.chooseShoreTraveRow) {
        self.chooseShoreTraveRow(button.tag);
    }
}
- (void)chooseOneDayShoreTravelRow:(ChooseShoreTravelRow)chooseRow {
    self.chooseShoreTraveRow = chooseRow;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"Cell";
    ZFJShipShoreTravelOneCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ZFJShipShoreTravelOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    ZFJShoreTraveModel * model = [self.modelArr objectAtIndex:indexPath.section];
    cell.shoreTraveModel = model;

    [self.cellHeightDic setObject:[NSString stringWithFormat:@"%g", cell.frame.size.height] forKey:[NSString stringWithFormat:@"%ld", indexPath.section]];
    
    if (self.height) {
        NSLog(@"%g", ViewY(self));

        self.shoreTravelTableView.frame = CGRectMake(ViewX(_shoreTravelTableView), 18, windowContentWidth, _shoreTravelTableView.contentSize.height + cell.frame.size.height);
        self.lineView.frame = CGRectMake(ViewX(_lineView), ViewY(_lineView), ViewWidth(_lineView), _shoreTravelTableView.contentSize.height + ViewY(_lineView) + cell.frame.size.height);
        self.frame = CGRectMake(ViewX(self), ViewY(self), ViewWidth(self), _shoreTravelTableView.contentSize.height + ViewBelow(self.titleLabel) + cell.frame.size.height);
        self.height(cell.frame.size.height);
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString * headerIdentifier = @"header";
    ZFJShipShoreTravelTitleView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    if (!view) {
        view = [[ZFJShipShoreTravelTitleView alloc] initWithReuseIdentifier:headerIdentifier];
    }
    ZFJShoreTraveModel * model = [self.modelArr objectAtIndex:section];
    view.titleLabel.text = model.tour_name;
    
    [view didSelectSectionView:^{
        flag[section] = !flag[section];
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
        [_shoreTravelTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        if (!flag[section]) {
            if (self.height) {
                NSLog(@"%g", ViewY(self));

                CGFloat  cellHeight = [[self.cellHeightDic objectForKey:[NSString stringWithFormat:@"%ld", section]] floatValue];
                self.shoreTravelTableView.frame = CGRectMake(ViewX(_shoreTravelTableView), 18, windowContentWidth, _shoreTravelTableView.contentSize.height - cellHeight);
                self.lineView.frame = CGRectMake(ViewX(_lineView), ViewY(_lineView), ViewWidth(_lineView), _shoreTravelTableView.contentSize.height + ViewY(_lineView) - cellHeight);
                self.frame = CGRectMake(ViewX(self), ViewY(self), ViewWidth(self), _shoreTravelTableView.contentSize.height + ViewBelow(self.titleLabel) - cellHeight);
                self.height((-cellHeight));
            }
        }

    }];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}
 */


/*
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    CGRect frame = self.frame;
    frame.size.height = tableView.contentSize.height;
    self.shoreTravelTableView.frame = CGRectMake(ViewX(_shoreTravelTableView), ViewY(_shoreTravelTableView), windowContentWidth, _shoreTravelTableView.contentSize.height);
    self.frame = CGRectMake(ViewX(self), ViewY(self), ViewWidth(self), _shoreTravelTableView.contentSize.height + ViewBelow(self.titleLabel));
    //self.frame = frame;
    //[self.contentView addSubview:_shoreTravelTableView];
    NSLog(@"岸上观光cellHeight ＝ %g", self.frame.size.height);
    if (self.height) {
        self.height(self.frame.size.height);
    }
}
*/

- (void)setDayStr:(NSString *)dayStr {
//    _dayStr = dayStr;
//    self.titleLabel.attributedText = [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"<span style=font-size:14px;background-color:#FFFFFF;color:#00CF83;>第%@天 ｜ %@</span><span style=background-color:#FFFFFF;></span>", dayStr, @"岸上观光"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
//    [self.titleLabel sizeToFit];
//    //NSLog(@"%g", _titleLabel.frame.size.height);
    self.dayLabel.text = [NSString stringWithFormat:@"第%@天", dayStr];
    self.frame = CGRectMake(ViewX(self), ViewY(self), ViewWidth(self), 200);

}


- (void)setModelArr:(NSArray *)modelArr {
    _modelArr = modelArr;
    [self.shoreTravelTableView reloadData];
    self.shoreTravelTableView.frame = CGRectMake(0, ViewY(self.shoreTravelTableView), windowContentWidth, _shoreTravelTableView.contentSize.height);
    self.frame = CGRectMake(ViewX(self), ViewY(self), ViewWidth(self), ViewBelow(self.shoreTravelTableView));
}


#pragma mark --- 懒加载
- (NSMutableDictionary *)cellHeightDic {
    if (!_cellHeightDic) {
        self.cellHeightDic = [NSMutableDictionary dictionary];
    }
    return _cellHeightDic;
}


@end
