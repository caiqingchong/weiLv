//
//  ZFJChooseCityVC.m
//  WelLv
//
//  Created by 张发杰 on 15/6/11.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJChooseCityVC.h"
#import "ZFJChooseCityCell.h"
#import "ZFJChooseCityHeaderView.h"
#import "LXGetCityIDTool.h"
#import "YXLocationManage.h"
#import "UIDefines.h"
#import "WLDestinationModel.h"

#define M_HadereView_height 65

#define CELL_INDENTIFIER @"Cell"
#define HEADER_INDENTIFIER @"Header"

@interface ZFJChooseCityVC ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, copy) ChooseCityBlock chooseCityBlock;

@property (nonatomic, strong) UICollectionView * chooseCollectionView;
@property (nonatomic, strong) NSMutableArray * sectionYArr;

@property (nonatomic, strong) NSMutableArray * titleArray;

@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) UILabel * nowLocationLabel;
@property (nonatomic, copy) NSString * chooseCityStr;
@property (nonatomic, strong) NSMutableArray * hotCityArray;
@property (nonatomic, copy) SelectCityInfo cityInfo;
@property (nonatomic,strong)MBProgressHUD *hud;

//返回最上方的button
@property (nonatomic,strong)UIButton *toTopButton;

@end

@implementation ZFJChooseCityVC
- (id)initWithAddress:(ChooseCityBlock)cityAddress{
    if (self =[super init]) {
        self.chooseCityBlock = cityAddress;
    }
    return self;
}


- (UIButton *)toTopButton{
    
    if (!_toTopButton) {
        _toTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_toTopButton setImage:[UIImage imageNamed:@"TOP向上"] forState:UIControlStateNormal];
        [_toTopButton addTarget:self action:@selector(topButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _toTopButton;
    
}

- (void)topButtonClick:(UIButton*)sender{
    
    
    [self.chooseCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    
    
}

#pragma mark ------- 加载等待页  增加用户体验

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScreenEdgePanGestureRecognizer * screenEdgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(backView:)];
    screenEdgePan.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:screenEdgePan];
    
    [self.view addSubview:[self addHeaderView]];
    [self addCollectionView];
    
    if (!self.isDestinationSelect) {
        
        [self loadData];
        [self loadHotCityData];
    }else{
        
        [self setProgressHud];
        [self loadDestinationCitys];
        
    }
  
}

- (void)backView:(UIScreenEdgePanGestureRecognizer *)recongnizer
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ----- addHeaderView
- (UIView *)addHeaderView
{
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, M_HadereView_height)];
    
    UIImageView * dismissIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 35, 20, 20)];
    dismissIcon.image = [UIImage imageNamed:@"关闭"];
    dismissIcon.userInteractionEnabled = YES;
    [headerView addSubview:dismissIcon];
    
    UIButton * dismissBut = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissBut.frame = CGRectMake(15, 25, 30, 30);
    [dismissBut addTarget:self action:@selector(dismissChooseCityView:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:dismissBut];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(windowContentWidth / 2 - 40, 25, 80, 30)];
    titleLabel.text = @"选择城市";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(headerView) + ViewY(headerView) - 0.5, windowContentWidth, 0.5)];
    lineView.backgroundColor = bordColor;
    [headerView addSubview:lineView];
    [headerView addSubview:titleLabel];
    return headerView;
}

#pragma mark ----- dismissButton
- (void)dismissChooseCityView:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
#pragma mark ---- addNowLocationView
- (void)addNowLocationView
{
    UILabel * locatinLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, M_HadereView_height, windowContentWidth, 30)];
    locatinLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:locatinLabel];
    
    UIView * locationView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(locatinLabel) + ViewY(locatinLabel), windowContentWidth, 40)];
    locationView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:locationView];
}


#pragma mark ----- add

