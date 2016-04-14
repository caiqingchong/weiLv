//
//  ChooseTitleView.m
//  WelLv
//
//  Created by 张发杰 on 15/7/27.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ChooseTitleView.h"

#import "UIDefines.h"

#define M_LEFT_WIDTH 10
#define M_tableView_row_height 30
@interface ChooseTitleView ()<UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) NSArray * secondTitleArr;
@property (nonatomic, assign) NSInteger chooseSection;
@property (nonatomic, strong) UIView * secondTitleBackgroundView;
@property (nonatomic, strong) UIView * blurView;
@property (nonatomic, strong) NSMutableArray * maxTitleCountArr;
@property (nonatomic, strong) UIView * tempView;

@property (nonatomic, copy) ChooseTitle chooseTitle;
@property (nonatomic, copy) ChooseIndex chooseIndex;

@property (nonatomic, strong) UIImageView * chooseIcon;

@property (nonatomic, strong) NSArray * tempArray;

@property (nonatomic, strong) UIView * lineView;

@property (nonatomic, strong) UITableView * firstTableView;
@property (nonatomic, strong) UITableView * secondTableView;
@property (nonatomic, strong) UITableView * thirdTableView;

@property (nonatomic, strong) UIView * secondTwoView;

@property (nonatomic, strong) NSDictionary * dataDic;
@property (nonatomic, assign) NSInteger chooseRow;
@property (nonatomic, strong) NSIndexPath * secondChooseIndexPath;
@property (nonatomic, copy) ChooseSectionRow chooseSectionRow;

@property (nonatomic, strong) NSMutableDictionary * loadSectonRowDic;

@property (nonatomic, assign) NSInteger lastChooseRow;
/**
 *  单列字典
 */
@property (nonatomic, strong) NSDictionary *oneLineFilterDic;

@property (nonatomic, assign) NSInteger chooseFilterOneLineRow;

@end

@implementation ChooseTitleView

- (id)initWithFrame:(CGRect)frame withTitleArray:(NSArray *)titleArr sencondTitleArray:(NSArray *)secondTitleArr {
    if (self == [super initWithFrame:frame]) {
        
        for (int i = 0; i < titleArr.count; i++) {
            
            self.backgroundColor = [UIColor whiteColor];
            self.secondTitleArr = secondTitleArr;
            
            UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewWidth(self) / titleArr.count * i, 0, ViewWidth(self) / titleArr.count, ViewHeight(self))];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.text = [titleArr objectAtIndex:i];
            titleLabel.font = [UIFont systemFontOfSize:16];
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.tag = 100 + i;
            titleLabel.userInteractionEnabled = YES;
            titleLabel.adjustsFontSizeToFitWidth = YES;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addSecondListView:)];
            [titleLabel addGestureRecognizer:tap];
            [self addSubview:titleLabel];
            CGFloat titleWidth = [self returnTextCGRectText:titleLabel.text textFont:16 cGSize:CGSizeMake(ViewWidth(titleLabel), ViewHeight(titleLabel))].size.width;
            UIImageView *chooseIcon = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(titleLabel) / 2 + titleWidth / 2 + 5, ViewHeight(titleLabel) * 0.7, 5, 5)];
            chooseIcon.image = [UIImage imageNamed:@"矩形-3-副本-2"];
            chooseIcon.tag = 150  + i;
            [titleLabel addSubview:chooseIcon];
            
            if (i < titleArr.count - 1) {
                UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(ViewWidth(self) / titleArr.count * (i + 1), ViewHeight(self) * 0.1, 0.5, ViewHeight(self) * 0.8)];
                lineView.backgroundColor = [UIColor orangeColor];
                [self addSubview:lineView];
            }
            UIView * belowView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(self) - 1, ViewWidth(self), 0.5)];
            belowView.backgroundColor = [UIColor grayColor];
            [self addSubview:belowView];
        }
    }
    return self;
}





- (void)setDefaultChooseIndex:(NSInteger)defaultChooseIndex {
    
}

