//
//  locationView.m
//  WelLv
//
//  Created by lyx on 15/4/7.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//
#define cellHeight 40

#import "locationView.h"
#import "LXGetCityIDTool.h"

@implementation locationView
@synthesize city = _city;
@synthesize block;
- (id)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.frame = frame;
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 10;//设置距离过滤器
        if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
        {
            //请求权限
            #if TARGET_IPHONE_SIMULATOR
            #elif TARGET_OS_IPHONE
            [self.locationManager requestWhenInUseAuthorization];
            [self.locationManager requestAlwaysAuthorization];//始终允许访问位置信息
            
            #endif
            
        }
        
        [self.locationManager startUpdatingLocation];//开始更新位置信息

        self.but = [UIButton buttonWithType:UIButtonTypeCustom];
        _but.frame=CGRectMake(0, 0, 60, 44);
        [self addSubview:_but];
        
        _city = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 47, 44)];
        _city.text = @"郑州";
        _city.textAlignment = NSTextAlignmentCenter;
        _city.textColor = [UIColor whiteColor];
        _city.adjustsFontSizeToFitWidth = YES;
        _city.numberOfLines = 0;
        _city.font = [UIFont systemFontOfSize:15];
        [_but addSubview:_city];
        
        self.locaImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.city.frame.size.width+self.city.frame.origin.x, 44/2-8/2, 13, 8)];
        self.locaImage.contentMode = UIViewContentModeScaleAspectFit;
        self.locaImage.image = [UIImage imageNamed:@"定位1-首页"];
        [_but addSubview:self.locaImage];
        
        [self initDataAndView];

    }
    return self;
}