- (void)addCollectionView{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake((windowContentWidth - 0.5 * 4) / 5, 40);
    layout.headerReferenceSize = CGSizeMake(windowContentHeight, 30);
    layout.minimumInteritemSpacing = 0.5;
    layout.minimumLineSpacing = 0.5;
    
    
    
    self.chooseCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, M_HadereView_height, windowContentWidth, windowContentHeight - M_HadereView_height) collectionViewLayout:layout];
    if (!self.isDestinationSelect) {
        self.chooseCollectionView.contentInset = UIEdgeInsetsMake(70, 0, 0, 0);
    }else{
        self.chooseCollectionView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
        
    }
    
    _chooseCollectionView.backgroundColor = [UIColor whiteColor];
    _chooseCollectionView.dataSource = self;
    _chooseCollectionView.delegate = self;
    
    [_chooseCollectionView registerClass:[ZFJChooseCityCell class] forCellWithReuseIdentifier:CELL_INDENTIFIER];
    [self.view addSubview:_chooseCollectionView];
    
    //注册区头视图;
    [_chooseCollectionView registerClass:[ZFJChooseCityHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADER_INDENTIFIER];
    
    if (!self.isDestinationSelect) {
        
        UILabel * locatinLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -70, windowContentWidth, 30)];
        locatinLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        locatinLabel.text = @"   当前定位城市";
        locatinLabel.font = [UIFont systemFontOfSize:15];
        locatinLabel.textColor = [UIColor grayColor];
        [_chooseCollectionView addSubview:locatinLabel];
        
        UIView * locationView = [[UIView alloc] initWithFrame:CGRectMake(0, -40, windowContentWidth, 40)];
        locationView.backgroundColor = [UIColor whiteColor];
        
        UIImageView * locationImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 8, 20, 22)];
        //locationImage.backgroundColor = [UIColor orangeColor];
        locationImage.image = [UIImage imageNamed:@"TimePoint"];
        [locationView addSubview:locationImage];
        
        self.nowLocationLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(locationImage) + ViewWidth(locationImage) + 10, 5, 200, 30)];
        _nowLocationLabel.numberOfLines = 0;
        _nowLocationLabel.adjustsFontSizeToFitWidth=YES;
        
        if(![CLLocationManager locationServicesEnabled])
        {
            //DLog(@"请开启定位:设置 > 隐私 > 位置 > 定位服务");
        }
        else
        {
            if ([CLLocationManager authorizationStatus] !=  kCLAuthorizationStatusAuthorized && [CLLocationManager authorizationStatus] !=  kCLAuthorizationStatusAuthorizedWhenInUse)
            {
                //DLog(@"定位失败，请开启定位:设置 > 隐私 > 位置 > 定位服务 下 XX应用");
                
                _nowLocationLabel.text = @"无法获取你的位置，请在设置-隐私-定位中打开微旅管家的定位服务";
                locationView.userInteractionEnabled = NO;
                
            }
            else
            {
                
                _nowLocationLabel.text = [YXLocationManage shareManager].city;
                locationView.userInteractionEnabled = YES;
                
            }
        }
        
        _nowLocationLabel.textColor = [UIColor grayColor];
        _nowLocationLabel.font = [UIFont systemFontOfSize:15];
        [locationView addSubview:_nowLocationLabel];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapNowLocationView:)];
        [locationView addGestureRecognizer:tap];
        [_chooseCollectionView addSubview:locationView];
        
    }else{
        
        UILabel * locatinLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -40, windowContentWidth, 30)];
        locatinLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        locatinLabel.text = @"    全国城市";
        locatinLabel.font = [UIFont systemFontOfSize:15];
        locatinLabel.textColor = [UIColor grayColor];
        locatinLabel.userInteractionEnabled = YES;
        [_chooseCollectionView addSubview:locatinLabel];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapNowLocationView:)];
        [locatinLabel addGestureRecognizer:tap];

        
    }
    
    
    
    
    
    
    
    
    
}
#pragma mark ----- tapNowLocationView
- (void)tapNowLocationView:(UITapGestureRecognizer *)tap
{
    
    if (!self.isDestinationSelect) {
        
        [LXGetCityIDTool sharedMyTools].city_regionID = nil;
        [[LXGetCityIDTool sharedMyTools] getF_cityID];
        if (self.dontNeedreServe)
        {
            if (self.cityInfo)
            {
                self.cityInfo(_nowLocationLabel.text, [[WLSingletonClass defaultWLSingleton] wlLocationCityId]);
            }
            
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] setObject:_nowLocationLabel.text forKey:@"chooseCityName"];
            [[NSUserDefaults standardUserDefaults] setObject:[[WLSingletonClass defaultWLSingleton] wlLocationCityId] forKey:@"chooesCityID"];
            [[NSUserDefaults standardUserDefaults] setObject:[[WLSingletonClass defaultWLSingleton] wlLocationCityId] forKey:@"useCityID"];
            [[NSUserDefaults standardUserDefaults] setObject:_nowLocationLabel.text forKey:@"useCityName"];
            if (self.chooseCityBlock)
            {
                self.chooseCityBlock([NSString stringWithFormat:@"%@", _nowLocationLabel.text]);
            }
        }
        
    }else{
        
        UILabel *label = (UILabel*)tap.view;
        
        if (self.chooseCityBlock)
        {
            self.chooseCityBlock(label.text);
        }
        
    }

    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark -----
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (!self.isDestinationSelect) {
        return self.titleArray.count + 2;
    }
    return self.titleArray.count + 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (!self.isDestinationSelect) {
        if (section == 0)
        {
            return self.hotCityArray.count;
        }
        else if (section == 1)
        {
            return self.titleArray.count;
        }
        else
        {
            NSArray * arr = [self.dataArray objectAtIndex:(section - 2)];
            return arr.count;
        }
    }else{
        
        
        if (section == 0) {
            return self.titleArray.count;
        }else{
            
            NSArray * arr = [self.dataArray objectAtIndex:(section - 1)];
            return arr.count;
            
        }
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZFJChooseCityCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_INDENTIFIER forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    if (!self.isDestinationSelect) {
        if (indexPath.section == 0)
        {
            cell.masgLabel.text = [[_hotCityArray objectAtIndex:indexPath.row] objectForKey:@"region_name"];
        }
        else if(indexPath.section == 1)
        {
            cell.masgLabel.text = [self.titleArray objectAtIndex:indexPath.row];
        }
        else
        {
            cell.masgLabel.text = [[[self.dataArray objectAtIndex:indexPath.section - 2] objectAtIndex:indexPath.row] objectForKey:@"region_name"];
        }
    }else{
        
        if(indexPath.section == 0)
        {
            cell.masgLabel.text = [self.titleArray objectAtIndex:indexPath.row];
        }
        else
        {
            
            WLDestinationModel *model = self.dataArray[indexPath.section - 1][indexPath.row];
            
            
            cell.masgLabel.text = model.d_name;
        }
        
    }
    
    return cell;
    
}

