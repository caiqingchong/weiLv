
//
//  HotelHotCountyViewController.m
//  WelLv
//
//  Created by mac for csh on 15/9/29.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "HotelHotCountyViewController.h"
#import "SearchHotelViewController.h"

@interface HotelHotCountyViewController ()
{
    UITextField * searchTF;
    UISegmentedControl *segment;
    UITableView *_tableView;
    UIView *_searchView;
    
    NSMutableArray *titleArray;
    NSMutableDictionary *dataDic;
    
    NSMutableArray *hostoryArray;
}
@end

@implementation HotelHotCountyViewController
@synthesize hotelString;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择目的地";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initdata];
    [self loadSeachBar];
    [self initSegmentConTroller];

//    titleArray = [NSMutableArray arrayWithObjects:@"热门",@"A", @"B",@"C",nil];
//    NSArray *arr = @[@"北京",@"上海"];
//    NSArray *arra = @[@"A1",@"A2"];
//    NSArray *arrb = @[@"B1",@"B2"];
//    NSArray *arrc = @[@"C1",@"C2"];
//    dataDic = [[NSMutableDictionary alloc] init ];
//    [dataDic setObject:arr forKey:@"热门"];
//    [dataDic setObject:arra forKey:@"A"];
//    [dataDic setObject:arrb forKey:@"B"];
//    [dataDic setObject:arrc forKey:@"C"];
}

-(void)initdata{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
  
    
    [manager POST:HotelCityList parameters:nil
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSString *html = operation.responseString;
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
              if ([[dict objectForKey:@"Success"] integerValue] ==1 ) {
 
                  
                  
                  dataDic = [[NSMutableDictionary alloc] initWithDictionary:[dict objectForKey:@"Data"]];
                  //排序
                  NSMutableArray *numArray=[NSMutableArray arrayWithArray:dataDic.allKeys];
                  [numArray sortUsingComparator:^NSComparisonResult(NSString *str1,NSString *str2) {
                      return [str1 compare:str2];
                  }];
            
                  [numArray removeObject:@"hot"];
                  titleArray=[[NSMutableArray alloc] initWithObjects:@"hot", nil];
                  [titleArray addObjectsFromArray:numArray];
                  
                  
                  [_tableView reloadData];
                  NSLog(@"titlearray = %@ \n datadic is %@",titleArray,dataDic);
              }else{
                  [[LXAlterView alloc]createTishi:[dict objectForKey:@"Msg"]];
              }
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              
          }];

}

#pragma mark
#pragma mark - searchView
/*加载搜索视图*/
-(void)loadSeachBar{
    UIView * searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 45)];
    searchView.backgroundColor = kColor(154, 165, 175);
    [self.view addSubview:searchView];
    
    UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Search"]];
    leftView.frame = CGRectMake(5, 0,30, 15);
    //leftView.backgroundColor = [UIColor orangeColor];
    leftView.contentMode = UIViewContentModeScaleAspectFit;
    
    searchTF = [[UITextField alloc] initWithFrame:CGRectMake(15, 7.5, ViewWidth(searchView) - 30, 30)];
    searchTF.borderStyle = UITextBorderStyleRoundedRect;
    searchTF.placeholder = @"搜索";
    searchTF.tintColor = [UIColor orangeColor];
    searchTF.layer.cornerRadius = 5.0;
    searchTF.clearButtonMode = UITextFieldViewModeAlways;
    searchTF.leftViewMode = UITextFieldViewModeAlways;
    searchTF.leftView = leftView;
    searchTF.font = [UIFont systemFontOfSize:15];
    searchTF.delegate = self;
    searchTF.returnKeyType = UIReturnKeySearch;
    [searchView addSubview:searchTF];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    //self SearchString:<#(NSString *)#> WithUrl:<#(NSString *)#>
    return YES;
}

-(void)SearchString:(NSString *)string WithUrl:(NSString *)urlString{

}

#pragma mark
#pragma mark - segmentController
-(void)initSegmentConTroller{
    NSArray *Segmentarray = [[NSArray alloc]initWithObjects:@"热门城市",@"历史记录",nil];
    segment = [[UISegmentedControl alloc]initWithItems:Segmentarray];
    segment.frame = CGRectMake(15, 45 + 10, windowContentWidth- 15*2, 30);
    //segment.segmentedControlStyle = UISegmentedControlStyleBar;
    segment.tintColor = [UIColor orangeColor];
    [self.view addSubview:segment];
    [segment addTarget:self action:@selector(segmentControllerClicked:) forControlEvents:UIControlEventValueChanged];
    
    segment.selectedSegmentIndex = 0;[self segmentControllerClicked:0];
}

