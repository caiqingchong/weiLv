//
//  HotelDetailViewController.m
//  WelLv
//
//  Created by mac for csh on 15/10/9.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//
#define headerheight 90.0
#define footerheighter 10.0
#define cellheight 65.0

#import "HotelDetailViewController.h"
#import "LXPlaneCalendarViewController.h"
#import "LXTools.h"
#import "DetailHeaderView.h"
#import "DetailCell.h"
#import "HotelDteailSelectionViewController.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "JYCHouseDetailVC.h"
#import "HotelFangXingViewController.h"


@interface HotelDetailViewController ()
{
    UIScrollView *_scrollView;
    UIImageView *imageView;
    UILabel *hotelNameLab;
    UILabel *imageNumLab;
    UIButton *enterBtn;
    UIButton *leaveBtn;
    UILabel *daysLab;
  
    NSArray *imageUrlArr;
}
@end

@implementation HotelDetailViewController
@synthesize leavedate,enterdate;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"酒店详情";
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    _scrollView.backgroundColor = BgViewColor;
    [self.view addSubview:_scrollView];
    
    
     imageUrlArr = [NSArray arrayWithObjects:@"http://img2.3lian.com/2014/f2/63/d/36.jpg",@"http://img3.imgtn.bdimg.com/it/u=3250544904,2139336649&fm=21&gp=0.jpg",@"http://pic.58pic.com/58pic/12/22/15/42e58PICacI.jpg",@"http://sc.jb51.net/uploads/allimg/131010/2-131010192241H2.jpg", nil];
    
    [self initView];
    
   
}

#pragma mack ----
- (void)clickBigImage:(UIGestureRecognizer *)tap
{
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity: [imageUrlArr count] ];
    for (int i = 0; i < imageUrlArr.count; i++) {
        // 替换为中等尺寸图片
        
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString: [NSString stringWithFormat:@"%@", [imageUrlArr objectAtIndex:i] ] ]; // 图片路径
        
        UIImageView * imageVieww = [[UIImageView alloc] init];
        [imageVieww sd_setImageWithURL:photo.url placeholderImage:[UIImage imageNamed:@"默认图3"]];
        photo.srcImageView = imageVieww;
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.photos = photos; // 设置所有的图片
    NSInteger tapImageTag = 0;
    browser.currentPhotoIndex = tapImageTag;
    [browser show];
}