//每次要显示一个辅助视图时会调用此方法;
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    ZFJChooseCityHeaderView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADER_INDENTIFIER forIndexPath:indexPath];
    if (!self.isDestinationSelect) {
        if (indexPath.section == 0)
        {
//            if (self.isDestinationSelect) {
//                
//                
//                headerView.headerTitel.text = @"";
//                
//            }else{
                headerView.headerTitel.text = @"热门城市";
//            }

        }
        else if (indexPath.section == 1)
        {
            headerView.headerTitel.text = @"快速定位";
        }
        else
        {
            headerView.headerTitel.text = [self.titleArray objectAtIndex:indexPath.section - 2];
        }
    }else{
        
        if (indexPath.section == 0)
        {
            headerView.headerTitel.text = @"快速定位";
        }
        else
        {
            headerView.headerTitel.text = [self.titleArray objectAtIndex:indexPath.section - 1];
        }
        
    }
    
    
    return headerView;
}

#pragma mark ----- collectionDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.isDestinationSelect) {
        if (indexPath.section == 0)
        {
            if (self.dontNeedreServe)
            {
                if (self.cityInfo)
                {
                    self.cityInfo([[self.hotCityArray objectAtIndex:indexPath.row] objectForKey:@"region_name"], [[self.hotCityArray objectAtIndex:indexPath.row] objectForKey:@"region_id"]);
                }
            }
            else
            {
                
                [LXGetCityIDTool sharedMyTools].city_regionID = [[self.hotCityArray  objectAtIndex:indexPath.row] objectForKey:@"region_id"];
                [[NSUserDefaults standardUserDefaults] setObject:[[self.hotCityArray  objectAtIndex:indexPath.row] objectForKey:@"region_id"] forKey:@"chooesCityID"];
                NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:[[self.hotCityArray objectAtIndex:indexPath.row] objectForKey:@"region_name"] forKey:@"chooseCityName"];
                [[NSUserDefaults standardUserDefaults] setObject:[[self.hotCityArray  objectAtIndex:indexPath.row] objectForKey:@"region_id"] forKey:@"useCityID"];
                [[NSUserDefaults standardUserDefaults] setObject:[[self.hotCityArray objectAtIndex:indexPath.row] objectForKey:@"region_name"] forKey:@"useCityName"];
                if (self.chooseCityBlock)
                {
                    self.chooseCityBlock([[self.hotCityArray objectAtIndex:indexPath.row] objectForKey:@"region_name"]);
                }
            }
            [self dismissViewControllerAnimated:YES completion:NULL];
        }
        else if (indexPath.section == 1)
        {
            DLog(@"快速定位");
            
            CGFloat scrollY = 0;
            for (int i = 0; i < indexPath.row + 2; i++) {
                scrollY = scrollY + 70 + 40.5 * ([self returnSectionRow:i] - 1);
            }
            [collectionView scrollRectToVisible:CGRectMake(0, scrollY, windowContentWidth, ViewHeight(collectionView)) animated:YES];
        } else {
            
            if (self.dontNeedreServe)
            {
                if (self.cityInfo)
                {
                    self.cityInfo([[self.hotCityArray objectAtIndex:indexPath.row] objectForKey:@"region_name"], [[self.hotCityArray objectAtIndex:indexPath.row] objectForKey:@"region_id"]);
                }
                
            }
            else
            {
                [LXGetCityIDTool sharedMyTools].city_regionID = [[[self.dataArray objectAtIndex:indexPath.section - 2] objectAtIndex:indexPath.row] objectForKey:@"region_id"];
                [[NSUserDefaults standardUserDefaults] setObject:[[[self.dataArray objectAtIndex:indexPath.section - 2] objectAtIndex:indexPath.row] objectForKey:@"region_id"] forKey:@"chooesCityID"];
                NSString * chooesCityNameStr = [[[self.dataArray objectAtIndex:indexPath.section - 2] objectAtIndex:indexPath.row] objectForKey:@"region_name"];
                NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:chooesCityNameStr forKey:@"chooseCityName"];
                
                [[NSUserDefaults standardUserDefaults] setObject:[[[self.dataArray objectAtIndex:indexPath.section - 2] objectAtIndex:indexPath.row] objectForKey:@"region_id"] forKey:@"useCityID"];
                [[NSUserDefaults standardUserDefaults] setObject:chooesCityNameStr forKey:@"useCityName"];
                if (self.chooseCityBlock)
                {
                    self.chooseCityBlock([[[self.dataArray objectAtIndex:indexPath.section - 2] objectAtIndex:indexPath.row] objectForKey:@"region_name"]);
                }
                
            }
            [self dismissViewControllerAnimated:YES completion:NULL];
        }
        
    }else{
        
        if (indexPath.section == 0)
        {
            DLog(@"快速定位");
            
            CGFloat scrollY = 0;
            for (int i = 0; i < indexPath.row + 2; i++) {
                scrollY = scrollY + 40.5 * ([self returnSectionRow:i]);
            }
            
            DLog(@"%f",scrollY);
            
            [collectionView scrollRectToVisible:CGRectMake(0, scrollY, windowContentWidth, ViewHeight(collectionView)) animated:YES];
        } else {
            
            if (self.dontNeedreServe)
            {
                if (self.cityInfo)
                {
                    self.cityInfo([[self.hotCityArray objectAtIndex:indexPath.row] objectForKey:@"region_name"], [[self.hotCityArray objectAtIndex:indexPath.row] objectForKey:@"region_id"]);
                }
                
            }
            else
            {
//                [LXGetCityIDTool sharedMyTools].city_regionID = [[[self.dataArray objectAtIndex:indexPath.section - 1] objectAtIndex:indexPath.row] objectForKey:@"region_id"];
//                [[NSUserDefaults standardUserDefaults] setObject:[[[self.dataArray objectAtIndex:indexPath.section - 1] objectAtIndex:indexPath.row] objectForKey:@"region_id"] forKey:@"chooesCityID"];
//                NSString * chooesCityNameStr = [[[self.dataArray objectAtIndex:indexPath.section - 1] objectAtIndex:indexPath.row] objectForKey:@"region_name"];
//                NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
//                [userDefaults setObject:chooesCityNameStr forKey:@"chooseCityName"];
//                
//                [[NSUserDefaults standardUserDefaults] setObject:[[[self.dataArray objectAtIndex:indexPath.section - 1] objectAtIndex:indexPath.row] objectForKey:@"region_id"] forKey:@"useCityID"];
//                [[NSUserDefaults standardUserDefaults] setObject:chooesCityNameStr forKey:@"useCityName"];
                
                
                
                WLDestinationModel *model = self.dataArray[indexPath.section - 1][indexPath.row];
                
                NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:model.d_name forKey:@"useCityName"];
                [userDefaults synchronize];
                if (self.chooseCityBlock)
                {
                    self.chooseCityBlock(model.d_name);
                }
                
            }
            [self dismissViewControllerAnimated:YES completion:NULL];
        }
        
        
        
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (!self.isDestinationSelect) {
        ZFJChooseCityCell * aCell = (ZFJChooseCityCell *)cell;
        if (![[WLSingletonClass defaultWLSingleton] wlCityName]) {
            NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:[YXLocationManage shareManager].city forKey:@"chooseCityName"];
        }
        if ([aCell.masgLabel.text isEqualToString:[[WLSingletonClass defaultWLSingleton] wlCityName]])
        {
            cell.layer.borderWidth = 1;
            cell.layer.borderColor = [UIColor orangeColor].CGColor;
        }
