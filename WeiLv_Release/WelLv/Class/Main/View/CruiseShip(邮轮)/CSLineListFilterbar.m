//
//  CSLineListFilterbar.m
//  WelLv
//
//  Created by nick on 16/3/14.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "CSLineListFilterbar.h"
#import "CSFilterConditionTableViewCell.h"
#import "CSFilterDetailTableViewCell.h"
#import "CSFilterSortTableViewCell.h"

@implementation CSLineListFilterbar

- (instancetype)initWithFrame:(CGRect)frame andFilterConditions:(NSArray *)conditons {

    self = [super initWithFrame:frame];
    
    self.backgroundColor = kColor(65.0, 65.0, 65.0);
    
    self.conditions = conditons;
    
    [self setLayout];
    
    [self setFilterConditionView];
    
    return self;
}

- (void)setLayout {

    CGFloat itemWidth = (self.frame.size.width - 1) / 2;
    
    //综合筛选
    UIView *comprehensiveView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, itemWidth, self.frame.size.height)];
    
    comprehensiveView.tag = FilterTypeComprehensive;
    
    comprehensiveView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapCompGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onShow:)];
    
    [comprehensiveView addGestureRecognizer:tapCompGesture];
    
    [self addSubview:comprehensiveView];
    
    CGFloat compWidth = 38 * 15 / 26;
    
    CGFloat compOriginX = (itemWidth - compWidth - 5 - 30) / 2;
    
    UIImageView *comprehensiveIcon = [[UIImageView alloc] initWithFrame:CGRectMake(compOriginX, (comprehensiveView.frame.size.height - 15) / 2, compWidth, 15)];
    
    comprehensiveIcon.image = [UIImage imageNamed:@"cs_comprehensive"];
    
    [comprehensiveView addSubview:comprehensiveIcon];
    
    UILabel *comprehensiveLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(comprehensiveIcon.frame) + 5, comprehensiveIcon.frame.origin.y, 30, comprehensiveIcon.frame.size.height)];
    
    comprehensiveLabel.text = @"综合";
    
    comprehensiveLabel.font = [UIFont systemFontOfSize:15.0];
    
    comprehensiveLabel.textColor = [UIColor whiteColor];
    
    [comprehensiveView addSubview:comprehensiveLabel];
    
    //分隔线
    UIView *segmentLine = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(comprehensiveView.frame), 8, 1, self.frame.size.height - 8 * 2)];
    
    segmentLine.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:segmentLine];
    
    //排序筛选
    UIView *sortView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(segmentLine.frame), 0, itemWidth, self.frame.size.height)];
    
    sortView.tag = FilterTypeSort;
    
    sortView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapSortGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onShow:)];
    
    [sortView addGestureRecognizer:tapSortGesture];
    
    [self addSubview:sortView];
    
    CGFloat sortWidth = 30 * 15 / 34;
    
    CGFloat sortOriginX = (itemWidth - sortWidth - 5 - 30) / 2;
    
    UIImageView *sortIcon = [[UIImageView alloc] initWithFrame:CGRectMake(sortOriginX, (sortView.frame.size.height - 15) / 2, sortWidth, 15)];
    
    sortIcon.image = [UIImage imageNamed:@"cs_sort"];
    
    [sortView addSubview:sortIcon];
    
    UILabel *sortLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(sortIcon.frame) + 5, sortIcon.frame.origin.y, 30, sortIcon.frame.size.height)];
    
    sortLabel.text = @"排序";
    
    sortLabel.font = [UIFont systemFontOfSize:15.0];
    
    sortLabel.textColor = [UIColor whiteColor];
    
    [sortView addSubview:sortLabel];
}

//设置筛选条件视图
- (void)setFilterConditionView {

    self.conditionView = [CSLineListFilterConditionView new];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.conditionView];
}

- (void)onShow:(UITapGestureRecognizer *)tap {

    NSInteger tag = tap.view.tag;
    
    [self.conditionView resetLayoutWithFilterType:tag];
    
    [self setCATransitionWithDuration:0.3 Type:kCATransitionFade andView:self.conditionView];
}

- (void)setCATransitionWithDuration:(CFTimeInterval)duration Type:(NSString *)type andView:(UIView *)view {

    CATransition *animation = [CATransition animation];
    
    animation.duration = duration;
    
    animation.type = type;
    
    [view.layer addAnimation:animation forKey:nil];
    
    view.hidden = NO;
}

@end



@interface CSLineListFilterConditionView ()<UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) NSArray *conditions;

@property(strong, nonatomic) NSArray *details;

@property(strong, nonatomic) NSArray *options;

@property(assign, nonatomic) NSInteger selectedConditionRow;

@property(strong, nonatomic) NSMutableDictionary *selectedDetailRows;