-(void)initView{

        UIImageView * imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentWidth/16*9)];
        //imageV.tag = 15000 + i;
        imageV.userInteractionEnabled = YES;
        NSString * str = [imageUrlArr objectAtIndex:0];
        [imageV sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"默认图3"]];
        [_scrollView addSubview:imageV];

        UITapGestureRecognizer * imagTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBigImage:)];
        [imageV addGestureRecognizer:imagTap];
        

   

    
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentWidth/16*9)];
//    imageView.image = [UIImage imageNamed:@"默认图3"];
//    [_scrollView addSubview:imageView];
    hotelNameLab = [[UILabel alloc] initWithFrame:CGRectMake(10, ViewHeight(imageView)- 30, 60, 15)];
    hotelNameLab.text = @"";
    hotelNameLab.font = [UIFont systemFontOfSize:18];
    hotelNameLab.textAlignment = NSTextAlignmentLeft;
    hotelNameLab.textColor = [UIColor whiteColor];
    [imageView addSubview:hotelNameLab];
    imageNumLab = [[UILabel alloc] initWithFrame:CGRectMake(windowContentWidth -10 -60, ViewHeight(imageView) -30, 60, 15)];
    imageNumLab.text = @"";
    imageNumLab.font = [UIFont systemFontOfSize:18];
    imageNumLab.textAlignment = NSTextAlignmentRight;
    imageNumLab.textColor = [UIColor whiteColor];
    [imageView addSubview:imageNumLab];
    
    NSArray *titArr = [[NSArray alloc] initWithObjects:@"设施详情",@"住客点评",@"酒店地址", nil];
    for (int i = 0; i < titArr.count; i ++) {
        UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(imageView) + ViewHeight(imageView) + 45*i , windowContentWidth,45)];
        vv.backgroundColor = [UIColor whiteColor];
        [_scrollView addSubview:vv];
        
        UIImageView *igv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 45/2-25/2, 25, 25)];
        [igv setImage:[UIImage imageNamed:[titArr objectAtIndex:i]]];
        [vv addSubview:igv];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10 + 25+15, 0, windowContentWidth-10-25-15,45);
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitle:[titArr objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft ;
        button.tag = i;
        [button addTarget:self action:@selector(JumpNextVew:) forControlEvents:UIControlEventTouchUpInside];
        [vv addSubview:button];
        
        UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth -45, 45/2-30/2, 45, 30)];
        [image2 setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
        image2.userInteractionEnabled = NO;
        [vv addSubview:image2];
        
        if (i != titArr.count-1) {
            UIImageView *imagev4 = [[UIImageView alloc] initWithFrame:CGRectMake(0,45-0.5, windowContentWidth, 0.5)];
            imagev4.backgroundColor = bordColor;
            [vv addSubview:imagev4];
        }
    }
    
    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(imageView) + ViewHeight(imageView) + 45*3 +20 , windowContentWidth,50)];
    vv.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:vv];
    
    UIImageView *igv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50/2-25/2, 25, 25)];
    [igv setImage:[UIImage imageNamed:@"calendar"]];
    [vv addSubview:igv];
    
    enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    enterBtn.frame = CGRectMake(10 + 25+15, 0, windowContentWidth-10-25-15 -150,25);
    enterBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [enterBtn setTitle:@"入09-30" forState:UIControlStateNormal];
    [enterBtn setTitleColor:kColor(48, 64, 66) forState:UIControlStateNormal];
    enterBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft ;
    enterBtn.tag = 101;
    [enterBtn addTarget:self action:@selector(JumpNextVew:) forControlEvents:UIControlEventTouchUpInside];
    [vv addSubview:enterBtn];
    
    leaveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leaveBtn.frame = CGRectMake(10 + 25+15, 25, windowContentWidth-10-25-15 -150,25);
    leaveBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [leaveBtn setTitle:@"离09-31" forState:UIControlStateNormal];
    [leaveBtn setTitleColor:kColor(48, 64, 66) forState:UIControlStateNormal];
    leaveBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft ;
    leaveBtn.tag = 102;
    [leaveBtn addTarget:self action:@selector(JumpNextVew:) forControlEvents:UIControlEventTouchUpInside];
    [vv addSubview:leaveBtn];
    
    daysLab= [[UILabel alloc] initWithFrame:CGRectMake(ViewX(enterBtn)+ViewWidth(enterBtn) -30 ,50/2-20/2 ,30,20)];
    daysLab.textColor = kColor(134, 134, 134);
    daysLab.text = @"1晚";
    daysLab.font = [UIFont systemFontOfSize:12];
    [vv addSubview:daysLab];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(windowContentWidth-151, 0 , 1, ViewHeight(vv))];
    line.backgroundColor = bordColor;
    line.alpha = 0.8;
    [vv addSubview:line];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(windowContentWidth -150, 0,75,ViewHeight(vv));
    button.tag = 1001;
    [button addTarget:self action:@selector(JumpNextVew:) forControlEvents:UIControlEventTouchUpInside];
    [vv addSubview:button];
    
    UIImageView *igv1 = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(button)/2-20/2, 10, 20, 20)];
    igv1.image = [UIImage imageNamed:@"详情页电话点击"];
    [button addSubview:igv1];
    
    UILabel *callLab = [[UILabel alloc] initWithFrame:CGRectMake(0, ViewY(igv1)+ViewHeight(igv1)+5, ViewWidth(button), 15)];
    callLab.text = @"联系酒店";
    callLab.textColor = kColor(255, 164, 90);
    callLab.font = [UIFont systemFontOfSize:12];
    callLab.textAlignment = NSTextAlignmentCenter;
    [button addSubview:callLab];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(windowContentWidth-75-1, 0 , 1, ViewHeight(vv))];
    line1.backgroundColor = bordColor;
    line1.alpha = 0.8;
    [vv addSubview:line1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(windowContentWidth -75, 0,65,ViewHeight(vv));
    button2.tag = 1002;
    [button2 addTarget:self action:@selector(JumpNextVew:) forControlEvents:UIControlEventTouchUpInside];
    [vv addSubview:button2];
    
    UIImageView *igv2 = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(button2)/2-20/2, 10, 20, 20)];
    igv2.image = [UIImage imageNamed:@"详情页筛选（选中）"];
    [button2 addSubview:igv2];
    
    UILabel *callLab2 = [[UILabel alloc] initWithFrame:CGRectMake(0, ViewY(igv1)+ViewHeight(igv1)+5, ViewWidth(button), 15)];
    callLab2.text = @"筛选";
    callLab2.textColor = kColor(255, 164, 90);
    callLab2.font = [UIFont systemFontOfSize:12];
    callLab2.textAlignment = NSTextAlignmentCenter;
    [button2 addSubview:callLab2];

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ViewY(vv)+ViewHeight(vv), windowContentWidth, (headerheight+footerheighter)*4-footerheighter)];
    _tableView.backgroundColor = BgViewColor;
    _tableView.delegate = self;_tableView.dataSource = self;
    [_scrollView addSubview:_tableView];
  //  _tableView.tableFooterView = [[UIView alloc] init];
    
    _scrollView.contentSize = CGSizeMake(0, ViewHeight(_tableView)+ViewY(_tableView)+64);
    
}