- (void)addSecondListView:(UITapGestureRecognizer *) tap {
    
    self.chooseSection = tap.view.tag - 100;
    
    UILabel * tapLabel = (UILabel *)tap.view;
    UIImageView * chooseIcon = (UIImageView *)[self viewWithTag:150 + self.chooseSection];
    if (self.tempView == tap.view) {
        if ([tapLabel.textColor isEqual:[UIColor orangeColor]]) {
            
            tapLabel.textColor = [UIColor blackColor];
            chooseIcon.image = [UIImage imageNamed:@"矩形-3-副本-2"];;
            
        } else {
            tapLabel.textColor = [UIColor orangeColor];
            chooseIcon.image = [UIImage imageNamed:@"矩形-3"];
        }
        
    } else {
        UILabel * lastLabel = (UILabel *)self.tempView;
        lastLabel.textColor = [UIColor blackColor];
        UIImageView * lastChooseIcon = (UIImageView *)[self viewWithTag:lastLabel.tag + 50];
        lastChooseIcon.image = [UIImage imageNamed:@"矩形-3-副本-2"];
        
        tapLabel.textColor = [UIColor orangeColor];
        chooseIcon.image = [UIImage imageNamed:@"矩形-3"];
        
    }
    
    
    if ([[self.secondTitleArr objectAtIndex:tap.view.tag - 100] isKindOfClass:[NSArray class]])
    {
        
        if (self.secondTwoView.hidden == NO)
        {
            self.secondTwoView.hidden = YES;
        }
        
        [self addsecondOneChooseView:tap];
    }
    else if ([[self.secondTitleArr objectAtIndex:tap.view.tag - 100] isKindOfClass:[NSDictionary class]])
    {
        NSDictionary * dic = [self.secondTitleArr objectAtIndex:tap.view.tag - 100];
        
        if ([[dic objectForKey:@"type"] isEqualToString:@"oneLine"])
        {
            //NSLog(@"ooooooooooooooooo");
            
            
            self.oneLineFilterDic = dic;
            if (self.secondTwoView.hidden == NO)
            {
                self.secondTwoView.hidden = YES;
            }

            [self addFilterOneLineView];
        }
        else
        {
            if (self.secondTitleBackgroundView.hidden == NO)
            {
                self.secondTitleBackgroundView.hidden = YES;
            }
            
            self.dataDic = [self.secondTitleArr objectAtIndex:tap.view.tag - 100];
            [self addSecondTwoChooseView:self.dataDic];

        }
    }
    
    
    self.tempView = tap.view;
}