-(void)segmentControllerClicked:(id)sender{
    UISegmentedControl* control = (UISegmentedControl*)sender;
    
    if (control.selectedSegmentIndex == 0) {
        NSLog(@"0");
        if (!titleArray || [titleArray count] == 0) {
            [self initdata];
        }
        if (!_tableView) {
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45+10+30+10, windowContentWidth , ViewHeight(self.view)-45-50-64)];
            [self.view addSubview:_tableView];
            _tableView.delegate = self;_tableView.dataSource = self;
        }
        _tableView.hidden = NO;
        _searchView.hidden = YES;
    }else if(control.selectedSegmentIndex == 1){
        NSLog(@"1");
        if (!_searchView) {
            _searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 45+10+30+10, windowContentWidth , ViewHeight(self.view)-45-50-64)];
            [self.view addSubview:_searchView];
            
            NSString *plistPath = NSHomeDirectory();
            plistPath = [plistPath stringByAppendingPathComponent:@"/Documents/Hotel.plist"];
            NSMutableDictionary *usersDic = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
            float location = 0.0f;
            if (usersDic && [usersDic objectForKey:@"CountyHistory"] && [[usersDic objectForKey:@"CountyHistory"] count]>0) {
                hostoryArray = [usersDic objectForKey:@"CountyHistory"];
                UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, location, windowContentWidth, 15)];
                lab.text = @" 历史";
                lab.textColor = [UIColor whiteColor];
                lab.textAlignment = NSTextAlignmentLeft;
                lab.font = [UIFont systemFontOfSize:14];
                lab.backgroundColor = [UIColor colorWithRed:131 /255.0 green:146/255.0 blue:156/255.0 alpha:1.0];
                [_searchView addSubview:lab];location = location +15;
                for (int i = 0; i<hostoryArray.count ; i++) {
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    btn.frame = CGRectMake(25, location, windowContentWidth-25, 35);
                    [btn setTitle:[hostoryArray objectAtIndex:i] forState:UIControlStateNormal];
                    btn.titleLabel.font = [UIFont systemFontOfSize:17];
                    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft ;
                    btn.tag = i;
                    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                    [_searchView addSubview:btn];location = location +35;
                }
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(25, location, windowContentWidth-25, 35);
                [btn setTitle:@"清空历史记录" forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:18];
                [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter ;
                [btn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
                [_searchView addSubview:btn];location = location +35;
            }
        }
        _tableView.hidden = YES;
        _searchView.hidden = NO;
    }
    
}

-(void)click:(id)sender{
    UIButton *btn = sender;
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeCountyTxt:)]) {
        [self.delegate changeCountyTxt:btn.titleLabel.text];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

-(void)delete{
    NSString *plistPath = NSHomeDirectory();
    plistPath = [plistPath stringByAppendingPathComponent:@"/Documents/Hotel.plist"];
    NSMutableDictionary *usersDic = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    usersDic = [[NSMutableDictionary alloc ] init];
    [usersDic removeAllObjects];
    [hostoryArray removeAllObjects];
    [usersDic setObject:hostoryArray forKey:@"CountyHistory"];
    [usersDic writeToFile:plistPath atomically:YES];
    [[LXAlterView alloc] createTishi:@"清理成功"];
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark ---- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray * tempArr = [NSMutableArray array];
    tempArr = [dataDic objectForKey:[titleArray objectAtIndex:section]];
    return tempArr.count;
}

//设置区头
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([[titleArray objectAtIndex:section] isEqualToString:@"hot"]) {
        return @"热门";
    }else{
        return [titleArray objectAtIndex:section];
    }
}
//索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return titleArray;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIndentifier = @"listCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        //单元格的选择风格，选择时单元格不出现蓝条
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsZero;
    }
    
    NSString * str = [[[dataDic objectForKey:[titleArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] objectForKey:@"cityname"];
    cell.textLabel.text = str;
    return cell;
    
}

#pragma mark - UITableViewDelegate
//给区头设置背景色。
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    view.tintColor =  [UIColor colorWithRed:131 /255.0 green:146/255.0 blue:156/255.0 alpha:1.0];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    NSString * str = [[[dataDic objectForKey:[titleArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] objectForKey:@"cityname"];
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeCountyTxt:)]) {
        [self.delegate changeCountyTxt:str];
        [self.navigationController popViewControllerAnimated:YES];
        
        NSString *plistPath = NSHomeDirectory();
        plistPath = [plistPath stringByAppendingPathComponent:@"/Documents/Hotel.plist"];
     //   NSLog(@"%@",plistPath);
        NSMutableDictionary *usersDic = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
        if (usersDic && [usersDic objectForKey:@"CountyHistory"]) {
            hostoryArray = [usersDic objectForKey:@"CountyHistory"];
            if ([hostoryArray indexOfObject:str] == NSNotFound) {
                [hostoryArray addObject:str];
                [usersDic removeAllObjects];
                [usersDic setObject:hostoryArray forKey:@"CountyHistory"];
                [usersDic writeToFile:plistPath atomically:YES];
            }
        }else{
            hostoryArray = [[NSMutableArray alloc] init];
            [hostoryArray addObject:str];
            usersDic = [[NSMutableDictionary alloc ] init];
            [usersDic removeAllObjects];
            [usersDic setObject:hostoryArray forKey:@"CountyHistory"];
            [usersDic writeToFile:plistPath atomically:YES];
        }

    }
    
}

@end

