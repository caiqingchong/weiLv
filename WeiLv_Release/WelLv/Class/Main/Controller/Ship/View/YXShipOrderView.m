
//
//  YXShipOrderView.m
//  WelLv
//
//  Created by lyx on 15/7/17.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "YXShipOrderView.h"
#import "ZFJShipDetailModel.h"
#import "ZFJChooseLineView.h"
#import "ZFJAddAndMinusView.h"

#define ButtonWith windowContentWidth/4

@interface YXShipOrderView ()
@property (nonatomic, strong) NSArray * roomsTypeArr;
@property (nonatomic, strong) NSArray * minPriceArr;
@property (nonatomic, strong) NSDictionary * roomsDic;
@property (nonatomic, copy) NSString * chooseType;
@property (nonatomic, strong) NSArray * shoreTraveLineArr;
@property (nonatomic ,strong) UIButton *lastBtn;

/**
 *   选中的房间字典
 */
@property (nonatomic, strong)NSMutableDictionary * chooseDataDic;
/**
 *  价格人数字典
 */
@property (nonatomic, strong) NSMutableDictionary * price_numDic;
/**
 *  库存字典
 */
@property (nonatomic, strong) NSMutableDictionary * stockDic;

@property (nonatomic, strong) ZFJShoreTraveModel * chooseShoreTraveModel;

@end

@implementation YXShipOrderView



- (id)initWithFrame:(CGRect)frame initWithKeys:(NSArray *)kes lowest:(NSMutableArray *)price all:(NSArray *)data cabin:(NSArray *)Arr index:(NSInteger)button shoreTraveLineArr:(NSArray *)shoreTraveLineArr

{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        _buttonArr = [[NSMutableArray alloc] init];//仓房标题button数组
        _totalData = [[NSMutableArray alloc] init];//挑选的所有房型数据，包含人数和价格
        _selectedCabin = [[NSMutableArray alloc] init];//挑选的所有房型
        self.shoreTraveLineArr = shoreTraveLineArr;
        self.keys = [NSArray arrayWithArray:kes];
        self.lowestPrice = price;//最低价格数组
        self.AllData = data;//按照舱位归类后的数据
        self.cabinArr = Arr;//仓位数组;
        self.buttonIndex = button; //用于区分每个房型的cell   并且用于区分选择的房型
        self.shoreTraveLineArr = shoreTraveLineArr;
        [self initView];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame withRoomTypeArr:(NSArray *)roomTypeArr minPriceArr:(NSMutableArray *)minPriceArr roomsDic:(NSDictionary *)roomsDic chooseRoomType:(NSString *)chooseType shoreTraveLineArr:(NSArray *)shoreTraveLineArr {
    
    if (self  = [super initWithFrame:frame]) {
        self.roomsTypeArr = roomTypeArr;
        self.minPriceArr = minPriceArr;
        self.roomsDic = roomsDic;
        self.chooseType = chooseType;
        self.shoreTraveLineArr = shoreTraveLineArr;
        if (!self.chooseType) {
            self.chooseType = [self.roomsTypeArr objectAtIndex:0];
        }
        self.buttonIndex = 1111;
        _cabinArr = [roomsDic objectForKey:self.chooseType];
        [self initView];
        
    }
    return self;
}


- (void)initView
{
    if (_shipTableView == nil) {
        _shipTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, self.frame.size.height)];
        _shipTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _shipTableView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_shipTableView];
    }
    _shipTableView.delegate = self;
    _shipTableView.dataSource = self;
    _shipTableView.scrollEnabled = NO;
    [self initHeaderView:_shipTableView];
    [self addShoreTraveLineView];
    [self setChangeFrame];
    
}

- (void) setChangeFrame
{
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat footHeight = self.shoreTraveLineArr.count > 0 ? (self.shoreTraveLineArr.count * 41 + 20) : 0;
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 120*_cabinArr.count+80 + footHeight);
        _shipTableView.frame = self.frame;
    }];
}

- (void)layoutSubviews
{
    if ([self.delegate respondsToSelector:@selector(changeShipViewFrame:)])
    {
        [self.delegate changeShipViewFrame:self];
    }
}