@property(assign, nonatomic) NSInteger selectedSortRow;

@end

@implementation CSLineListFilterConditionView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    self.tag = 999;
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.hidden = YES;
    
    self.conditions = @[@[@"cs_comprehensive_days", @"行程天数"],
                        @[@"cs_comprehensive_price", @"价格区间"],
                        @[@"cs_comprehensive_time", @"出发时间"]];
    
    self.details = @[@[@"不限", @"4天", @"5天", @"6天", @"7天以上"],
                     @[@"不限", @"3000以下", @"3000-6000", @"6000-1万", @"1万以上"],
                     @[@"不限", @"2016年4月", @"2016年5月", @"2016年6月", @"2016年8月"]];
    
    self.options = @[@[@"cs_sort_comprehensive", @"综合"],
                     @[@"cs_sort_price_lowtohigh", @"价格从低到高"],
                     @[@"cs_sort_price_hightolow", @"价格从高到低"]];
    
    self.selectedConditionRow = 0;
    
    self.selectedDetailRows = [NSMutableDictionary dictionary];
    
    self.selectedSortRow = 0;
    
    [self initSelectedDetailRows];
    
    [self setBackgroundView];
    
    [self setControlBar];
    
    [self setConditionTableView];
    
    [self setDetailTableView];
    
    [self setSortTableView];
    
    return self;
}

- (void)initSelectedDetailRows {

    for(int i = 0; i < self.conditions.count; i++){
        
        [self.selectedDetailRows setObject:@"0" forKey:[NSString stringWithFormat:@"%i", i]];
    }
}

//设置背景视图
- (void)setBackgroundView {

    UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
    
    bgView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapBgGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onCancel:)];
    
    [bgView addGestureRecognizer:tapBgGesture];
    
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    
    [self addSubview:bgView];
}

//设置操控制栏
- (void)setControlBar {

    self.controlBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height * 0.6, self.frame.size.width, CONTROL_BAR_HEIGHT)];
    
    self.controlBar.backgroundColor = kColor(65.0, 65.0, 65.0);
    
    [self addSubview:self.controlBar];
    
    //取消按钮
    UILabel *cancelBtn = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_WIDTH, 0, 50, self.controlBar.frame.size.height)];
    
    cancelBtn.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapCancelGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onCancel:)];
    
    [cancelBtn addGestureRecognizer:tapCancelGesture];
    
    cancelBtn.text = @"取消";
    
    cancelBtn.font = [UIFont systemFontOfSize:15.0];
    
    cancelBtn.textAlignment = NSTextAlignmentCenter;
    
    cancelBtn.textColor = [UIColor whiteColor];
    
    [self.controlBar addSubview:cancelBtn];
    
    //重置按钮
    UILabel *resetBtn = [[UILabel alloc] initWithFrame:CGRectMake((self.controlBar.frame.size.width - 100) / 2, 7, 100, self.controlBar.frame.size.height - 7 * 2)];
    
    resetBtn.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapResetGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onReset:)];
    
    [resetBtn addGestureRecognizer:tapResetGesture];
    
    resetBtn.text = @"清空重置";
    
    resetBtn.font = [UIFont systemFontOfSize:15.0];
    
    resetBtn.textAlignment = NSTextAlignmentCenter;
    
    resetBtn.textColor = kColor(177.0, 181.0, 189.0);
    
    resetBtn.backgroundColor = kColor(131.0, 136.0, 142.0);
    
    resetBtn.layer.masksToBounds = YES;
    
    resetBtn.layer.cornerRadius = 2.0;
    
    [self.controlBar addSubview:resetBtn];
    
    //确定按钮
    UILabel *confirmBtn = [[UILabel alloc] initWithFrame:CGRectMake(self.controlBar.frame.size.width - 50 - MARGIN_WIDTH, 0, 50, self.controlBar.frame.size.height)];
    
    confirmBtn.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapConfirmGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onCancel:)];
    
    [confirmBtn addGestureRecognizer:tapConfirmGesture];
    
    confirmBtn.text = @"确定";
    
    confirmBtn.font = [UIFont systemFontOfSize:15.0];
    
    confirmBtn.textAlignment = NSTextAlignmentCenter;
    
    confirmBtn.textColor = [UIColor whiteColor];
    
    [self.controlBar addSubview:confirmBtn];
}

//设置条件列表
- (void)setConditionTableView {

    self.conditionTbView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.controlBar.frame), CONDITION_CELL_WIDTH, self.frame.size.height * 0.4 - CONTROL_BAR_HEIGHT)];
    
    self.conditionTbView.tag = FilterTableViewTypeCondition;
    
    self.conditionTbView.dataSource = self;
    
    self.conditionTbView.delegate = self;
    
    self.conditionTbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.conditionTbView.backgroundColor = kColor(223.0, 230.0, 236.0);
    
    self.detailTbView.showsVerticalScrollIndicator = NO;
    
    [self addSubview:self.conditionTbView];
}