//    }


    
}
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (!self.isDestinationSelect) {
        ZFJChooseCityCell * aCell = (ZFJChooseCityCell *)cell;
        if (![[WLSingletonClass defaultWLSingleton] wlCityName])
        {
            NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:[YXLocationManage shareManager].city forKey:@"chooseCityName"];
        }
        if ([aCell.masgLabel.text isEqualToString:[[WLSingletonClass defaultWLSingleton] wlCityName]])
        {
            cell.layer.borderWidth = 0.0;
            cell.layer.borderColor = [UIColor whiteColor].CGColor;
        }
//    }
    
    
}
- (NSInteger)returnSectionRow:(NSInteger)section
{
    NSInteger row = [self.chooseCollectionView numberOfItemsInSection:section] / 5.0 > [self.chooseCollectionView numberOfItemsInSection:section] /5 ? [self.chooseCollectionView numberOfItemsInSection:section] / 5 + 1 : [self.chooseCollectionView numberOfItemsInSection:section] /5;
    return row;
}



#pragma mark ----- 加载目的地城市数据

- (void)loadDestinationCitys{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:DESTINATION_CITY_URL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [_hud hide:YES];
        self.toTopButton.frame = CGRectMake(UISCREEN_WIDTH/5*4, UISCREEN_HEIGHT/4*3, 50, 50);
        [self.view addSubview:self.toTopButton];
        NSDictionary *dict = (NSDictionary*)responseObject;
        
        NSArray *array = dict[@"data"];
        
        
        NSMutableArray *modelArray = [NSMutableArray array];
        NSMutableArray *uperArray = [NSMutableArray array];
        
        for (NSDictionary *dic in array) {
            
            WLDestinationModel *model = [WLDestinationModel modelWithDic:dic];
            
            //            DLog(@"%@---%@",model.d_name,model.uperCharater);
            
            [uperArray addObject:model.uperCharater];
            [modelArray addObject:model];
            
        }
        
        
        
        [self.titleArray addObjectsFromArray:[uperArray sortedArrayUsingSelector:@selector(compare:)]];
        
        self.titleArray = [YXTools arrayWithMemberIsOnly:self.titleArray];
        
        
        
        for (int i = 0; i<self.titleArray.count; i++) {
            
            NSMutableArray *array = [NSMutableArray array];
            
            for (WLDestinationModel *model in modelArray) {
                
                
                if ([model.uperCharater isEqualToString:self.titleArray[i]]) {
                    
                    [array addObject:model];
                }
                
            }
            
            [self.dataArray addObject:array];
            
        }
        
        [self.chooseCollectionView reloadData];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [_hud hide:YES];
        DLog(@"%@",error);
        
    }];
    
}


