//
//  ZFJHotelFilterViewVC.m
//  WelLv
//
//  Created by zhangjie on 15/10/2.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJHotelFilterViewVC.h"
#define M_HadereView_height 44
#import "HotelBrandsModel.h"
#import "HotelThemeModel.h"
#import "HotelFacilityModel.h"
#import "HotelListLeftCell.h"
#import "HotelListRightCell.h"
#import "WWHHotelTopListBtn.h"
#import "WWHTopBtnScrollView.h"
#import "HotelListRightCellSec.h"
#import "HotelListRightCellThree.h"
#define CELLSELECTSTATE @"CELLSELECTSTATE"//保存cell的选中状态

@interface ZFJHotelFilterViewVC ()<UITableViewDataSource, UITableViewDelegate, WWHHotelTopListBtnDelegate>

@property (nonatomic, strong) MBProgressHUD * hud;
@property (nonatomic, strong) UITableView * firstTableView;
@property (nonatomic, strong) UITableView * firstOfRightTableView;
@property (nonatomic, strong) UITableView * sectOfRightTableView;
@property (nonatomic, strong) UITableView * thrtOfRightTableView;

@property (nonatomic, strong) NSMutableArray *brandsArray;//品牌
@property (nonatomic, strong) NSMutableArray *themeArray;//主题
@property (nonatomic, strong) NSMutableArray *facilityArray;//设施
@property (nonatomic, strong) NSMutableArray *toatlArray;//总的数组，用于存放上面三个数组


@property (nonatomic, strong) NSMutableArray *brandsCellArrayState;//品牌数组用于存放cell的选中状态
@property (nonatomic, strong) NSMutableArray *themeArrayState;
@property (nonatomic, strong) NSMutableArray *facilityArrayState;


@property (nonatomic, strong) HotelListLeftCell * selectLeftCell;//记录选中的LeftCell
@property (nonatomic, strong) HotelListRightCell * selectRightCell;//记录选中的RightCell

@property (nonatomic, assign) NSInteger fiestTableViewSelectRow;//第一个tableView的选中行
@property (nonatomic, assign) NSInteger secondTableViewSelectRow;//第二个tableView的选中行
@property (nonatomic, assign) NSInteger thirdTableViewSelectRow;//第三个tableView的选中行

@property (nonatomic, strong) UIView  *topBtnView;//视图顶栏的视图
@property (nonatomic, strong) UIScrollView  *topBtnScrollView;
@property (nonatomic, strong) NSMutableArray *topBtnArray;
@end

@implementation ZFJHotelFilterViewVC


#pragma mark -懒加载
-(NSMutableArray *)brandsArray
{

    if (_brandsArray == nil) {
        _brandsArray = [NSMutableArray array];
    }
    return _brandsArray;
}
-(NSMutableArray *)themeArray
{
    
    if (_themeArray == nil) {
        _themeArray = [NSMutableArray array];
    }
    return _themeArray;
}
-(NSMutableArray *)facilityArray
{
    
    if (_facilityArray == nil) {
        _facilityArray = [NSMutableArray array];
    }
    return _facilityArray;
}

-(NSMutableArray *)topBtnArray
{
    if (_topBtnArray == nil) {
        _topBtnArray = [NSMutableArray array];
    }
    return _topBtnArray;
}

-(NSMutableArray *)brandsCellArrayState
{
    if (_brandsCellArrayState == nil) {
        _brandsCellArrayState = [NSMutableArray array];
    }
    return _brandsCellArrayState;

}

-(NSMutableArray *)themeArrayState
{
    if (_themeArrayState == nil) {
        _themeArrayState = [NSMutableArray array];
    }
    return _themeArrayState;
}

