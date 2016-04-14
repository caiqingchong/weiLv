//
//  HouseSearchController.m
//  WelLv
//
//  Created by mac for csh on 16/2/18.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

#define navHeight self.navigationController.navigationBar.frame.size.height
//历史搜索记录的文件路径
#define TraveHisPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"travehisDatas.data"]

#define ShipHisPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"shiphisDatas.data"]

#define VisaHisPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"visahisDatas.data"]

#define KeeperHisPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"keeperhisDatas.data"]

#define TicketPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"ticketDatas.data"]

#define StudyTourPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"StudyTourDatas.data"]
#define SelfDrivePath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"SelfDrivePath.data"]

#import "HouseSearchController.h"
#import "SearchViewTopView.h"
#import "SearchViewBottomView.h"
#import "SearchResultViewController.h"
#import "TraveSearchViewController.h"
#import "ZFJShipListVC.h"
#import "ZFJTicketListVC.h"
#import "LXSTListViewController.h"
#import "ZFJVIsaListVC.h"
#import "JYCSelfDriveEatViewController.h"
#import "NewHouseKeeperViewController.h"
@interface HouseSearchController()
{
    
    NSArray *_searchTypeStrArray;
}

@property (nonatomic,strong) NSArray *placeStrArray;
@property (nonatomic,strong) NSMutableArray *historyDataArray;

@property (nonatomic,strong)SearchViewTopView *topVc;
@property (nonatomic,strong)SearchViewBottomView *bottomVc;
@property (nonatomic,strong)SearchResultViewController *searchResultVc;
@end