#pragma mark ---- 加载城市数据

//加载城市数据
- (void)loadData
{
    
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    
    
    NSString *str=[NSString stringWithFormat:@"%@/api/route/get_all_city", WLHTTP];
    DLog(@"%@", str);
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        
        [self.titleArray addObjectsFromArray:[[dict allKeys] sortedArrayUsingSelector:@selector(compare:)]];
        
        
        for (int i = 0; i < _titleArray.count; i++)
        {
            [self.dataArray addObject:[dict objectForKey:[_titleArray objectAtIndex:i]]];
        }
        
        [self.chooseCollectionView reloadData];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         DLog(@"发生错误！%@",error);
         [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
         [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
             self.nowLocationLabel.text = @"无法获取你的位置，请在设置-隐私-定位中打开微旅管家的定位服务";
             [self loadData];
             [self loadHotCityData];
             
         }];
         [[XCLoadMsg sharedLoadMsg:self].view addSubview:[self addHeaderView]];
     }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
}

//加载城市数据
- (void)loadHotCityData
{
    
    NSString *str=[NSString stringWithFormat:@"%@/api/route/hot_city", WLHTTP];
    DLog(@"%@", str);
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
         id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
         
         [self.hotCityArray addObjectsFromArray:[dict objectForKey:@"data"]];
         
         [self.chooseCollectionView reloadData];
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         DLog(@"发生错误！%@",error);
     }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
}


- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}

- (NSMutableArray *)titleArray
{
    if (_titleArray == nil)
    {
        self.titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil)
    {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)hotCityArray
{
    if (_hotCityArray == nil)
    {
        self.hotCityArray = [NSMutableArray array];
    }
    return _hotCityArray;
}

- (void)selectCity:(SelectCityInfo)city
{
    self.cityInfo = city;
}

@end