-(NSMutableArray *)facilityArrayState
{
    if (_facilityArrayState == nil) {
        _facilityArrayState = [NSMutableArray array];
    }
    return _facilityArrayState;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"筛选";
    self.view.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
    [self addCustomView];
    [self getData];
}
#pragma mark --- 获取数据
-(void)getData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
     NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.citycode,@"citycode", nil];

    
    [self setProgressHud];
    
    [manager POST:HotelFilter parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString *code =[NSString stringWithFormat:@"%@",dic[@"Success"]] ;
        [_hud hide:YES];
        if ([code isEqualToString:@"1"]) {
            NSDictionary *resultDic = dic[@"Data"];
            [self.brandsArray removeAllObjects];
            [self.themeArray removeAllObjects];
            [self.facilityArray removeAllObjects];
             NSArray *brandArray = resultDic[@"brands"];
            for (NSDictionary *dic in brandArray) {
                HotelBrandsModel *brandsModel = [[HotelBrandsModel alloc] initWithDic:dic];
                [self.brandsArray addObject:brandsModel];
            }
            
            HotelBrandsModel *brandsModel = [[HotelBrandsModel alloc] init];
            brandsModel.brandname = @"不限";
            brandsModel.brandcode = @"-1";
            [self.brandsArray insertObject:brandsModel atIndex:0];
            
            for (int i = 0; i < self.brandsArray.count; i++) {
                NSDictionary *stateCellDic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",CELLSELECTSTATE, nil];
                [self.brandsCellArrayState addObject:stateCellDic];
              }
            [self writeFileArrayWithFirstTableViewCell:0 andArray:self.brandsCellArrayState];
            
            
            NSArray *themeIdsArray = resultDic[@"themeIds"];
            for (NSDictionary *dic in themeIdsArray) {
                HotelThemeModel *brandsModel = [[HotelThemeModel alloc] initWithDic:dic];
                [self.themeArray addObject:brandsModel];
            }
            HotelThemeModel *themeModel = [[HotelThemeModel alloc] init];
            themeModel.name = @"不限";
            themeModel.code = @"-1";
            [self.themeArray insertObject:themeModel atIndex:0];
            
            for (int i = 0; i < self.themeArray.count; i++) {
                NSDictionary *stateCellDic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",CELLSELECTSTATE, nil];
                [self.themeArrayState addObject:stateCellDic];
            }
            [self writeFileArrayWithFirstTableViewCell:1 andArray:self.themeArrayState];
            
            NSArray *facilArray = resultDic[@"facility"];
            for (NSDictionary *dic in facilArray) {
                HotelFacilityModel *brandsModel = [[HotelFacilityModel alloc] initWithDic:dic];
                [self.facilityArray addObject:brandsModel];
            }
            HotelFacilityModel *faciliModel = [[HotelFacilityModel alloc] init];
            faciliModel.name = @"不限";
            faciliModel.code = @"-1";
             [self.facilityArray insertObject:faciliModel atIndex:0];
            
            for (int i = 0; i < self.facilityArray.count; i++) {
                NSDictionary *stateCellDic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",CELLSELECTSTATE, nil];
                [self.facilityArrayState addObject:stateCellDic];
            }
            [self writeFileArrayWithFirstTableViewCell:2 andArray:self.facilityArrayState];
            
            
            self.toatlArray = [NSMutableArray arrayWithObjects:self.brandsArray,self.themeArray,self.facilityArray, nil];
           
            
            [self.firstTableView reloadData];
            self.fiestTableViewSelectRow = 0;
            self.firstOfRightTableView.hidden = NO;
            [self.firstOfRightTableView reloadData];
            
        }
        else
        {
            [[LXAlterView sharedMyTools]createTishi:[dic valueForKey:@"msg"]];
            
        }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_hud hide:YES];
        [[LXAlterView sharedMyTools]createTishi:@"请求失败,请检查网络!"];
    }];
}
#pragma mark ----- dismissButton
- (void)dismissVC:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
#pragma mark --- 加载TableView
/**
 *    加载TableView
 */