-(void)initDataAndView
{
    _selectCell=0;
    
    NSString* plistPath=[[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    _dict=[[NSDictionary alloc] initWithContentsOfFile:plistPath];
    self.provinceArray=[_dict allKeys];
    self.selectArray=[_dict objectForKey:[self.provinceArray objectAtIndex:0]];
    self.cityArray= [NSMutableArray arrayWithArray:[[self.selectArray objectAtIndex:0] allKeys]];
    
    
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    
    _maskView=[[UIView alloc] initWithFrame:CGRectMake(0, 64, windowContentWidth, windowContentHeight-64)];
    _maskView.backgroundColor=[UIColor colorWithWhite:0.1 alpha:0.8];
    _maskView.userInteractionEnabled=YES;
    _maskView.hidden=YES;
    [window addSubview:_maskView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMask_YES)];
    [_maskView addGestureRecognizer:tap];
    
    _provinceTab=[[UITableView alloc] initWithFrame:CGRectMake(0, 64, windowContentWidth/4, windowContentHeight-64) style:UITableViewStylePlain];
    _provinceTab.delegate=self;
    _provinceTab.dataSource=self;
    _provinceTab.hidden=YES;
    [window addSubview:_provinceTab];
    
    _cityTab=[[UITableView alloc] initWithFrame:CGRectMake(ViewWidth(_provinceTab)-1, ViewY(_provinceTab), 3*windowContentWidth/4, windowContentHeight-64) style:UITableViewStylePlain];
    _cityTab.delegate=self;
    _cityTab.dataSource=self;
    _cityTab.hidden=YES;
    [window addSubview:_cityTab];
    
    if ([_provinceTab respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [_provinceTab setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([_provinceTab respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [_provinceTab setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    if ([_cityTab respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [_cityTab setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([_cityTab respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [_cityTab setLayoutMargins:UIEdgeInsetsZero];
        
    }

}

- (void)location:(UIButton *)sender
{
    DLog(@"定位");
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
  
    if (locations.count)
    {
        CLLocation *currentLocation = [locations lastObject];
           
        CLLocationCoordinate2D coordinate = currentLocation.coordinate;
        [YXLocationManage shareManager].coordinate=coordinate;
        //地理信息编码
        CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
        [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
        {
            if (placemarks.count)
            {
                CLPlacemark *placeMark = [placemarks objectAtIndex:0];
                
                DLog(@"%@",placeMark);
                [YXLocationManage shareManager].city = [[placeMark.addressDictionary objectForKey:@"City"] stringByReplacingOccurrencesOfString:@"市" withString:@""];
                if ([[NSUserDefaults standardUserDefaults] objectForKey:@"chooseCityName"])
                {
                    _city.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"chooseCityName"];
                    [LXGetCityIDTool sharedMyTools].city_regionID = [[NSUserDefaults standardUserDefaults] objectForKey:@"chooesCityID"];
                    DLog(@"选择的城市名称：%@----对应的城市区域ID：%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"chooseCityName"], [LXGetCityIDTool sharedMyTools].city_regionID);
                    
                }
                else
                {
                    self.city.text = [YXLocationManage shareManager].city;
                };
                [YXLocationManage shareManager].province = [placeMark.addressDictionary objectForKey:@"State"];
                [[LXGetCityIDTool sharedMyTools] getF_cityID];
                
                [self.locationManager stopUpdatingLocation];
                if (self.block)
                {
                    block([YXLocationManage shareManager].city);
                }
            }
        }];
    }
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([error code] == kCLErrorDenied)
    {
        [YXLocationManage shareManager].city = self.city.text;
        DLog(@"访问被拒绝--%@",[YXLocationManage shareManager].city);
        if (self.block)
        {
            block(@"郑州");
        }
    }
    if ([error code] == kCLErrorLocationUnknown)
    {
        [YXLocationManage shareManager].city = self.city.text;
        DLog(@"无法获得位置信息");
        if (self.block)
        {
            block(@"郑州");
        }
    }
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_provinceTab)
    {
         return self.provinceArray.count;
    }
    return self.cityArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_provinceTab)
    {
        static NSString *CellIdentifier0 = @"cellIdentifier0";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier0];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier0];
            //单元格的选择风格，选择时单元格不出现蓝条
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.textColor=[UIColor blackColor];
        cell.backgroundColor=kColor(220, 220, 220);
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        cell.textLabel.text=[self.provinceArray objectAtIndex:indexPath.row];
        if (indexPath.row==_selectCell)
        {
            cell.textLabel.textColor=[UIColor orangeColor];
            cell.backgroundColor=[UIColor whiteColor];
            
            _lastIndexPath=indexPath;
        }
        
        return cell;
    }
    else
    {
        static NSString *CellIdentifier0 = @"cellIdentifier0";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier0];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier0];
            //单元格的选择风格，选择时单元格不出现蓝条
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        cell.textLabel.text=[self.cityArray objectAtIndex:indexPath.row];
        
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_provinceTab)
    {
        self.selectArray=[_dict objectForKey:[self.provinceArray objectAtIndex:indexPath.row]];
        self.cityArray= [NSMutableArray arrayWithArray:[[self.selectArray objectAtIndex:0] allKeys]];
        [_cityTab reloadData];
        _selectCell=indexPath.row;
        if (_lastIndexPath!=indexPath)
        {
            //当前单元格
            UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
            cell.textLabel.textColor=[UIColor orangeColor];
            cell.backgroundColor=[UIColor whiteColor];
            
            //上一次点击的单元格
            UITableViewCell *lastCell=[tableView cellForRowAtIndexPath:_lastIndexPath];
            lastCell.textLabel.textColor=[UIColor blackColor];
            lastCell.backgroundColor=kColor(220, 220, 220);

            _lastIndexPath=indexPath;
            
        }
    }
    else
    {
        _city.text=[self.cityArray objectAtIndex:indexPath.row];
        [YXLocationManage shareManager].city=_city.text;
        if (self.block) {
            block(_city.text);
        }
        [self tapMask_YES];
    }
    
}
#pragma mark 分割线左边对齐
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)tapMask_YES
{   _maskView.hidden=YES;
    _provinceTab.hidden=YES;
    _cityTab.hidden=YES;
}

-(void)tapMask_NO
{
    _maskView.hidden=NO;
    _provinceTab.hidden=NO;
    _cityTab.hidden=NO;
}

@end