-(void)JumpNextVew:(UIButton *)btn{
    NSLog(@"btn.tag = %ld",btn.tag);
    if (btn.tag == 0) {
        //跳转设施详情
        HotelFangXingViewController *fangxing = [[HotelFangXingViewController alloc] init];
        [self.navigationController pushViewController:fangxing animated:YES];
    }else if (btn.tag == 1) {
        //跳转住客评论
        
    }else if (btn.tag == 2) {
        //跳转地址地图
        
    }else if (btn.tag == 101){
        //跳转日历选择入店日期
        LXPlaneCalendarViewController *lxplaneCal=[[LXPlaneCalendarViewController alloc] init];
        [lxplaneCal setTrainToDay:365 ToDateforString:nil price:100];
        lxplaneCal.calendarblock= ^ (CalendarDayModel *model){
            NSString *date=[model toString];
            [self updateDate:date WithTag:1];
            date = [date substringWithRange:NSMakeRange(5, 5)];
            [enterBtn setTitle:[NSString stringWithFormat:@"入%@",date] forState:UIControlStateNormal];
        };
        lxplaneCal.title = @"选择入店日期";
        [self.navigationController pushViewController:lxplaneCal animated:YES];
    }else if (btn.tag == 102){
        //跳转日历选择离店日期
        LXPlaneCalendarViewController *lxplaneCal=[[LXPlaneCalendarViewController alloc] init];
        [lxplaneCal setTrainToDay:365 ToDateforString:nil price:100];
        lxplaneCal.calendarblock= ^ (CalendarDayModel *model){
            NSString *date=[model toString];
            [self updateDate:date WithTag:2];
            date = [date substringWithRange:NSMakeRange(5, 5)];
            [leaveBtn setTitle:[NSString stringWithFormat:@"离%@",date] forState:UIControlStateNormal];
        };
        lxplaneCal.title = @"选择离店日期";
        [self.navigationController pushViewController:lxplaneCal animated:YES];
    }else if (btn.tag == 1001){
        //拨打酒店电话
        NSString *number = @"400-021-8888";// 此处读入电话号码
        NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number]; //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
    }else if(btn.tag == 1002){
        // 跳转筛选页面
        HotelDteailSelectionViewController *selectionVC = [[HotelDteailSelectionViewController alloc] init];
        CATransition *transition = [CATransition animation];
        transition.duration = 0.5;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type =kCATransitionPush;
        transition.subtype = kCATransitionFromTop;
        transition.delegate = self;
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        self.navigationController.navigationBarHidden = NO;
        selectionVC.delegate = self;
        [self.navigationController pushViewController:selectionVC animated:YES];
    }
}

//-(NSString *)datestrToDataStr:(NSString*)string{
//    NSString* str = [string substringWithRange:NSMakeRange(5, 5)];
//    str =[str stringByReplacingOccurrencesOfString:@"-" withString:@"月"];
//    str = [str stringByAppendingString:@"日"];
//    return str;
//}

-(void)updateDate:(NSString *)string WithTag:(int )index{
    if (index == 1) {
        enterdate = string;
        if (![leavedate isEqualToString:@""]) {
            daysLab.text = [NSString stringWithFormat:@"%@晚",[LXTools getDateGap:enterdate toDate:leavedate]];
        }
    }else if(index == 2){
        leavedate = string;
        if (![enterdate isEqualToString:@""]) {
            daysLab.text = [NSString stringWithFormat:@"%@晚",[LXTools getDateGap:enterdate toDate:leavedate]];
        }
    }
}

#pragma mark -
#pragma mark HotDetailSelectDelegate  
-(void)getCArray:(NSArray *)array{
    NSArray *arr = array;
    NSLog(@"%@",arr);
}



#pragma mark -
#pragma mark Tableview  dataSource/delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return headerheight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return footerheighter;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellheight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4; // 分组数
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (flag[section]) {
        return 3;
    }
    else{
        return 0;
    }
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    DetailHeaderView *header = [[DetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, headerheight) AndLeftImageString:@"默认图1" AndTitle:@"标准房" AndString:@"39平米 双床1.3米" AndDString:@"有窗  免费有线" AndPrice:@"￥289起" AndImageName:@"日期下拉"];
    
    UIButton *butn = [UIButton buttonWithType:UIButtonTypeCustom];
    butn.frame = header.frame;
    butn.backgroundColor = [UIColor clearColor];
    butn.tag = section;
    [butn addTarget: self action:@selector(changeSubView:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:butn];
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.lab1.text = @"不含早（内宾）";
    cell.lab2.text = @"限时取消";
    cell.lab3.text = @"立即确认";
    [cell.lab3 sizeToFit];
    cell.priceLab.text = @"￥289";
    cell.igv.image = [UIImage imageNamed:@"预付"];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JYCHouseDetailVC *vc = [[JYCHouseDetailVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];


}

-(void)changeSubView:(UIButton *)button{
    NSInteger section = button.tag;
    // 取反
    flag[section] = !flag[section];
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
    //  效率略高于reloadData
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
}

@end