- (void)addsecondOneChooseView:(UITapGestureRecognizer *) tap {
    UILabel * tapLabel = (UILabel *)tap.view;
    //  tapLabel.textColor = [UIColor orangeColor];
    
    if (self.secondTitleBackgroundView == nil) {
        NSInteger maxCount = 0;
        for (int i = 0; i < self.secondTitleArr.count; i++) {
            NSArray * arr = [self.secondTitleArr objectAtIndex:i];
            maxCount = (NSInteger)MAX(maxCount, arr.count);
        }
        
        [self addChooseSeconTitleLabelWithMostArr:maxCount];
        
        self.secondTitleBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBelow(self), ViewWidth(self), 35)];
        self.secondTitleBackgroundView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        NSArray * tempArr = [self.secondTitleArr objectAtIndex:tap.view.tag - 100];
        for (int i = 0; i <tempArr.count; i++) {
            UILabel * tempLabel = [self.maxTitleCountArr objectAtIndex:i];
            tempLabel.frame = CGRectMake(0, 35 * i, ViewWidth(self.secondTitleBackgroundView), 34.5);
            tempLabel.text = [NSString stringWithFormat:@"    %@", [tempArr objectAtIndex:i]];
            if ([[tempArr objectAtIndex:i] isEqualToString:tapLabel.text]) {
                
                tempLabel.textColor = [UIColor orangeColor];
                
            } else {
                
                tempLabel.textColor = [UIColor grayColor];
                
            }
            [self.secondTitleBackgroundView addSubview:tempLabel];
        }
        self.secondTitleBackgroundView.frame = CGRectMake(0, ViewBelow(self), ViewWidth(self), 35 * tempArr.count);
        [self.superview addSubview:self.secondTitleBackgroundView];
        [self addBlurViewWithView:self.secondTitleBackgroundView];
        [self hiddenBlurView];
        
    } else {
        [self.secondTitleBackgroundView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        NSArray * tempArr = [self.secondTitleArr objectAtIndex:tap.view.tag - 100];
        for (int i = 0; i <tempArr.count; i++) {
            UILabel * tempLabel = [self.maxTitleCountArr objectAtIndex:i];
            tempLabel.frame = CGRectMake(0, 35 * i , ViewWidth(self.secondTitleBackgroundView), 34.5);
            tempLabel.text = [NSString stringWithFormat:@"    %@", [tempArr objectAtIndex:i]];
            if ([[tempArr objectAtIndex:i] isEqualToString:tapLabel.text]) {
                
                tempLabel.textColor = [UIColor orangeColor];
                
            } else {
                
                tempLabel.textColor = [UIColor grayColor];
                
            }
            [self.secondTitleBackgroundView addSubview:tempLabel];
        }
        self.secondTitleBackgroundView.frame = CGRectMake(0, ViewBelow(self), ViewWidth(self), 35 * tempArr.count);
        
        if (self.tempView == tap.view) {
            self.secondTitleBackgroundView.hidden = !self.secondTitleBackgroundView.hidden;
        } else {
            self.secondTitleBackgroundView.hidden = NO;
        }
        
        
        [self addBlurViewWithView:self.secondTitleBackgroundView];
        [self hiddenBlurView];
    }
}

- (void)addFilterOneLineView {
    
    NSArray * keyArr = [self.oneLineFilterDic objectForKey:@"title"];
    
    if (self.secondTitleBackgroundView == nil) {
        CGFloat viewHeight = windowContentHeight - M_tableView_row_height * keyArr.count - ViewBelow(self) > 100 ?  M_tableView_row_height * keyArr.count : windowContentHeight - ViewBelow(self) - 100;
        CGFloat height_view = viewHeight > M_tableView_row_height * 4 ? viewHeight : M_tableView_row_height * 4;
        self.secondTitleBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBelow(self), ViewWidth(self), height_view)];
        self.secondTitleBackgroundView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.chooseRow = 0;
        
        self.thirdTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth(self.secondTitleBackgroundView), M_tableView_row_height * keyArr.count)];
        self.thirdTableView.dataSource = self;
        self.thirdTableView.delegate = self;
        self.thirdTableView.tableFooterView = [[UIView alloc] init];
        //self.thirdTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.secondTitleBackgroundView addSubview:self.thirdTableView];
        [self.superview addSubview:self.secondTitleBackgroundView];
        [self addBlurViewWithView:self.secondTitleBackgroundView];

    } else {
        self.secondTitleBackgroundView.hidden = !self.secondTitleBackgroundView.hidden;
        
        [self addBlurViewWithView:self.secondTitleBackgroundView];
        [self hiddenBlurView];

    }
}


- (void)addChooseSeconTitleLabelWithMostArr:(NSInteger)mostCount{
    self.maxTitleCountArr = [NSMutableArray array];
    for (int  i = 0; i < mostCount; i++) {
        UILabel * seconTitleLabel = [[UILabel alloc] init];
        seconTitleLabel.backgroundColor = [UIColor whiteColor];
        seconTitleLabel.font = [UIFont systemFontOfSize:14];
        seconTitleLabel.textAlignment = NSTextAlignmentLeft;
        seconTitleLabel.textColor = [UIColor grayColor];
        seconTitleLabel.backgroundColor = [UIColor whiteColor];
        seconTitleLabel.userInteractionEnabled = YES;
        seconTitleLabel.tag = 200 + i;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseTitleLabel:)];
        [seconTitleLabel addGestureRecognizer:tap];
        [self.maxTitleCountArr addObject:seconTitleLabel];
        
    }
}

