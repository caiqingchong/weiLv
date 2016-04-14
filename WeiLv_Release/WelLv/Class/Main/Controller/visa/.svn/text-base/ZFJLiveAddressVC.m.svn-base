//
//  ZFJLiveAddressVC.m
//  WelLv
//
//  Created by 张发杰 on 15/7/14.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJLiveAddressVC.h"
#import "ZFJChooseCityCell.h"
#import "ZFJChooseCityHeaderView.h"
#import "YXLocationManage.h"

#define CELL_INDENTIFIER @"Cell"
#define HEADER_INDENTIFIER @"Header"

#define M_HadereView_height 65
@interface ZFJLiveAddressVC ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, copy) LiveAddressBlock liveAddressStr;

@property (nonatomic, strong) UICollectionView * chooseCollectionView;
@property (nonatomic, strong) UILabel * nowLocationLabel;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ZFJLiveAddressVC
- (id)initWithLiveAddress:(LiveAddressBlock)liveAddress{
    if (self = [super init]) {
        self.liveAddressStr = liveAddress;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    [self.view addSubview:[self addHeaderView]];
    [self addCustomView];
}
#pragma mark ----- addHeaderView
- (UIView *)addHeaderView{
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, M_HadereView_height)];
    headerView.backgroundColor = [UIColor whiteColor];
    UIImageView * dismissIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 35, 20, 20)];
    dismissIcon.image = [UIImage imageNamed:@"关闭"];
    dismissIcon.userInteractionEnabled = YES;
    [headerView addSubview:dismissIcon];
    
    UIButton * dismissBut = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissBut.frame = CGRectMake(15, 25, 30, 30);
    //dismissBut.backgroundColor = [UIColor orangeColor];
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
    //[self.view addSubview:headerView];
}
#pragma mark ----- dismissButton
- (void)dismissChooseCityView:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)addCustomView{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    //layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize = CGSizeMake((windowContentWidth - 0.5 * 4) / 5, 40);
    layout.headerReferenceSize = CGSizeMake(windowContentHeight, 30);
    layout.minimumInteritemSpacing = 0.5;
    layout.minimumLineSpacing = 0.5;
    
    self.chooseCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, M_HadereView_height, windowContentWidth, windowContentHeight - M_HadereView_height) collectionViewLayout:layout];
    //self.chooseCollectionView.contentOffset = CGPointMake(0, -70);
    //self.chooseCollectionView.contentSize = CGSizeMake(windowContentWidth, -70);
    self.chooseCollectionView.contentInset = UIEdgeInsetsMake(70, 0, 0, 0);
    _chooseCollectionView.backgroundColor = [UIColor whiteColor];
    _chooseCollectionView.dataSource = self;
    _chooseCollectionView.delegate = self;
    //_chooseCityTableView.backgroundColor = bordColor;
    [_chooseCollectionView registerClass:[ZFJChooseCityCell class] forCellWithReuseIdentifier:CELL_INDENTIFIER];
    [self.view addSubview:_chooseCollectionView];
    
    //注册区头视图;
    [_chooseCollectionView registerClass:[ZFJChooseCityHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADER_INDENTIFIER];
    
    UILabel * locatinLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -70, windowContentWidth, 30)];
    locatinLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    locatinLabel.text = @"   当前定位城市";
    locatinLabel.font = [UIFont systemFontOfSize:15];
    locatinLabel.textColor = [UIColor grayColor];
    [_chooseCollectionView addSubview:locatinLabel];
    
    UIView * locationView = [[UIView alloc] initWithFrame:CGRectMake(0, -40, windowContentWidth, 40)];
    locationView.backgroundColor = [UIColor whiteColor];
    
    UIImageView * locationImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 8, 13.5, 19)];
    //locationImage.backgroundColor = [UIColor orangeColor];
    locationImage.image = [UIImage imageNamed:@"location"];
    [locationView addSubview:locationImage];
    
    self.nowLocationLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(locationImage) + ViewWidth(locationImage) + 10, 5, 200, 30)];
    _nowLocationLabel.numberOfLines = 0;
    _nowLocationLabel.adjustsFontSizeToFitWidth=YES;
    
    
    if(![CLLocationManager locationServicesEnabled]){
        //NSLog(@"请开启定位:设置 > 隐私 > 位置 > 定位服务");
    }else{
        if ([CLLocationManager authorizationStatus] !=  kCLAuthorizationStatusAuthorized && [CLLocationManager authorizationStatus] !=  kCLAuthorizationStatusAuthorizedWhenInUse) {
            
            _nowLocationLabel.text = @"无法获取你的位置，请在设置-隐私-定位中打开微旅管家的定位服务";
            
        } else {
            
            _nowLocationLabel.text = [[YXLocationManage shareManager].province stringByReplacingOccurrencesOfString:@"省" withString:@""];
            
        }
    }
    
    
    _nowLocationLabel.textColor = [UIColor orangeColor];
    _nowLocationLabel.font = [UIFont systemFontOfSize:15];
    [locationView addSubview:_nowLocationLabel];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapNowLocationView:)];
    [locationView addGestureRecognizer:tap];
    [_chooseCollectionView addSubview:locationView];

}
#pragma mark ----- tapNowLocationView
- (void)tapNowLocationView:(UITapGestureRecognizer *)tap{
    
    if ([[YXLocationManage shareManager].province isEqual:NULL]) {
        return;
    } else if (![[[YXLocationManage shareManager].province stringByReplacingOccurrencesOfString:@"省" withString:@""] isEqual:_nowLocationLabel.text]){
        return;
    }
    if (self.dataArray.count != 0) {
        for (int i = 0; i < self.dataArray.count; i++) {
            if ([[[self.dataArray objectAtIndex:i] objectForKey:@"region_name"] isEqual:_nowLocationLabel.text]) {
                [[NSUserDefaults standardUserDefaults] setObject:[[self.dataArray objectAtIndex:i] objectForKey:@"region_id"] forKey:@"liveAddress_id"];
                [[NSUserDefaults standardUserDefaults] setObject:[[self.dataArray objectAtIndex:i] objectForKey:@"region_name"] forKey:@"liveAddress_name"];
            }
        }
    }
    self.liveAddressStr([NSString stringWithFormat:@"%@", _nowLocationLabel.text]);
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZFJChooseCityCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_INDENTIFIER forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.masgLabel.text = [[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"region_name"];
    return cell;
    
}

//每次要显示一个辅助视图时会调用此方法;
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    ZFJChooseCityHeaderView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADER_INDENTIFIER forIndexPath:indexPath];
    
    headerView.headerTitel.text = @"省/直辖市";
   
    return headerView;
}