- (void)initHeaderView:(UITableView *)tableView
{
    UIScrollView *titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 80)];
    titleScrollView.layer.borderColor = bordColor.CGColor;
    titleScrollView.backgroundColor = [UIColor whiteColor];
    titleScrollView.layer.borderWidth = 0.5;
    _shipTableView.tableHeaderView = titleScrollView;
    _buttonArr = [NSMutableArray array];
    
     for (int i=0; i<self.keys.count; i++) {
     UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
     button.frame = CGRectMake(0+i*(windowContentWidth/self.keys.count), 0, windowContentWidth/self.keys.count, ViewHeight(titleScrollView));
     button.tag = i + 1111;
     [button addTarget:self action:@selector(changeCabin:) forControlEvents:UIControlEventTouchUpInside];
     [titleScrollView addSubview:button];
     [_buttonArr addObject:button];
     
     NSString *typeName = [self.keys objectAtIndex:i];
     
     UILabel *typeLable = [YXTools allocLabel:typeName font:systemFont(15) textColor:[UIColor blackColor] frame:CGRectMake(0, 10, ViewWidth(button), 30) textAlignment:1];
         typeLable.tag = i + 2222;
     [button addSubview:typeLable];
     
     UILabel *priceLable = [YXTools allocLabel:[NSString stringWithFormat:@"￥%@起",[_lowestPrice objectAtIndex:i]] font:systemFont(13) textColor:[UIColor blackColor] frame:CGRectMake(0, ViewHeight(typeLable)+ViewY(typeLable), ViewWidth(button), 30) textAlignment:1];
         priceLable.tag = i + 3333;
     [button addSubview:priceLable];
     
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(ViewWidth(button)+ViewX(button), 10, 0.5, ViewHeight(button) -20)];
     line.alpha = 0.6;
     line.backgroundColor = [UIColor orangeColor];
         
     [titleScrollView addSubview:line];
         
     if (i == self.buttonIndex) {
     self.lastBtn = button;
     typeLable.textColor = [UIColor orangeColor];
     priceLable.textColor = [UIColor orangeColor];
     }

 }

    
    titleScrollView.contentSize = CGSizeMake(ButtonWith*self.keys.count, 0);
    
    
}

/**
 *  加载岸上观光线路视图
 */
- (void)addShoreTraveLineView {
    NSMutableArray * titleArr = [NSMutableArray array];
    NSMutableArray * priceArr = [NSMutableArray array];
    
    for (ZFJShoreTraveModel * model in self.shoreTraveLineArr) {
        if ([model.fee_status isEqualToString:@"0"]) {
            [priceArr addObject:[NSString stringWithFormat:@"¥%@", [self judgeReturnString:model.tour_price withReplaceString:@"0.0"]]];
        } else if ([model.fee_status isEqualToString:@"1"]) {
            [priceArr addObject:@"免费"];
        }
        [titleArr addObject: [self judgeReturnString:model.tour_name withReplaceString:@" "]];

    }
    
    if (self.shoreTraveLineArr.count > 0) {
        self.chooseShoreTraveModel = [self.shoreTraveLineArr objectAtIndex:0];
    }
    if (titleArr.count > 0) {
    ZFJChooseLineView* chooseLineView = [[ZFJChooseLineView alloc] initWithFrame:CGRectMake(0, 20, windowContentWidth, 40)
                                                             withChooseLineArray:titleArr];
    chooseLineView.defaultLineNum = 0;
    chooseLineView.priceArr = priceArr;
    __weak YXShipOrderView * weakSelf = self;
    [chooseLineView chooseOneRow:^(NSInteger row) {
        weakSelf.chooseShoreTraveModel = [weakSelf.shoreTraveLineArr objectAtIndex:row];
        
        if ([weakSelf.delegate respondsToSelector:@selector(totalChooseDataDic:shoreTraveLine:)]) {
            [weakSelf.delegate totalChooseDataDic:weakSelf.chooseDataDic shoreTraveLine:weakSelf.chooseShoreTraveModel];
        }
        
    }];
    UIView * footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ViewHeight(chooseLineView) + 20)];
    footerView.backgroundColor = BgViewColor;
    [footerView addSubview:chooseLineView];
    _shipTableView.tableFooterView = footerView;
    
        } else {
            UIView * footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 0.1)];
            footerView.backgroundColor = BgViewColor;
            _shipTableView.tableFooterView = footerView;
            _shipTableView.sectionFooterHeight = 0.1f;
        }
}