//设置条件详情列表
- (void)setDetailTableView {

    self.detailTbView = [[UITableView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.conditionTbView.frame), self.conditionTbView.frame.origin.y, DETAIL_CELL_WIDTH, self.conditionTbView.frame.size.height)];
    
    self.detailTbView.tag = FilterTableViewTypeDetail;
    
    self.detailTbView.dataSource = self;
    
    self.detailTbView.delegate = self;
    
    self.detailTbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.detailTbView.showsVerticalScrollIndicator = NO;
    
    [self addSubview:self.detailTbView];
}

//设置排序列表
- (void)setSortTableView {

    self.sortTbView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.frame.size.height * 0.75, self.frame.size.width, self.frame.size.height * 0.25)];
    
    self.sortTbView.tag = FilterTableViewTypeSort;
    
    self.sortTbView.dataSource = self;
    
    self.sortTbView.delegate = self;
    
    self.sortTbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.sortTbView.showsVerticalScrollIndicator = NO;
    
    [self addSubview:self.sortTbView];
}

- (void)resetLayoutWithFilterType:(FilterType)type {
    
    if(type == FilterTypeComprehensive){
        
        self.controlBar.hidden = NO;
        
        self.conditionTbView.hidden = NO;
        
        self.detailTbView.hidden = NO;
        
        self.sortTbView.hidden = YES;
    }
    
    if(type == FilterTypeSort){
        
        self.controlBar.hidden = YES;
        
        self.conditionTbView.hidden = YES;
        
        self.detailTbView.hidden = YES;
        
        self.sortTbView.hidden = NO;
    }
}

- (void)onCancel:(UITapGestureRecognizer *)tap {

    CATransition *animation = [CATransition animation];
    
    animation.duration = 0.3;
    
    animation.type = kCATransitionFade;
    
    [self.layer addAnimation:animation forKey:nil];
    
    self.hidden = YES;
}

- (void)onReset:(UITapGestureRecognizer *)tap {
    
    [self initSelectedDetailRows];
    
    [self.detailTbView reloadData];
}

#pragma - mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if(tableView.tag == FilterTableViewTypeCondition){
    
        return self.conditions.count;
    }
    
    if(tableView.tag == FilterTableViewTypeDetail){
    
        return [[self.details objectAtIndex:self.selectedConditionRow] count];
    }
    
    if(tableView.tag == FilterTableViewTypeSort){
    
        return self.options.count;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"cellId";
    
    switch(tableView.tag){
    
        case FilterTableViewTypeCondition:{
            
            CSFilterConditionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            
            if(cell == nil){
                
                cell = [[CSFilterConditionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            for(id obj in cell.contentView.subviews){
                
                [obj removeFromSuperview];
            }
            
            [cell setLayoutWithFilterConditions:self.conditions indexPath:indexPath andSelectedIndexPathRow:self.selectedConditionRow];
            
            return cell;
        }
            
        case FilterTableViewTypeDetail:{
            
            CSFilterDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            
            if(cell == nil){
            
                cell = [[CSFilterDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            for(id obj in cell.contentView.subviews){
                
                [obj removeFromSuperview];
            }
            
            [cell setLayoutWithConditionDetails:self.details indexPath:indexPath selectedConditionRow:self.selectedConditionRow andSelectedDetailRows:self.selectedDetailRows];
            
            return cell;
        }
            
        case FilterTableViewTypeSort:{
        
            CSFilterSortTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            
            if(cell == nil){
            
                cell = [[CSFilterSortTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            for(id obj in cell.contentView.subviews){
                
                [obj removeFromSuperview];
            }
            
            [cell setLayoutWithSortOptions:self.options indexPath:indexPath andSelectedSortRow:self.selectedSortRow];
            
            return cell;
        }
            
        default:
            
            return nil;
    }
}

#pragma - mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if(tableView.tag == FilterTableViewTypeCondition){
    
        self.selectedConditionRow = indexPath.row;
        
        [self.conditionTbView reloadData];
    }
    
    if(tableView.tag == FilterTableViewTypeDetail){
    
        [self.selectedDetailRows setObject:[NSString stringWithFormat:@"%li", indexPath.row] forKey:[NSString stringWithFormat:@"%li", self.selectedConditionRow]];
    }
    
    if(tableView.tag == FilterTableViewTypeSort){
    
        self.selectedSortRow = indexPath.row;
        
        [self.sortTbView reloadData];
        
        [self onCancel:nil];
    }
    
    [self.detailTbView reloadData];
}

@end








