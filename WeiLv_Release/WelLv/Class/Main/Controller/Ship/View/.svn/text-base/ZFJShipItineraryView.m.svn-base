//
//  ZFJShipItineraryView.m
//  WelLv
//
//  Created by WeiLv on 15/10/9.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJShipItineraryView.h"
#import "ZFJShipDetailModel.h"
#import "ZFJShipItineraryDayCell.h"
#import "ZFJShipShoreTravelCell.h"

@interface ZFJShipItineraryView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSDictionary * itineraryDic;
@property (nonatomic, strong) NSArray * keyArr;
@property (nonatomic, strong) NSMutableArray * modelArr;

@property (nonatomic, assign) BOOL isOpen;

@property (nonatomic, strong) NSMutableDictionary * shoreCellHeight;

@end

@implementation ZFJShipItineraryView


- (instancetype)initWithFrame:(CGRect)frame withDataDic:(NSDictionary *)dataDic {
    if (self = [super initWithFrame:frame]) {
        self.itineraryDic = dataDic;
        NSLog(@"dataDic = %@", self.itineraryDic);
        if ([self.itineraryDic isKindOfClass:[NSDictionary class]] && [[dataDic allKeys] isKindOfClass:[NSArray class]]) {
            self.keyArr = [NSArray arrayWithArray:[[dataDic allKeys] sortedArrayUsingSelector:@selector(compare:options:)]];
            
        }
        
        for (int i = 0; i < self.keyArr.count; i++) {
            NSDictionary * dic = [self.itineraryDic objectForKey:[self.keyArr objectAtIndex:i]];
            DLog(@"邮轮产品详情行程：%@",dic);
//            if ([[[dic objectForKey:@"type"] stringValue] isEqualToString:@"1"]) {
//                ZFJshipSchedule * model = [[ZFJshipSchedule alloc] initWithDictionary:[dic objectForKey:@"data"]];
//                [self.modelArr addObject:model];
//                
//                
//            } else if ([[[dic objectForKey:@"type"] stringValue] isEqualToString:@"2"]){
//                NSMutableArray * shoreModelArr = [NSMutableArray array];
//                if ([[dic objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
//                    NSArray * arr = [dic objectForKey:@"data"];
//                    for (int j = 0; j < arr.count; j++) {
//                        ZFJShoreTraveModel * model = [[ZFJShoreTraveModel alloc] initWithDictionary:[arr objectAtIndex:j]];
//                        [shoreModelArr addObject:model];
//                    }
//                }
//                [self.modelArr addObject:shoreModelArr];
//
//            }
        }
        //NSLog(@"%@", self.keyArr);
        [self customView];
    }
    return self;
}

- (void)customView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ViewHeight(self))];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    
}