@implementation HouseSearchController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationItem.hidesBackButton = YES;
    //    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    backBtn.frame=CGRectMake(0, 0, 25, 25);
    //    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //    [backBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    //调取历史纪录保存到数组中
    [self getHistoryDataArray];
    /**
     1 旅游
     2 邮轮
     3 签证
     4 管家
     */
    _placeStrArray=@[@"景区/地区/关键字",@"出发港口/途径城市",@"搜索办签目的地",@"管家姓名/电话",@"游学",@"", @"搜索自驾吃店铺"];
    _searchTypeStrArray=@[@"旅游",@"邮轮",@"签证",@"管家",@"游学", @"门票",@"自驾吃"];
    
    _topVc=[[SearchViewTopView alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width-60, 30) placeholderStr:[_placeStrArray objectAtIndex:self.searchType-1] searchType:[_searchTypeStrArray objectAtIndex:self.searchType-1] nameArr:_searchTypeStrArray];
    _topVc.searchTF.tintColor = [UIColor orangeColor];
    
    self.navigationItem.titleView=_topVc;
    
    UIButton *cancelBut = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBut.frame=CGRectMake(0, 0, 30, 30);
    //[concelBut setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [cancelBut setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBut setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    cancelBut.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelBut addTarget:self action:@selector(clickCancel:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBut];
    /**
     *  切换搜索类型
     */
    __block HouseSearchController *searchVc=self;
    _topVc.typeBlock = ^(NSInteger type){
        NSLog(@"切换搜索类型---%ld",(long)type);
        searchVc.searchType=type;
        
        [searchVc getHistoryDataArray];
        [searchVc.bottomVc updateSearchTab:searchVc.historyDataArray searchType:type];
        searchVc.topVc.searchTF.placeholder=[searchVc.placeStrArray objectAtIndex:type-1];
    };
    
    /**
     *  点击搜索按钮时返回的值
     */
    _topVc.keywordsBlock = ^(NSString *keywords){
        if (keywords.length>0) {
            //保存数据
            [searchVc saveKeywords:keywords];
            
            [searchVc getHistoryDataArray];
            [searchVc.bottomVc updateSearchTab:searchVc.historyDataArray searchType:searchVc.searchType];
            //            searchVc.searchResultVc=[[SearchResultViewController alloc] init];
            //            [searchVc.navigationController pushViewController:searchVc.searchResultVc animated:YES];
            if (searchVc.searchType==1) {
                TraveSearchViewController *resultVC = [[TraveSearchViewController alloc] init];
                resultVC.keywords = keywords;
                resultVC.area = @"city";
                resultVC.pushType = isPush;
                resultVC.navigationItem.title = @"旅游产品";
                [searchVc.navigationController pushViewController:resultVC animated:YES];
            }
            if (searchVc.searchType==2) {
                ZFJShipListVC * shipListVC = [[ZFJShipListVC alloc] init];
                shipListVC.line_id = @"";
                shipListVC.lineName = @"邮轮列表";
                shipListVC.keywoerd = keywords;
                [searchVc.navigationController pushViewController:shipListVC animated:YES];
            }
            if (searchVc.searchType==3) {
                ZFJVIsaListVC *visaListVC = [[ZFJVIsaListVC alloc] init];
                visaListVC.searchStr = keywords;
                visaListVC.region_id = searchVc.city_id;
                [searchVc.navigationController pushViewController:visaListVC animated:YES];
            }
            if (searchVc.searchType==4) {
                NewHouseKeeperViewController *houseVc=[[NewHouseKeeperViewController alloc] init];
                NSLog(@"wwwwww%@",keywords);
                houseVc.serchInPut=keywords;
                houseVc.flag = 1;
                
                [searchVc.navigationController pushViewController:houseVc animated:YES];
            }
            //
            if (searchVc.searchType==5) {
                //游学
                LXSTListViewController *stVc=[[LXSTListViewController alloc] init];
                stVc.keywords=keywords;
                [searchVc.navigationController pushViewController:stVc animated:YES];
            }
            if (searchVc.searchType==6) {
                //门票
                ZFJTicketListVC *ticketVc=[[ZFJTicketListVC alloc] init];
                ticketVc.searchStr=keywords;
                [searchVc.navigationController pushViewController:ticketVc animated:YES];
            }
            if (searchVc.searchType==7) {
                
                //                if (searchVc.block) {
                //                    searchVc.block(keywords);
                //                }
                JYCSelfDriveEatViewController *jyc=[[JYCSelfDriveEatViewController alloc]init];
                // jyc.searchStr=keywords;
                [searchVc.navigationController pushViewController:jyc animated:YES];
            }
            
        }else{
            [[LXAlterView sharedMyTools] createTishi:@"请输入关键字"];
        }
        
        
    };
    
    _bottomVc = [[SearchViewBottomView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-20) searchType:self.searchType];
    [_bottomVc updateSearchTab:self.historyDataArray searchType:self.searchType];
    [self.view addSubview:_bottomVc];
    
    _bottomVc.hiskewordsBlock = ^(NSString *hiskewords){
        //        searchVc.searchResultVc=[[SearchResultViewController alloc] init];
        //        [searchVc.navigationController pushViewController:searchVc.searchResultVc animated:YES];
        
        if (searchVc.searchType==1) {
            TraveSearchViewController *resultVC = [[TraveSearchViewController alloc] init];
            resultVC.keywords = hiskewords;
            resultVC.area = @"city";
            resultVC.pushType = isPush;
            resultVC.navigationItem.title = @"旅游产品";
            [searchVc.navigationController pushViewController:resultVC animated:YES];
        }
        if (searchVc.searchType==2) {
            ZFJShipListVC * shipListVC = [[ZFJShipListVC alloc] init];
            shipListVC.line_id = @"";
            shipListVC.lineName = @"邮轮列表";
            shipListVC.keywoerd = hiskewords;
            [searchVc.navigationController pushViewController:shipListVC animated:YES];
        }
        if (searchVc.searchType==3) {
            //            VisaListVC *visaListVC = [[VisaListVC alloc] init];
            //            visaListVC.searchStr = hiskewords;
            //            visaListVC.isNeedR = YES;
            //            [searchVc.navigationController pushViewController:visaListVC animated:YES];
            ZFJVIsaListVC *visaListVC = [[ZFJVIsaListVC alloc] init];
            visaListVC.searchStr = hiskewords;
            visaListVC.region_id = searchVc.city_id;
            [searchVc.navigationController pushViewController:visaListVC animated:YES];
        }
        if (searchVc.searchType==4) {
            NewHouseKeeperViewController *houseVc=[[NewHouseKeeperViewController alloc] init];
            houseVc.serchInPut=hiskewords;
            houseVc.flag = 1;
            NSLog(@"%@",hiskewords);
            [searchVc.navigationController pushViewController:houseVc animated:YES];
        }
        
        if (searchVc.searchType==5) {
            //游学
            LXSTListViewController *stVc=[[LXSTListViewController alloc] init];
            stVc.keywords=hiskewords;
            [searchVc.navigationController pushViewController:stVc animated:YES];
            
        }
        
        
        if (searchVc.searchType==6) {
            //门票
            ZFJTicketListVC *ticketVc=[[ZFJTicketListVC alloc] init];
            ticketVc.searchStr=hiskewords;
            [searchVc.navigationController pushViewController:ticketVc animated:YES];
        } if (searchVc.searchType==7) {
            //            if (searchVc.block) {
            //                searchVc.block(hiskewords);
            //    }
            JYCSelfDriveEatViewController *jyc=[[JYCSelfDriveEatViewController alloc]init];
            //jyc.searchStr=hiskewords;
            [searchVc.navigationController pushViewController:jyc animated:YES];
        }
        
        
        
    };
    
    _bottomVc.searchTypeBlock = ^(NSInteger type){
        [searchVc deleteHisData:type];
    };
    
}
- (void)clickCancel:(UIButton *)button {
    _topVc.searchTF.text = @"";
    [_topVc.searchTF resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)close
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_topVc deleteMask];
    [_topVc.searchTF resignFirstResponder];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [_topVc.searchTF resignFirstResponder];
}