- (void)chooseTitleLabel:(UITapGestureRecognizer *)tap {
    UILabel * tapLabel = (UILabel *)tap.view;
    //    self.chooseTitle(tapLabel.text);
    UILabel * sectionLabel = (UILabel *)[self viewWithTag:self.chooseSection + 100];
    sectionLabel.text = [NSString stringWithFormat:@"%@", [tapLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    CGFloat titleWidth = [self returnTextCGRectText:sectionLabel.text textFont:16 cGSize:CGSizeMake(ViewWidth(sectionLabel), ViewHeight(sectionLabel))].size.width;
    UIImageView * chooseIcon = (UIImageView *)[self viewWithTag:150 + self.chooseSection];
    chooseIcon.frame = CGRectMake(ViewWidth(sectionLabel) / 2 + titleWidth / 2 + 5, ViewHeight(sectionLabel) * 0.7, 5, 5);
    chooseIcon.image = [UIImage imageNamed:@"矩形-3-副本-2"];
    
    NSIndexPath * index = [NSIndexPath indexPathForRow:tap.view.tag - 200 inSection:self.chooseSection];
    
    if (self.chooseIndex) {
        self.chooseIndex(index);
    }
    
    if (self.chooseSectionRow) {
        self.chooseSectionRow(self.chooseSection, index);
    }
    [self hiddenView:nil];
    
}

- (void)chooseTitle:(ChooseTitle)chooseTitle {
    self.chooseTitle = chooseTitle;
}
- (void)chooseIndex:(ChooseIndex)chooseIndex {
    self.chooseIndex = chooseIndex;
}


- (void)hiddenView:(UITapGestureRecognizer *)tap {
    self.secondTitleBackgroundView.hidden = YES;
    self.secondTwoView.hidden =  YES;
    self.blurView.hidden = YES;
    UILabel * tapLabel = (UILabel *)[self viewWithTag:self.chooseSection + 100];
    UIImageView * chooseIcon = (UIImageView *)[self viewWithTag:150 + self.chooseSection];
    tapLabel.textColor = [UIColor blackColor];
    chooseIcon.image = [UIImage imageNamed:@"矩形-3-副本-2"];
}

/**
 *  加载选择列表
 *
 *  @param frame    选择列表的Frame
 *  @param iconArr  图标数组
 *  @param titleArr 标题数组
 *
 *  @return self
 */
- (id)initWithFrame:(CGRect)frame withIconArray:(NSArray *)iconArr titleArray:(NSArray *)titleArr {
    if (self = [super initWithFrame:frame]) {
        for (int i = 0; i < titleArr.count; i++) {
            
            UIView * backgroundView = [self addChooseViewFrame:CGRectMake(0, 30 * i, windowContentWidth, 30) withIconString:[[iconArr objectAtIndex:i] objectAtIndex:0] titleString:[titleArr objectAtIndex:i]];
            self.tempArray = iconArr;
            if (i == 0) {
                self.chooseSection = i;
                UIImageView * chooseImage = [[backgroundView subviews] objectAtIndex:0];
                chooseImage.image = [UIImage imageNamed:[[iconArr objectAtIndex:i] objectAtIndex:1]];
                UILabel * chooseLabel = [[backgroundView subviews] objectAtIndex:1];
                chooseLabel.textColor = [UIColor orangeColor];
            }
            backgroundView.tag = 300 + i;
            [self addSubview:backgroundView];
            
        }
        
        self.blurView = [[UIView alloc] initWithFrame:CGRectMake(0, 30 * iconArr.count, frame.size.width, frame.size.height)];
        self.blurView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenBlurView:)];
        [self.blurView addGestureRecognizer:tap];
        
        [self addSubview:_blurView];
        
    }
    return self;
}
- (void)hiddenBlurView:(UITapGestureRecognizer *)tap {
    self.hidden = YES;
}

/**
 *  加载带标题的筛选View
 *
 *  @param frame    位置
 *  @param iconStr  图标名称
 *  @param titleStr 标题名称
 *
 *  @return 筛选View
 */