/*
 if ([[self.itineraryDic objectForKey:[self.keyArr objectAtIndex:section]] isKindOfClass:[NSDictionary class]]) {
 if ([[[self.itineraryDic objectForKey:[self.keyArr objectAtIndex:section]] objectForKey:@"type"] isEqual:@"1"]) {
 return 1;
 } else if ([[[self.itineraryDic objectForKey:[self.keyArr objectAtIndex:section]] objectForKey:@"type"] isEqual:@"2"]){
 if ([[[self.itineraryDic objectForKey:[self.keyArr objectAtIndex:section]] objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
 NSArray * arr = [[self.itineraryDic objectForKey:[self.keyArr objectAtIndex:section]] objectForKey:@"data"];
 return arr.count;
 }
 }
 }
 */


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.keyArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"%@", [self.itineraryDic objectForKey:[self.keyArr objectAtIndex:indexPath.section]]);
    if ([[self.itineraryDic objectForKey:[self.keyArr objectAtIndex:indexPath.row]] isKindOfClass:[NSDictionary class]]) {
        NSString * typeStr = [NSString stringWithFormat:@"%@", [[self.itineraryDic objectForKey:[self.keyArr objectAtIndex:indexPath.row]] objectForKey:@"type"]];
        if ([typeStr isEqualToString:@"1"]) {
            
            static NSString * oneCellIdentifier = @"OneDayCell";
            ZFJShipItineraryDayCell * cell = [tableView dequeueReusableCellWithIdentifier:oneCellIdentifier];
            if (!cell) {
                cell = [[ZFJShipItineraryDayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:oneCellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            //ZFJshipSchedule  * model = [[ZFJshipSchedule alloc] initWithDictionary:[[self.itineraryDic objectForKey:[self.keyArr objectAtIndex:indexPath.row]] objectForKey:@"data"]];
            //NSLog(@"destination == %@", [[self.itineraryDic objectForKey:[self.keyArr objectAtIndex:indexPath.row]] objectForKey:@"destination"]);
            cell.addressLabel.text = [[self.itineraryDic objectForKey:[self.keyArr objectAtIndex:indexPath.row]] objectForKey:@"destination"];
            //[cell.addressLabel sizeToFit];
            CGRect frame = cell.addressLabel.frame;
            frame.size.width = [self returnTextCGRectText:cell.addressLabel.text textFont:15 cGSize:CGSizeMake(0, 30)].size.width;
            cell.addressLabel.frame = frame;
            CGRect lineFrame = cell.addressLineView.frame;
            lineFrame.size.width = frame.size.width + 50;
            cell.addressLineView.frame = lineFrame;
            cell.shipItineraryModel = [self.modelArr objectAtIndex:indexPath.row];
            return cell;
            
        } else if ([typeStr isEqualToString:@"2"]){
            
            static NSString * cellIdentifier = @"ShoreCell";
            ZFJShipShoreTravelCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) {
                cell = [[ZFJShipShoreTravelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            //cell.backgroundColor = [UIColor orangeColor];
            
            cell.addressLabel.text = [[self.itineraryDic objectForKey:[self.keyArr objectAtIndex:indexPath.row]] objectForKey:@"destination"];
            
            CGRect frame = cell.addressLabel.frame;
            frame.size.width = [self returnTextCGRectText:cell.addressLabel.text textFont:15 cGSize:CGSizeMake(0, 30)].size.width;
            cell.addressLabel.frame = frame;
            
            CGRect lineFrame = cell.addressLineView.frame;
            lineFrame.size.width = frame.size.width + 50;
            cell.addressLineView.frame = lineFrame;
            
            cell.dayStr = [NSString stringWithFormat:@"%@", [self.keyArr objectAtIndex:indexPath.row]];
            cell.modelArr = [self.modelArr objectAtIndex:indexPath.row];
            [cell chooseOneDayShoreTravelRow:^(NSInteger shoreTravelRow) {
                NSLog(@"%ld, %ld", indexPath.row, shoreTravelRow);
                if (self.shoreTravelIndexPath) {
                    NSIndexPath * index = [NSIndexPath indexPathForRow:shoreTravelRow inSection:indexPath.row];
                    self.shoreTravelIndexPath(index);
                }
            }];
            /*
            __weak ZFJShipItineraryView * weakSelf = self;
            cell.height = ^(CGFloat height){
                CGFloat cellCountHeight = [[weakSelf.shoreCellHeight objectForKey:[NSString stringWithFormat:@"%ld", indexPath.row]] floatValue] + height;
                
                NSLog(@"type2  cell == %g", cellCountHeight);

                [weakSelf.shoreCellHeight setObject:[NSString stringWithFormat:@"%g", cellCountHeight] forKey:[NSString stringWithFormat:@"%ld", indexPath.row]];
                weakSelf.isOpen = !weakSelf.isOpen;
                [weakSelf.tableView beginUpdates];
                [weakSelf.tableView endUpdates];
            };
             */
            return cell;
            
        }
    }
    
    return nil;
    
}
- (void)chooseShoreTravelIndex:(ChooseShoreTravelIndexPath)index {
    self.shoreTravelIndexPath = index;
    
}
/*
 static NSString * oneCellIdentifier = @"OneCell";
 ZFJShipItineraryDayCell * cell = [tableView dequeueReusableCellWithIdentifier:oneCellIdentifier];
 if (!cell) {
 cell = [[ZFJShipItineraryDayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:oneCellIdentifier];
 }
 
 return cell;
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //NSLog(@"cellHeight = %g", cell.frame.size.height);
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];

    if (indexPath.row == 1) {
        if (![self.shoreCellHeight objectForKey:[NSString stringWithFormat:@"%ld", indexPath.row]]) {
            [self.shoreCellHeight setObject:[NSString stringWithFormat:@"%g", cell.frame.size.height] forKey:[NSString stringWithFormat:@"%ld", indexPath.row]];
            return cell.frame.size.height;
        } else {
            return [[self.shoreCellHeight objectForKey:[NSString stringWithFormat:@"%ld", indexPath.row]] floatValue];
        }
    }
    return cell.frame.size.height;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"高度 ＝ %g", tableView.contentSize.height);
    CGRect frame = self.frame;
    frame.size.height = tableView.contentSize.height;
    if (self.height) {
        self.height(tableView.contentSize.height);
    }
}

#pragma mark --- 懒加载

- (NSMutableArray *)modelArr {
    if (!_modelArr) {
        self.modelArr = [NSMutableArray array];
    }
    return _modelArr;
}

- (NSMutableDictionary *)shoreCellHeight {
    if (!_shoreCellHeight) {
        self.shoreCellHeight = [NSMutableDictionary dictionary];
    }
    return _shoreCellHeight;
}


@end