- (void)addCustomView {
    _topBtnScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 30)];
    [self.view addSubview:_topBtnScrollView];
    UIView *buttomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 29, windowContentWidth, 1)];
    buttomLine.backgroundColor =  [UIColor colorWithRed:218/255.0 green:218/255.0 blue:218/255.0 alpha:1];
    buttomLine.alpha = 0.8;
    [_topBtnScrollView addSubview:buttomLine];
    
    
    self.firstTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 31, windowContentWidth / 3.0, ControllerViewHeight - 30)];
    self.firstTableView.backgroundColor  = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
    self.firstTableView.dataSource = self;
    self.firstTableView.delegate = self;
    self.firstTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.firstTableView.separatorColor = [UIColor whiteColor];
    self.firstTableView.tableFooterView = [[UIView alloc] init];;
    [self.view addSubview:_firstTableView];
    
    self.firstOfRightTableView = [[UITableView alloc] initWithFrame:CGRectMake(ViewRight(_firstTableView), 31, windowContentWidth * 2/ 3.0, ControllerViewHeight - 30)];
    self.firstOfRightTableView.dataSource = self;
    self.firstOfRightTableView.delegate = self;
    self.firstOfRightTableView.backgroundColor = [UIColor whiteColor];
    self.firstOfRightTableView.tableFooterView = [[UIView alloc] init];
    self.firstOfRightTableView.hidden = YES;
    [self.view addSubview:self.firstOfRightTableView];
    
    self.sectOfRightTableView = [[UITableView alloc] initWithFrame:CGRectMake(ViewRight(_firstTableView), 31, windowContentWidth * 2/ 3.0, ControllerViewHeight - 30)];
    self.sectOfRightTableView.dataSource = self;
    self.sectOfRightTableView.delegate = self;
    self.sectOfRightTableView.hidden = YES;
    self.sectOfRightTableView.backgroundColor = [UIColor whiteColor];
    self.sectOfRightTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.sectOfRightTableView];
    
    self.thrtOfRightTableView = [[UITableView alloc] initWithFrame:CGRectMake(ViewRight(_firstTableView), 31, windowContentWidth * 2/ 3.0, ControllerViewHeight - 30)];
    self.thrtOfRightTableView.dataSource = self;
    self.thrtOfRightTableView.delegate = self;
    self.thrtOfRightTableView.backgroundColor = [UIColor whiteColor];
    self.thrtOfRightTableView.tableFooterView = [[UIView alloc] init];
    self.thrtOfRightTableView.hidden = YES;
    [self.view addSubview:self.thrtOfRightTableView];
    
    
    
    
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, windowContentHeight - NavHeight - M_HadereView_height, windowContentWidth, M_HadereView_height)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *lineLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 1)];
    lineLabel1.backgroundColor = [UIColor colorWithRed:252/255.0 green:131/255.0 blue:8/255.0 alpha:1];
    [headerView addSubview:lineLabel1];
    
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.center = CGPointMake(windowContentWidth/2.0, headerView.frame.size.height/2.0);
    sureBtn.bounds = CGRectMake(0, 0, 100, 20);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor colorWithRed:252/255.0 green:131/255.0 blue:8/255.0 alpha:1] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:sureBtn];
    
    [self.view addSubview:headerView];
 }