/**
 *  保存搜索记录
 */
-(void)saveKeywords:(NSString *)keywords
{
    
    if (![self.historyDataArray containsObject:keywords]) {
        
        [self.historyDataArray insertObject:keywords atIndex:0];
        NSLog(@"保存了搜索数据--%@",self.historyDataArray);
        switch (self.searchType) {
            case 1:
            {
                [self.historyDataArray writeToFile:TraveHisPath atomically:YES];
            }
                break;
                
            case 2:
            {
                [self.historyDataArray writeToFile:ShipHisPath atomically:YES];
            }
                break;
                
            case 3:
            {
                [self.historyDataArray writeToFile:VisaHisPath atomically:YES];
            }
                break;
                
            case 4:
            {
                [self.historyDataArray writeToFile:KeeperHisPath atomically:YES];
            }
                break;
                
                
            case 5:
            {
                [self.historyDataArray writeToFile:StudyTourPath atomically:YES];
            }
                break;
            case 6:
            {
                [self.historyDataArray writeToFile:TicketPath atomically:YES];
            }
                break;
            case 7:
            {
                [self.historyDataArray writeToFile:SelfDrivePath atomically:YES];
            }
                break;
                
            default:
                break;
        }
        
    }
}
/**
 *  获取搜索记录
 */
-(void)getHistoryDataArray
{
    switch (self.searchType) {
        case 1:
        {
            self.historyDataArray = [NSMutableArray arrayWithContentsOfFile:TraveHisPath];
        }
            break;
            
        case 2:
        {
            self.historyDataArray = [NSMutableArray arrayWithContentsOfFile:ShipHisPath];
        }
            break;
            
        case 3:
        {
            self.historyDataArray = [NSMutableArray arrayWithContentsOfFile:VisaHisPath];
        }
            break;
            
        case 4:
        {//调取历史纪录保存到数组中
            self.historyDataArray = [NSMutableArray arrayWithContentsOfFile:KeeperHisPath];
        }
            break;
            
            
        case 5:
        {
            self.historyDataArray = [NSMutableArray arrayWithContentsOfFile:StudyTourPath];
        }
            break;
        case 6:
        {
            self.historyDataArray = [NSMutableArray arrayWithContentsOfFile:TicketPath];
        }
            break;
        case 7:
        {
            self.historyDataArray = [NSMutableArray arrayWithContentsOfFile:SelfDrivePath];
        }
            break;
        default:
            break;
    }
    
    
    if (self.historyDataArray==nil) {
        self.historyDataArray=[NSMutableArray arrayWithCapacity:0];
    }
    
}
/**
 *  删除当前页面搜索历史记录
 */
-(void)deleteHisData:(NSInteger)searchType
{
    [self.historyDataArray removeAllObjects];
    switch (searchType) {
        case 1:
        {
            
            [self.historyDataArray writeToFile:TraveHisPath atomically:YES];
            
        }
            break;
        case 2:
        {
            [self.historyDataArray writeToFile:ShipHisPath atomically:YES];
        }
            break;
            
        case 3:
        {
            [self.historyDataArray writeToFile:VisaHisPath atomically:YES];
        }
            break;
            
        case 4:
        {
            [self.historyDataArray writeToFile:KeeperHisPath atomically:YES];
        }
            break;
            
            
        case 5:
        {
            [self.historyDataArray writeToFile:StudyTourPath atomically:YES];
        }
            break;
            
        case 6:
        {
            [self.historyDataArray writeToFile:TicketPath atomically:YES];
        }
            break;
        case 7:
        {
            [self.historyDataArray writeToFile:SelfDrivePath atomically:YES];
        }
            break;
        default:
            break;
    }
}

@end