#pragma mark 更换海景房类型
- (void)changeCabin:(UIButton *)sender
{
    
    UILabel *lastTypeLabel = (UILabel*)[self.lastBtn viewWithTag:self.lastBtn.tag - 1111 + 2222];
    UILabel *lastPriceLabel = (UILabel*)[self.lastBtn viewWithTag:self.lastBtn.tag - 1111 + 3333];
    lastTypeLabel.textColor = [UIColor blackColor];
    lastPriceLabel.textColor = [UIColor blackColor];
    
    

    UILabel *typeLabel = (UILabel*)[sender viewWithTag:sender.tag - 1111 + 2222];
    UILabel *priceLabel = (UILabel*)[sender viewWithTag:sender.tag - 1111 + 3333];
    typeLabel.textColor = [UIColor orangeColor];
    priceLabel.textColor = [UIColor orangeColor];
    
    self.lastBtn = sender;
    
    self.buttonIndex = sender.tag - 1111;
    
   _cabinArr = [[self.AllData objectAtIndex:self.buttonIndex] objectForKey:[self.keys objectAtIndex:self.buttonIndex]];

    [_shipTableView reloadData];
    self.chooseType = [self.roomsTypeArr objectAtIndex:sender.tag - 1111];
    [self setChangeFrame];
    [self layoutSubviews];
}