- (UIView *)addChooseViewFrame:(CGRect)frame withIconString:(NSString *)iconStr titleString:(NSString *)titleStr {
    UIView * backgroundView = [[UIView alloc] initWithFrame:frame];
    backgroundView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topChooseView:)];
    [backgroundView addGestureRecognizer:tap];
    
    UIImage * icon = [UIImage imageNamed:iconStr];
    
    UIImageView * iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(M_LEFT_WIDTH, (frame.size.height - icon.size.height) / 2, icon.size.width, icon.size.height)];
    iconImage.image = icon;
    [backgroundView addSubview:iconImage];
    
    UILabel * titleLabel  = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(iconImage) + 10, 0, frame.size.width - ViewRight(iconImage) - 10, frame.size.height)];
    titleLabel.text = titleStr;
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.font = [UIFont systemFontOfSize:14];
    [backgroundView addSubview:titleLabel];
    
    return backgroundView;
}

- (void)topChooseView:(UITapGestureRecognizer *)tap {
    
    UIView * lastView = [tap.view.superview.subviews objectAtIndex:self.chooseSection];
    UIImageView * lastIconImage = [lastView.subviews objectAtIndex:0];
    lastIconImage.image = [UIImage imageNamed:[[self.tempArray objectAtIndex:self.chooseSection] objectAtIndex:0]];
    UILabel * lastTitleLabel = [lastView.subviews objectAtIndex:1];
    lastTitleLabel.textColor = [UIColor grayColor];
    
    
    UIImageView * iconImage = [tap.view.subviews objectAtIndex:0];
    iconImage.image = [UIImage imageNamed:[[self.tempArray objectAtIndex:tap.view.tag - 300] objectAtIndex:1]];
    UILabel * titleLabel = [tap.view.subviews objectAtIndex:1];
    titleLabel.textColor = [UIColor orangeColor];
    tap.view.superview.hidden = YES;
    NSIndexPath * index = [NSIndexPath indexPathForRow:tap.view.tag - 300 inSection:0];
    
    self.chooseSection = tap.view.tag - 300;
    self.chooseIndex (index);
}


- (id)initWithFrame:(CGRect)frame withChooseTitleArray:(NSArray *)titleArr {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        for (int i = 0; i < titleArr.count; i++) {
            
            UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
            but.frame = CGRectMake((frame.size.width / titleArr.count) * i, 0, frame.size.width / titleArr.count, frame.size.height);
            [but setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
            [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            but.backgroundColor = [UIColor whiteColor];
            but.tag = 400 + i;
            [but addTarget:self action:@selector(chooseLineBut:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:but];
            
            if (i == 0) {
                self.chooseSection = 400 + i;
                [but setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            }
            
            if (i < titleArr.count - 1) {
                UIView * halvingLineView = [[UIView alloc] initWithFrame:CGRectMake((frame.size.width / titleArr.count) * (i + 1) - 0.5, 0.15 * frame.size.height, 0.5, 0.7 * frame.size.height)];
                halvingLineView.backgroundColor = [UIColor orangeColor];
                [self addSubview:halvingLineView];
            }
        }
        
        if (!self.lineView) {
            self.lineView = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width / titleArr.count * 0.1, self.frame.size.height - 2, frame.size.width / titleArr.count * 0.8, 1.5)];
            self.lineView.backgroundColor = [UIColor orangeColor];
            [self addSubview:self.lineView];
        }
        
    }
    return self;
}

- (void)chooseLineBut:(UIButton *)button {
    button.enabled = NO;
    UIButton * but = (UIButton *)[self viewWithTag:self.chooseSection];
    [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:0.65 initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        _lineView.frame = CGRectMake(ViewX(button) + ViewWidth(button) * 0.1, ViewHeight(button) - 2 , ViewWidth(button) * 0.8 , 1.5);
        
    } completion:nil];
    
    self.chooseSection = button.tag;
    
    NSIndexPath * index = [NSIndexPath indexPathForRow:button.tag - 400 inSection:0];
    self.chooseIndex (index);
    button.enabled = YES;
}