#pragma mark -确定按钮
-(void)sureBtnClick
{
    


}
#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.firstTableView) {
        return self.toatlArray.count;
    }
    else
    {
        NSArray *secArray = self.toatlArray[self.fiestTableViewSelectRow];
        return  secArray.count;
     }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     UITableViewCell *resultCell = nil;
    if ([tableView isEqual:self.firstTableView]) {
        static NSString * cellIdentifier = @"firstCell";
        HotelListLeftCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[HotelListLeftCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            NSInteger selectedIndex = 0;
            NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
            [self.firstTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            }
        if (indexPath.row == 0) {
            cell.name = @"品牌";
        }
        else if (indexPath.row == 1)
        {
            cell.name = @"主题";
        }
        else
        {
            cell.name = @"设施";
         }
        resultCell  = cell;

    }
else
    {
        
        if (self.fiestTableViewSelectRow == 0){
            self.firstOfRightTableView.hidden = NO;
            self.sectOfRightTableView.hidden = YES;
            self.thrtOfRightTableView.hidden = YES;
            static NSString *cellIdentifier = @"firstOfRightTableView";
            HotelListRightCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) {
                cell = [[HotelListRightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray *resultArray = [self isSelectDicWithFirstTableViewCell:0];
            HotelBrandsModel *brandsModel = self.brandsArray[indexPath.row];
            
            cell.name = brandsModel.brandname;
            
            NSDictionary  *resultDic =[resultArray objectAtIndex:indexPath.row];
            
            if ([[resultDic objectForKey:CELLSELECTSTATE] isEqualToString:@"YES"]) {
                cell.imageSelect = YES;
            }
            else
            {
                cell.imageSelect = NO;
            }
            
            resultCell  = cell;
        
        }
        else if (self.fiestTableViewSelectRow == 1)
        {
            self.firstOfRightTableView.hidden = YES;
            self.sectOfRightTableView.hidden = NO;
            self.thrtOfRightTableView.hidden = YES;
            static NSString * cellIdentifier = @"secOfRightTableView";
            HotelListRightCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) {
                cell = [[HotelListRightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            //cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray *resultArray = [self isSelectDicWithFirstTableViewCell:1];
            HotelThemeModel *brandsModel = self.themeArray[indexPath.row];
            cell.name = brandsModel.name;
            NSDictionary  *resultDic =[resultArray objectAtIndex:indexPath.row];
            
            if ([[resultDic objectForKey:CELLSELECTSTATE] isEqualToString:@"YES"]) {
                cell.imageSelect = YES;
            }
            else
            {
                cell.imageSelect = NO;
            }
            
            resultCell  = cell;
        }
        else
        {
            self.firstOfRightTableView.hidden = YES;
            self.sectOfRightTableView.hidden = YES;
            self.thrtOfRightTableView.hidden = NO;
            static NSString *cellIdentifier = @"thrOfRightTableView";
            HotelListRightCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) {
                cell = [[HotelListRightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            HotelFacilityModel *brandsModel = self.facilityArray[indexPath.row];
            cell.name = brandsModel.name;
            NSArray *resultArray = [self isSelectDicWithFirstTableViewCell:2];
            NSDictionary  *resultDic =[resultArray objectAtIndex:indexPath.row];
            
            if ([[resultDic objectForKey:CELLSELECTSTATE] isEqualToString:@"YES"]) {
                cell.imageSelect = YES;
            }
            else
            {
                cell.imageSelect = NO;
            }
            
            resultCell  = cell;
        
        }
    }
    return resultCell;
}
//#pragma mark --- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.firstTableView) {
        self.fiestTableViewSelectRow = indexPath.row;
         if (indexPath.row == 0) {
            self.firstOfRightTableView.hidden = NO;
            self.sectOfRightTableView.hidden = YES;
            self.thrtOfRightTableView.hidden = YES;
            [self.firstOfRightTableView reloadData];
        }
        else if (indexPath.row == 1)
        {
            self.firstOfRightTableView.hidden = YES;
            self.sectOfRightTableView.hidden = NO;
            self.thrtOfRightTableView.hidden = YES;
            [self.sectOfRightTableView reloadData];
        }
        else
        {
            self.firstOfRightTableView.hidden = YES;
            self.sectOfRightTableView.hidden = YES;
            self.thrtOfRightTableView.hidden = NO;
           [self.thrtOfRightTableView reloadData];
        }
        
        self.selectLeftCell.selected = NO;
        HotelListLeftCell * lastCell = (HotelListLeftCell *)[tableView cellForRowAtIndexPath:indexPath];
        lastCell.selected = YES;
        self.selectLeftCell = lastCell;
        
        
    }
else
    {
        HotelListRightCell * lastCell = (HotelListRightCell *)[tableView cellForRowAtIndexPath:indexPath];
        NSArray *resultArray =  [self isSelectDicWithFirstTableViewCell:self.fiestTableViewSelectRow];
        NSDictionary *resultDic = resultArray[indexPath.row];
        NSString *selectStateStr = [resultDic objectForKey:CELLSELECTSTATE];
        
        if ([selectStateStr isEqualToString:@"YES"]) {
            lastCell.imageSelect = NO;
            NSDictionary *resultDic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",CELLSELECTSTATE, nil];
            if (self.fiestTableViewSelectRow == 0) {
                [self.brandsCellArrayState replaceObjectAtIndex:indexPath.row withObject:resultDic];
                [self writeFileArrayWithFirstTableViewCell:0 andArray:self.brandsCellArrayState];
                 HotelBrandsModel *brandsModel = self.brandsArray[indexPath.row];
                [self addModelToViewWithModel:brandsModel withFirstCell:0 secendCell:indexPath.row andIsSelect:NO];
            }
            else if (self.fiestTableViewSelectRow == 1)
            {
             [self.themeArrayState replaceObjectAtIndex:indexPath.row withObject:resultDic];
                HotelThemeModel *brandsModel = self.themeArray[indexPath.row];
                [self writeFileArrayWithFirstTableViewCell:1 andArray:self.themeArrayState];
                [self addModelToViewWithModel:brandsModel withFirstCell:1 secendCell:indexPath.row andIsSelect:NO];

            }
            else
            {
                
             [self.facilityArrayState replaceObjectAtIndex:indexPath.row withObject:resultDic];
                [self writeFileArrayWithFirstTableViewCell:2 andArray:self.facilityArrayState];
                HotelFacilityModel *brandsModel = self.facilityArray[indexPath.row];
               [self addModelToViewWithModel:brandsModel withFirstCell:2 secendCell:indexPath.row andIsSelect:NO];


            }
         }
        else
        {
        lastCell.imageSelect = YES;
             NSDictionary *resultDic = [NSDictionary dictionaryWithObjectsAndKeys:@"YES",CELLSELECTSTATE, nil];
            if (self.fiestTableViewSelectRow == 0) {
                [self.brandsCellArrayState replaceObjectAtIndex:indexPath.row withObject:resultDic];
                [self writeFileArrayWithFirstTableViewCell:0 andArray:self.brandsCellArrayState];
                HotelBrandsModel *brandsModel = self.brandsArray[indexPath.row];
                [self addModelToViewWithModel:brandsModel withFirstCell:0 secendCell:indexPath.row andIsSelect:YES];
            }
            else if (self.fiestTableViewSelectRow == 1)
            {
                [self.themeArrayState replaceObjectAtIndex:indexPath.row withObject:resultDic];
                [self writeFileArrayWithFirstTableViewCell:1 andArray:self.themeArrayState];
                HotelThemeModel *brandsModel = self.themeArray[indexPath.row];
                [self addModelToViewWithModel:brandsModel withFirstCell:1 secendCell:indexPath.row andIsSelect:YES];
               
            }
            else
            {
                [self.facilityArrayState replaceObjectAtIndex:indexPath.row withObject:resultDic];
                 [self writeFileArrayWithFirstTableViewCell:2 andArray:self.facilityArrayState];
                HotelFacilityModel *brandsModel = self.facilityArray[indexPath.row];
                [self addModelToViewWithModel:brandsModel withFirstCell:2 secendCell:indexPath.row andIsSelect:YES];

            }
         }
     }
 }

//读取tableviewcell的选中状态
-(NSArray *)isSelectDicWithFirstTableViewCell:(NSInteger)firstTableViewCell
{
    NSArray *resultArray = [NSArray arrayWithContentsOfFile:[self pathFileFileDicWithFirstTableViewCell:firstTableViewCell]];
    return resultArray;
}
//写入tableviewcell的选中状态
- (void)writeFileArrayWithFirstTableViewCell:(NSInteger)firstTableViewCell andArray:(NSMutableArray *)resultArray
{
    NSString *filePath = [self pathFileFileDicWithFirstTableViewCell:firstTableViewCell];
    [resultArray writeToFile:filePath atomically:YES];
}

//获取路径
-(NSString *)pathFileFileDicWithFirstTableViewCell:(NSInteger)firstTableViewCell
{
    NSString *firstTableViewCellStr = [NSString stringWithFormat:@"%ld",firstTableViewCell];
   NSString *documentFile = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject];
  documentFile =  [documentFile stringByAppendingString:firstTableViewCellStr];
    return documentFile;
}


-(void)addModelToViewWithModel:(id)model withFirstCell:(NSInteger)firstCell secendCell:(NSInteger)secendCell andIsSelect:(BOOL)isSelect
{
    
   
    if (isSelect) {
        
        WWHHotelTopListBtn *topListBtn = [[WWHHotelTopListBtn alloc] initWithFrame:CGRectMake(0, 0, 120, 30) topListBtnWithModel:model andFirstCell:firstCell sectCell:secendCell andIsSelect:isSelect];
        topListBtn.backgroundColor = [UIColor whiteColor];
        topListBtn.delegate = self;
        [self.topBtnArray addObject:topListBtn];
    }
    else
    {
        for (NSInteger i = 0; i < _topBtnScrollView.subviews.count; i++) {
            UIView *view = _topBtnScrollView.subviews[i];
            [view removeFromSuperview];
        }
        for (int i = 0; i < self.topBtnArray.count; i++) {
            WWHHotelTopListBtn *topListBtn = self.topBtnArray[i];
            if (topListBtn.firstCellRow == firstCell && topListBtn.secCellRow == secendCell) {
                [self.topBtnArray removeObject:topListBtn];
                //break;
            }
        }
      }
    for (NSInteger i = 0; i < _topBtnScrollView.subviews.count; i++) {
        UIView *view = _topBtnScrollView.subviews[i];
        [view removeFromSuperview];
    }
    
    for (NSInteger i = 0; i < self.topBtnArray.count; i++) {
        WWHHotelTopListBtn *topListBtn = self.topBtnArray[i];
        topListBtn.frame = CGRectMake(i * 120, 0, 120, 30);
        [_topBtnScrollView addSubview:topListBtn];
    
    }
    
    if (self.topBtnArray.count * 120 >= windowContentWidth) {
        _topBtnScrollView.contentSize = CGSizeMake(self.topBtnArray.count * 120, 30);
        [_topBtnScrollView scrollRectToVisible:CGRectMake(0, 0, self.topBtnArray.count * 120 + 20, 30) animated:NO];
    }
    
 }

#pragma mark -顶部按钮点击
-(void)hotelTopBtnClickWithFirstCell:(NSInteger)first sectCell:(NSInteger)sectCell
{
    
    for (int i = 0; i < self.topBtnArray.count; i++) {
        WWHHotelTopListBtn *topListBtn = self.topBtnArray[i];
        if (topListBtn.firstCellRow == first && topListBtn.secCellRow == sectCell) {
            [self.topBtnArray removeObject:topListBtn];

        }
    }
    
    for (NSInteger i = 0; i < _topBtnScrollView.subviews.count; i++) {
        UIView *view = _topBtnScrollView.subviews[i];
        [view removeFromSuperview];
    }
    
    for (NSInteger i = 0; i < self.topBtnArray.count; i++) {
            WWHHotelTopListBtn *topListBtn = self.topBtnArray[i];
            topListBtn.frame = CGRectMake(i * 120, 0, 120, 30);
            [_topBtnScrollView addSubview:topListBtn];
        }
    if (self.topBtnArray.count * 120 >= windowContentWidth) {
            _topBtnScrollView.contentSize = CGSizeMake(self.topBtnArray.count * 120, 30);
            [_topBtnScrollView scrollRectToVisible:CGRectMake(0, 0, self.topBtnArray.count * 120 + 20, 30) animated:NO];
        }

     
    NSDictionary *resultDic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",CELLSELECTSTATE, nil];
    if (first == 0) {
        NSIndexPath *indexPath = [NSIndexPath  indexPathForRow:sectCell inSection:0];
        HotelListRightCell * lastCell = (HotelListRightCell *)[self.firstOfRightTableView cellForRowAtIndexPath:indexPath];
        lastCell.imageSelect = NO;
        [self.brandsCellArrayState replaceObjectAtIndex:sectCell withObject:resultDic];
        [self writeFileArrayWithFirstTableViewCell:0 andArray:self.brandsCellArrayState];
    }
    else if (first == 1)
    {
        NSIndexPath *indexPath = [NSIndexPath  indexPathForRow:sectCell inSection:0];
        HotelListRightCellSec * lastCell = (HotelListRightCellSec *)[self.sectOfRightTableView cellForRowAtIndexPath:indexPath];
        lastCell.imageSelect = NO;
        [self.themeArrayState replaceObjectAtIndex:sectCell withObject:resultDic];
        [self writeFileArrayWithFirstTableViewCell:1 andArray:self.themeArrayState];
    }
    else
    {
        NSIndexPath *indexPath = [NSIndexPath  indexPathForRow:sectCell inSection:0];
        HotelListRightCellThree * lastCell = (HotelListRightCellThree *)[self.thrtOfRightTableView cellForRowAtIndexPath:indexPath];
        lastCell.imageSelect = NO;
        [self.facilityArrayState replaceObjectAtIndex:sectCell withObject:resultDic];
        [self writeFileArrayWithFirstTableViewCell:2 andArray:self.facilityArrayState];
    }
}
//数据加载完成之前显示转动的菊花圈
- (void)setProgressHud
{
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.labelText = @"正在加载...";
    [self.view addSubview:_hud];
    [_hud show:YES];
}

@end