#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cabinArr.count;
   // return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier0 = [NSString stringWithFormat:@"cellIdentifier%ld",self.buttonIndex];
    YXShipCabinCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier0];
    if (cell == nil) {
        cell = [[YXShipCabinCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier0 frame:CGRectMake(0, 0, windowContentWidth, 120)];
        //单元格的选择风格，选择时单元格不出现蓝条
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    
     NSDictionary *cabinDic = [_cabinArr objectAtIndex:indexPath.row];
     ZFJShipRoom * roomModel = [[ZFJShipRoom alloc] initWithDictionary:cabinDic];
     cell.roomModel = roomModel;
     cell.indexRow = indexPath.row;
    
    if ([self.stockDic objectForKey:roomModel.c_id]) {
        cell.kucunLabel.text = [NSString stringWithFormat:@"剩余舱房：%@间",[self.stockDic objectForKey:roomModel.c_id]];
    }
    
    __weak YXShipOrderView * weakSelf = self;
    
    [cell.addAndMinusView numOfSumLabel:^(NSInteger num) {
        if (num==0) {
         [cell.childAandMView.addBut setImage:[UIImage imageNamed:@"添加不可用"] forState:UIControlStateNormal];
        }
        
        NSMutableDictionary * room_idDic = nil;
        if (![weakSelf.chooseDataDic objectForKey:roomModel.c_id]) {
            room_idDic = [NSMutableDictionary dictionary];
            [room_idDic addEntriesFromDictionary:@{@"model":roomModel, @"adultNum":[NSString stringWithFormat:@"%ld", num], @"childNum":@"0", @"sumPrice":@"0"}];
            [weakSelf.chooseDataDic setObject:room_idDic forKey:roomModel.c_id];
            
        } else {
            room_idDic = [weakSelf.chooseDataDic objectForKey:roomModel.c_id];
        }

        
        //NSInteger adultNum = [[[self.chooseDataDic objectForKey:roomModel.c_id] objectForKey:@"adultNum"] integerValue];
        if (num > 0) {
            //计算当前成人下可以住的儿童数。
            NSInteger mixChildNum = ((num * ([roomModel.num integerValue] - 1)) + num) > [roomModel.num integerValue] * [roomModel.stock integerValue] ? [roomModel.num integerValue] * [roomModel.stock integerValue] - num : (num * ([roomModel.num integerValue] - 1));
            cell.childAandMView.maxNum = mixChildNum;
            
            if ([cell.childAandMView.sumLabel.text integerValue] - mixChildNum  >= 0) {
                cell.childAandMView.sumLabel.text = [NSString stringWithFormat:@"%ld", mixChildNum];
                [cell.childAandMView.addBut setImage:[UIImage imageNamed:@"添加不可用"] forState:UIControlStateNormal];
            } else if ([cell.childAandMView.sumLabel.text integerValue] - mixChildNum  < 0) {
                [cell.childAandMView.addBut setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
            }
            
            /*修改儿童数量*/
            if (cell.childAandMView) {
                [[weakSelf.chooseDataDic objectForKey:roomModel.c_id] setObject:cell.childAandMView.sumLabel.text forKey:@"childNum"];
             }

        } else {
            //当成人数为0时，儿童不可入住。
            cell.childAandMView.maxNum = -1;
            cell.childAandMView.sumLabel.text  = @"0";
            [cell.childAandMView.minusBut setImage:[UIImage imageNamed:@"减少不可用"] forState:UIControlStateNormal];
            [weakSelf.chooseDataDic removeObjectForKey:roomModel.c_id];
            cell.kucunLabel.text = [NSString stringWithFormat:@"剩余舱房：%@间", roomModel.stock];
            [weakSelf.stockDic removeObjectForKey:roomModel.c_id];
            [weakSelf.stockDic setObject:roomModel.stock forKey:roomModel.c_id];
            
            if ([self.delegate respondsToSelector:@selector(totalChooseDataDic:)]) {
                [self.delegate totalChooseDataDic:self.chooseDataDic];
            }
            
            if ([weakSelf.delegate respondsToSelector:@selector(totalChooseDataDic:shoreTraveLine:)]) {
                [weakSelf.delegate totalChooseDataDic:weakSelf.chooseDataDic shoreTraveLine:weakSelf.chooseShoreTraveModel];
            }
            
            return;
        }
        
        
        //获取儿童数
        NSInteger childNum = [[[weakSelf.chooseDataDic objectForKey:roomModel.c_id] objectForKey:@"childNum"] integerValue];

        //修改人数
        [[weakSelf.chooseDataDic objectForKey:roomModel.c_id] setObject:[NSString stringWithFormat:@"%ld", num] forKey:@"adultNum"];
        
        
        
        //根据房间可住人数来计算价格。
        if ([roomModel.num integerValue] == 4 || [roomModel.num integerValue] == 3) {
            
            NSInteger personCount = num + childNum;
            
            
            if (roomModel.third_price && [roomModel.third_price floatValue] > 0) {
                childNum = personCount % [roomModel.num integerValue] > 0 ? childNum + ([roomModel.num integerValue] - personCount % [roomModel.num integerValue]):childNum;
                personCount = num + childNum;
                
            } else {
                num = personCount % [roomModel.num integerValue] > 0 ? num + ([roomModel.num integerValue] - personCount % [roomModel.num integerValue]):num;
                personCount = num + childNum;
                
            }
            //NSLog(@"人数personCount = %ld", personCount);
            
            CGFloat price = (personCount / [roomModel.num integerValue] * 2) * [roomModel.first_price floatValue];
            
            if (num - (personCount / [roomModel.num integerValue] * 2) <= 0) {
                
                price = price + [roomModel.third_price floatValue] * personCount / [roomModel.num integerValue] * ([roomModel.num integerValue] - 2);
                
            } else {
                NSInteger residueAdultNum = num - (personCount / [roomModel.num integerValue] * 2);
                
                if (roomModel.second_price && [roomModel.second_price floatValue] > 0) {
                    price = price + residueAdultNum * [roomModel.second_price floatValue] ;
                } else {
                    price = price + residueAdultNum * [roomModel.first_price floatValue] ;
                }
                
                if (childNum > 0) {
                    price = price + [roomModel.third_price floatValue] * childNum;
                }
                
            }
            
            //添加 修改 价格
            [[weakSelf.chooseDataDic objectForKey:roomModel.c_id] setObject:[NSString stringWithFormat:@"%g", price] forKey:@"sumPrice"];
            
            cell.kucunLabel.text = [NSString stringWithFormat:@"剩余舱房：%ld间", [roomModel.stock integerValue] - personCount / [roomModel.num integerValue]];
            
            [weakSelf.stockDic setObject:[NSString stringWithFormat:@"%ld", [roomModel.stock integerValue] - personCount / [roomModel.num integerValue]] forKey:roomModel.c_id];
            
        }  else {
            
            if (num == [roomModel.stock integerValue] * [roomModel.num integerValue]) {
                [[LXAlterView alloc] createTishi:@"库存不足,请选择其他舱房"];
            }
            
            NSInteger roomNum = num % [roomModel.num integerValue] > 0 ? (num / [roomModel.num integerValue] + 1):num / [roomModel.num integerValue];
            CGFloat price = [roomModel.first_price floatValue] * roomNum * [roomModel.num integerValue];
            
            
            //修改 库存数
            cell.kucunLabel.text = [NSString stringWithFormat:@"剩余舱房：%ld间", [roomModel.stock integerValue] - roomNum];
            
            //[self.stockDic removeObjectForKey:roomModel.c_id];
            [weakSelf.stockDic setObject:[NSString stringWithFormat:@"%ld", [roomModel.stock integerValue] - roomNum] forKey:roomModel.c_id];
            [[weakSelf.chooseDataDic objectForKey:roomModel.c_id] setObject:[NSString stringWithFormat:@"%g", price] forKey:@"sumPrice"];
            
        }
        
        if ([weakSelf.delegate respondsToSelector:@selector(totalChooseDataDic:)]) {
            [weakSelf.delegate totalChooseDataDic:weakSelf.chooseDataDic];
        }
        if ([weakSelf.delegate respondsToSelector:@selector(totalChooseDataDic:shoreTraveLine:)]) {
            [weakSelf.delegate totalChooseDataDic:weakSelf.chooseDataDic shoreTraveLine:weakSelf.chooseShoreTraveModel];
        }
        
    }];

    [cell.childAandMView numOfSumLabel:^(NSInteger num) {
       // NSLog(@"儿童 = %ld", num);
        
        //修改成人的可住人数。
        cell.addAndMinusView.maxNum = [roomModel.num integerValue] * [roomModel.stock integerValue] - num;
        //该房间的信息。
        NSDictionary * room_idDic = [weakSelf.chooseDataDic objectForKey:roomModel.c_id];
        //获取当前的成人数。
        NSInteger adultNum = [[room_idDic objectForKey:@"adultNum"] integerValue];
        
        //修改 儿童 数量
        [[weakSelf.chooseDataDic objectForKey:roomModel.c_id] setObject:[NSString stringWithFormat:@"%ld", num] forKey:@"childNum"];
        
        NSInteger personCount = num + adultNum;
        
        
        if (roomModel.third_price && [roomModel.third_price floatValue] > 0) {
            num = personCount % [roomModel.num integerValue] > 0 ? num + ([roomModel.num integerValue] - personCount % [roomModel.num integerValue]):num;
            personCount = num + adultNum;
            
        } else {
            adultNum = personCount % [roomModel.num integerValue] > 0 ? adultNum + ([roomModel.num integerValue] - personCount % [roomModel.num integerValue]):adultNum;
            personCount = num + adultNum;
        }
        
        
        
        CGFloat price = (personCount / [roomModel.num integerValue] * 2) * [roomModel.first_price floatValue];
        
        if (adultNum - (personCount / [roomModel.num integerValue] * 2) <= 0) {
            price = price + [roomModel.third_price floatValue] *  personCount / [roomModel.num integerValue] * ([roomModel.num integerValue] - 2);
        } else {
            //剩余成人数
            NSInteger residueAdultNum = adultNum - (personCount / [roomModel.num integerValue] * 2);
            
            if (roomModel.second_price && [roomModel.second_price floatValue] > 0) {
                price = price + residueAdultNum * [roomModel.second_price floatValue];
            } else {
                price = price + residueAdultNum * [roomModel.first_price floatValue];
            }
            
            price = price + [roomModel.third_price floatValue] * num;
            
        }
        
        //NSLog(@"价格 ＝ %g", price);
        
        //添加 修改 价格
        [[weakSelf.chooseDataDic objectForKey:roomModel.c_id] setObject:[NSString stringWithFormat:@"%g", price] forKey:@"sumPrice"];
        //修改 库存数
        cell.kucunLabel.text = [NSString stringWithFormat:@"剩余舱房：%ld间", [roomModel.stock integerValue] - personCount / [roomModel.num integerValue]];
        [weakSelf.stockDic setObject:[NSString stringWithFormat:@"%ld", [roomModel.stock integerValue] - personCount / [roomModel.num integerValue]] forKey:roomModel.c_id];
        
            if ([weakSelf.delegate respondsToSelector:@selector(totalChooseDataDic:shoreTraveLine:)]) {
            [weakSelf.delegate totalChooseDataDic:weakSelf.chooseDataDic shoreTraveLine:weakSelf.chooseShoreTraveModel];
        }
         
    }];
    
    //因为cell的didDeselectRowAtIndexPath方法不执行，所以才给cell添加手势
    UITapGestureRecognizer *ges1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDetailCabinView:)];
    [cell addGestureRecognizer:ges1];
    return cell;
    
}
- (NSMutableDictionary *)chooseDataDic {
    if (!_chooseDataDic) {
        self.chooseDataDic = [NSMutableDictionary dictionary];
    }
    return _chooseDataDic;
}