- (void)chooseBut:(UIButton *)button {
    self.hidden = YES;
    NSIndexPath * index = [NSIndexPath indexPathForRow:button.tag - 100 inSection:0];
    self.chooseIndex (index);
}

- (id)initWithFrame:(CGRect)frame withCallTitleArray:(NSArray *)titleArr bigTitle:(NSString *)bigTitle butBackgroundColor:(NSArray *)colorArr {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(haidenView)];
        [self addGestureRecognizer:tap];
        
        UIView * backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(self) - titleArr.count * 60 - 20, ViewWidth(self), titleArr.count * 60 + 20)];
        backgroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backgroundView];
        for (int i = 0; i < titleArr.count; i++) {
            UIButton * but = [[UIButton alloc] initWithFrame:CGRectMake(15, 20 * (i + 1) + 40 * i , ViewWidth(backgroundView) - 30, 40)];
            [but setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
            [but setTintColor:[UIColor whiteColor]];
            but.backgroundColor = [colorArr objectAtIndex:i];
            but.tag = 100 + i;
            but.layer.cornerRadius = 3;
            but.layer.masksToBounds = YES;
            [but addTarget:self action:@selector(chooseBut:) forControlEvents:UIControlEventTouchUpInside];
            [backgroundView addSubview:but];
        }
    }
    
    return self;
}

- (void)haidenView {
    self.chooseTitle(@"隐藏");
    //self.hidden = YES;
}