#pragma mark ----- collectionDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [[NSUserDefaults standardUserDefaults] setObject:[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"region_id"] forKey:@"liveAddress_id"];
    [[NSUserDefaults standardUserDefaults] setObject:[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"region_name"] forKey:@"liveAddress_name"];
    self.liveAddressStr([[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"region_name"]);
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    ZFJChooseCityCell * aCell = (ZFJChooseCityCell *)cell;
    if ([aCell.masgLabel.text isEqual:[[NSUserDefaults standardUserDefaults] objectForKey:@"liveAddress_name"]]) {
        cell.layer.borderWidth = 1;
        cell.layer.borderColor = [UIColor orangeColor].CGColor;
    }
    
}
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    ZFJChooseCityCell * aCell = (ZFJChooseCityCell *)cell;
    if ([aCell.masgLabel.text isEqual:[[NSUserDefaults standardUserDefaults] objectForKey:@"liveAddress_name"]]) {
        cell.layer.borderWidth = 0.0;
        cell.layer.borderColor = [UIColor whiteColor].CGColor;
    }
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

- (void)loadData
{
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    
    NSString *str=[NSString stringWithFormat:@"%@", VisaLiveAdd];
    NSLog(@"%@", str);
    __weak ZFJLiveAddressVC * liveAddressVC = self;
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        //NSLog(@"获取到的数据为：%@",dict);
        [self.dataArray addObjectsFromArray:[dict objectForKey:@"data"]];
        
        [liveAddressVC.chooseCollectionView reloadData];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
        [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
            [self loadData];
        }];
        
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
}

- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}



@end