- (NSMutableDictionary *)stockDic {
    if (!_stockDic) {
        self.stockDic = [NSMutableDictionary dictionary];
    }
    return _stockDic;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self showDetailCabinView:[_cabinArr objectAtIndex:indexPath.row]];
}


- (void)showDetailCabinView:(UIGestureRecognizer *)tap
{
    
    YXShipCabinCell *cell = (YXShipCabinCell *)tap.view;
    NSDictionary *modelDic = [_cabinArr objectAtIndex:cell.indexRow];
    ZFJShipRoom * model = [[ZFJShipRoom alloc] initWithDictionary:modelDic];
    UIView *grayView = [[UIView alloc]initWithFrame:[YXTools getApp].window.bounds];
    grayView.backgroundColor = [UIColor blackColor];
    grayView.alpha = 0.5;
    grayView.tag = 300;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteSearchView)];
    [grayView addGestureRecognizer:ges];
    [[YXTools getApp].window addSubview:grayView];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth-60, 300)];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.layer.cornerRadius = 5.0;
    whiteView.center = [YXTools getApp].window.center;
    whiteView.tag = 400;
    [[YXTools getApp].window addSubview:whiteView];
    
    UILabel *titleLable = [YXTools allocLabel:[self judgeReturnString:model.cabin_name withReplaceString:@""] font:systemFont(13) textColor:[UIColor blackColor] frame:CGRectMake(10, 0,150, 40) textAlignment:0];
    [whiteView addSubview:titleLable];
    
    UIImageView *introductImageView = [YXTools allocImageView:CGRectMake(0, ViewY(titleLable)+ViewHeight(titleLable), ViewWidth(whiteView), 200) image:nil];
    introductImageView.contentMode = UIViewContentModeScaleToFill;
    NSString *imageUrl = model.cabin_thumb;
    NSString *imageP = @"";
    if ([imageUrl hasPrefix:@"https://"] || [imageUrl hasPrefix:@"http://"]) {
        imageP = imageUrl;
    }else
    {
        imageP = [WLHTTP stringByAppendingString:imageUrl];
    }
    [introductImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imageP]] placeholderImage:[UIImage imageNamed:@"默认图3"]];
    [whiteView addSubview:introductImageView];
    
    
    NSArray *arr = [NSArray arrayWithObjects:@"面积",@"入住人数" ,@"楼层",nil];
    float with = ViewWidth(whiteView)/arr.count;
    for (int i = 0; i<arr.count; i++) {
        UILabel *lable = [YXTools allocLabel:[arr objectAtIndex:i] font:systemFont(13) textColor:[UIColor blackColor] frame:CGRectMake(with*i, ViewY(introductImageView)+ViewHeight(introductImageView)+10, with, 20) textAlignment:1];
        [whiteView addSubview:lable];
        if (i != arr.count -1) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(ViewX(lable) + ViewWidth(lable), ViewY(lable), 0.5, 40)];
            line.backgroundColor = [UIColor grayColor];
            line.alpha = 0.5;
            [whiteView addSubview:line];
        }
    }
    UILabel *areaLabel =  [YXTools allocLabel:[NSString stringWithFormat:@"%@㎡", [self judgeReturnString:model.size withReplaceString:@""]] font:systemFont(13) textColor:[UIColor blackColor] frame:CGRectMake(0, 270, with, 20) textAlignment:1];
    [whiteView addSubview:areaLabel];
    UILabel *numberLabel =  [YXTools allocLabel:[NSString stringWithFormat:@"%@", [self judgeReturnString:model.num withReplaceString:@""]] font:systemFont(13) textColor:[UIColor blackColor] frame:CGRectMake(ViewX(areaLabel)+ViewWidth(areaLabel), ViewY(areaLabel), with, 20) textAlignment:1];
    [whiteView addSubview:numberLabel];
    
    UILabel *floorLabel =  [YXTools allocLabel:[NSString stringWithFormat:@"%@", [self judgeReturnString:model.floors withReplaceString:@""]] font:systemFont(13) textColor:[UIColor blackColor] frame:CGRectMake(ViewX(numberLabel)+ViewWidth(numberLabel), ViewY(areaLabel), with, 20) textAlignment:1];
    [whiteView addSubview:floorLabel];
    
}