- (void)addSecondTwoChooseView:(NSDictionary *)conditionDic {
    NSArray * keyArr = [conditionDic objectForKey:@"data"];
    
    if (!self.secondTwoView) {
        
        CGFloat viewHeight = windowContentHeight - M_tableView_row_height * keyArr.count - ViewBelow(self) > 100 ?  M_tableView_row_height * keyArr.count : windowContentHeight - ViewBelow(self) - 100;
        CGFloat height_view = viewHeight > M_tableView_row_height * 4 ? viewHeight : M_tableView_row_height * 4;
        self.secondTwoView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBelow(self), ViewWidth(self), height_view)];
        self.secondTwoView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.chooseRow = 0;
        
        self.firstTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth(self.secondTwoView) / 3, M_tableView_row_height * keyArr.count)];
        self.firstTableView.dataSource = self;
        self.firstTableView.delegate = self;
        self.firstTableView.tableFooterView = [[UIView alloc] init];
        self.firstTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.secondTwoView addSubview:self.firstTableView];
        
        self.secondTableView = [[UITableView alloc] initWithFrame:CGRectMake(ViewWidth(self.secondTwoView) / 3, 0, ViewWidth(self.secondTwoView) * 2 / 3, ViewHeight(self.secondTwoView))];
        self.secondTableView.delegate = self;
        self.secondTableView.dataSource = self;
        self.secondTableView.tableFooterView = [[UIView alloc] init];
        [self.secondTwoView addSubview:self.secondTableView];
        [self.superview addSubview:self.secondTwoView];
        
        
        [self addBlurViewWithView:self.secondTwoView];
        
    } else {
        
        self.secondTwoView.hidden = !self.secondTwoView.hidden;
        
        [self addBlurViewWithView:self.secondTwoView];
        [self hiddenBlurView];
        
        if (self.secondTwoView.hidden == NO) {
            [self.secondTableView reloadData];
        }
    }
}
#pragma mark ---- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.firstTableView) {
        NSArray * arr = [self.dataDic objectForKey:@"titleArr"];
        return arr.count;
    } else if (tableView == self.secondTableView) {
        
        NSArray * titleArr = [self.dataDic objectForKey:@"titleArr"];
        NSArray * arr = [[self.dataDic objectForKey:@"data"] objectForKey:[titleArr objectAtIndex:self.chooseRow]];
        return arr.count;
    } else if ([tableView isEqual:self.thirdTableView] ){
        NSArray * arr = [self.oneLineFilterDic objectForKey:@"title"];
        return arr.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.secondTableView) {
        static NSString * cellIdentifier = @"CellSecond";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.separatorInset = UIEdgeInsetsZero;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        //        if (!self.chooseRow) {
        //            self.chooseRow = 0;
        //        }
        NSArray * titleArr = [self.dataDic objectForKey:@"titleArr"];
        NSArray * arr = [[self.dataDic objectForKey:@"data"] objectForKey:[titleArr objectAtIndex:self.chooseRow]];
        cell.textLabel.text = [arr objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        if ([self.loadSectonRowDic objectForKey:[titleArr objectAtIndex:self.chooseRow]]) {
            NSString * rowStr = [self.loadSectonRowDic objectForKey:[titleArr objectAtIndex:self.chooseRow]];
            if (indexPath.row == [rowStr integerValue]) {
                cell.textLabel.textColor = [UIColor orangeColor];
            } else {
                cell.textLabel.textColor = [UIColor blackColor];
                
            }
        } else {
            cell.textLabel.textColor = [UIColor blackColor];
            
        }
        
        return cell;
    } else if (tableView == self.firstTableView) {
        static NSString * cellIdentifierFirst = @"CellFirst";
        ZFJChooseCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierFirst];
        if (!cell) {
            cell = [[ZFJChooseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierFirst];
            cell.separatorInset = UIEdgeInsetsZero;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.iconImage.image = [UIImage imageNamed:[[self.dataDic objectForKey:@"icon"] objectAtIndex:indexPath.row]];
        cell.titleLabel.text = [[self.dataDic objectForKey:@"titleArr"] objectAtIndex:indexPath.row];
        return cell;
    } else if ([tableView isEqual:self.thirdTableView]){
        static NSString * cellIdentifierThrid = @"CellThird";
        ZFJChooseCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierThrid];
        if (!cell) {
            cell = [[ZFJChooseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierThrid];
            cell.separatorInset = UIEdgeInsetsZero;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.preservesSuperviewLayoutMargins = NO;
            cell.layoutMargins = UIEdgeInsetsZero;
        }
        UIImage * image = [UIImage imageNamed:[[self.oneLineFilterDic objectForKey:@"icon"] objectAtIndex:indexPath.row]];
        cell.iconImage.frame = CGRectMake(ViewX(cell.iconImage), (M_tableView_row_height - image.size.height)/2, image.size.width, image.size.height);
        cell.iconImage.image = image;
        cell.titleLabel.text = [[self.oneLineFilterDic objectForKey:@"title"] objectAtIndex:indexPath.row];
        return cell;

    }
    return nil;
}
#pragma mark ---- UITableViewDelagate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return M_tableView_row_height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.firstTableView]) {
        NSIndexPath * index = [NSIndexPath indexPathForRow:self.chooseRow inSection:indexPath.section];
        ZFJChooseCell * lastCell = (ZFJChooseCell *)[tableView cellForRowAtIndexPath:index];
        lastCell.titleLabel.textColor = [UIColor blackColor];
        NSArray *lastIconArr = [self.dataDic objectForKey:@"icon"];
        NSString * lastIcon = [lastIconArr objectAtIndex:self.chooseRow];
        lastCell.iconImage.image = [UIImage imageNamed:lastIcon];
        self.lastChooseRow = self.chooseRow;
        
        self.chooseRow = indexPath.row;
        ZFJChooseCell * cell = (ZFJChooseCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        NSArray *iconArr = [self.dataDic objectForKey:@"chooseIcon"];
        NSString * icon = [iconArr objectAtIndex:self.chooseRow];
        cell.iconImage.image = [UIImage imageNamed:icon];
        cell.titleLabel.textColor = [UIColor orangeColor];
        [self.secondTableView reloadData];
    } else if ([tableView isEqual:self.secondTableView]) {
        //self.secondTwoView.hidden = YES;
        [self hiddenView:self.blurView.gestureRecognizers[0]];
        NSArray * titleArr = [self.dataDic objectForKey:@"titleArr"];
        if ([self.loadSectonRowDic objectForKey:[titleArr objectAtIndex:self.chooseRow]]) {
            NSString * lastRow = [self.loadSectonRowDic objectForKey:[titleArr objectAtIndex:self.chooseRow]];
            NSIndexPath * lastIndex = [NSIndexPath indexPathForRow:[lastRow integerValue] inSection:indexPath.section];
            UITableViewCell * lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            lastCell.textLabel.textColor = [UIColor blackColor];
        }
       
        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.textLabel.textColor = [UIColor orangeColor];
        NSIndexPath * index = [NSIndexPath indexPathForRow:indexPath.row inSection:self.chooseRow];
        
        [self.loadSectonRowDic setObject:[NSString stringWithFormat:@"%ld", indexPath.row] forKey:[titleArr objectAtIndex:self.chooseRow]];
        //self.secondTwoView.hidden =
        if (self.chooseSectionRow) {
            self.chooseSectionRow(self.chooseSection, index);
        }
    } else if ([tableView isEqual:self.thirdTableView]){
        
        NSIndexPath * index = [NSIndexPath indexPathForRow:self.chooseFilterOneLineRow inSection:indexPath.section];
        ZFJChooseCell * lastCell = (ZFJChooseCell *)[tableView cellForRowAtIndexPath:index];
        lastCell.titleLabel.textColor = [UIColor blackColor];
        NSArray *lastIconArr = [self.oneLineFilterDic objectForKey:@"icon"];
        NSString * lastIcon = [lastIconArr objectAtIndex:self.chooseFilterOneLineRow];
        lastCell.iconImage.image = [UIImage imageNamed:lastIcon];
        
        ZFJChooseCell * cell = (ZFJChooseCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        NSArray *iconArr = [self.oneLineFilterDic objectForKey:@"chooseIcon"];
        NSString * icon = [iconArr objectAtIndex:indexPath.row];
        cell.iconImage.image = [UIImage imageNamed:icon];
        cell.titleLabel.textColor = [UIColor orangeColor];
        self.chooseFilterOneLineRow = indexPath.row;
        
        if (self.chooseSectionRow) {
            self.chooseSectionRow(self.chooseSection, indexPath);
        }
        self.secondTitleBackgroundView.hidden = YES;
        [self hiddenBlurView];
        [self hiddenView:nil];
    }
}
- (void)chooseSectionRow:(ChooseSectionRow)choose {
    self.chooseSectionRow = choose;
}

- (void)addBlurViewWithView:(UIView *)view {
    if (!self.blurView) {
        
        self.blurView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBelow(view), ViewWidth(view), ViewHeight(self.superview) - ViewBelow(view))];
        self.blurView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.4];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenView:)];
        [self.blurView addGestureRecognizer:tap];
        [self.superview addSubview:self.blurView];
    } else {
        self.blurView.hidden = NO;
        self.blurView.frame = CGRectMake(0, ViewBelow(view), ViewWidth(view), ViewHeight(self.superview) - ViewBelow(view));
    }
}

- (void)hiddenBlurView {
    
    if (self.secondTitleBackgroundView.hidden == YES && self.secondTwoView.hidden == YES) {
        self.blurView.hidden = YES;
        
    } else if (!self.secondTitleBackgroundView && self.secondTwoView.hidden == YES){
        self.blurView.hidden = YES;
        
    } else if (!self.secondTwoView && self.secondTitleBackgroundView.hidden == YES) {
        self.blurView.hidden = YES;
        
    } else {
        self.blurView.hidden = NO;
    }
}

- (NSMutableDictionary *)loadSectonRowDic {
    if (!_loadSectonRowDic) {
        self.loadSectonRowDic = [NSMutableDictionary dictionary];
    }
    return _loadSectonRowDic;
}

@end


@implementation ZFJChooseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 20, 20)];
        
        [self addSubview:_iconImage];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(_iconImage) + 5, 0, ViewWidth(self) - ViewX(_titleLabel), 30)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_titleLabel];
    }
    return self;
}



@end