- (void)deleteSearchView
{
    UIView *v = (UIView *)[[YXTools getApp].window viewWithTag:300];
    [v removeFromSuperview];
    
    UIView *v1 = (UIView *)[[YXTools getApp].window viewWithTag:400];
    [v1 removeFromSuperview];
}

#define mark YXShipCabinCellDelegate
/*实现思路
 1、创建两个数组，一个存放可变的对象，一个存放不可变的对象；存可变得数组用于存放选中的对象、人数和总价格，不可变数组用于做判断对象是否在数组里
 2、增加：先判断对象是否在不可变数组中，如果不在，加入数组，如果已经存在，在可变数组里遍历到该对象，修改对象中人数和价格的值；
 3、减少：先判读如果对象不在可不变数组中并且房间数为0，可变数组中删除改对象，不可变数组中遍历到该条对象，再删除；否则，遍历到该条对象，修改人数和价格
 4、遍历存放所有数据的数组（allData），取出每一条字典里的价格和人数累加起来，算出总数
 
 ps:为什么不用一个数组、一个字典？
 因为，如果用一个可变的字典，那么每次修改完之后都会作为一条新数据添加到数组里
 */

#pragma mark ---计算总金额
- (void)calculateTotalAmount:(NSInteger)index number:(NSString *)number roomNum:(int)number1 totalPrice:(NSString *)price andTag:(int)tag cabinDic:(NSDictionary *)dic
{
    NSDictionary *dicDisy = [_cabinArr objectAtIndex:index];
    NSMutableDictionary *alldic = [[NSMutableDictionary alloc] initWithDictionary:dicDisy];
    //减少
    if (tag == 1) {
        if([self.selectedCabin indexOfObject:dicDisy] != NSNotFound && number1 ==0){
            [self.selectedCabin removeObjectIdenticalTo:dicDisy];
            
            [self.totalData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
                NSString *typeId = [obj objectForKey:@"cabin_id"];
                if ([typeId isEqualToString:[alldic objectForKey:@"cabin_id"]]){
                    *stop = YES;
                }
                if (*stop == YES) {
                    [self.totalData removeObject:obj];
                }
                
            }];
            
        }else
        {
            for (NSDictionary *typeDic in self.totalData) {
                NSString *typeId = [typeDic objectForKey:@"cabin_id"];
                if ([typeId isEqualToString:[alldic objectForKey:@"cabin_id"]]) {
                    [typeDic setValue:number forKey:@"adult_number"];
                    [typeDic setValue:price forKey:@"totalMoney"];
                    [typeDic setValue:[NSString stringWithFormat:@"%d",number1] forKey:@"roomNumber"];
                }
            }
        }
    }else //增加
    {
        if([self.selectedCabin indexOfObject:dicDisy] == NSNotFound)
        {
            [self.selectedCabin addObject:dicDisy];
            
            [alldic setValue:number forKey:@"adult_number"];
            [alldic setValue:price forKey:@"totalMoney"];
            [alldic setValue:[NSString stringWithFormat:@"%d",number1] forKey:@"roomNumber"];
            [self.totalData addObject:alldic];
        }else
        {
            for (NSDictionary *typeDic in self.totalData) {
                NSString *typeId = [typeDic objectForKey:@"cabin_id"];
                if ([typeId isEqualToString:[alldic objectForKey:@"cabin_id"]]) {
                    [typeDic setValue:number forKey:@"adult_number"];
                    [typeDic setValue:price forKey:@"totalMoney"];
                    [typeDic setValue:[NSString stringWithFormat:@"%d",number1] forKey:@"roomNumber"];
                }
            }
        }
      }
    float totalMoney = 0;
    int renshu = 0;
    for (int i = 0; i<self.totalData.count; i++) {
        NSDictionary *dic = [self.totalData objectAtIndex:i];
        NSString *money = [dic objectForKey:@"totalMoney"];
        NSString *ManNum = [dic objectForKey:@"adult_number"];
        totalMoney = [money floatValue]+totalMoney;
        renshu = renshu +[ManNum intValue];
    }
    
    if ([self.delegate respondsToSelector:@selector(totalPriceData:price:num:)]) {
        [self.delegate totalPriceData:self.totalData price:totalMoney num:renshu];
    }
}

@end
