//
//  zxdLoveViewController.m
//  WelLv
//
//  Created by liuxin on 16/1/18.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "zxdLoveViewController.h"
#import "MBProgressHUD.h"
@interface zxdLoveViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(strong,nonatomic)NSArray *arrTheme;
@property(strong,nonatomic)NSArray *arrType;
@property(strong,nonatomic)NSArray *arrSeason;
@property(strong,nonatomic)NSArray *arrRegion;
@property(strong,nonatomic)NSArray *arrAllImage;

@property(nonatomic,strong) MBProgressHUD *zxdHud;

@property(nonatomic,strong)UICollectionView *zxdCollectionView;
@end

@implementation zxdLoveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTitle];
    [self creatViewArr];
    [self creatView];
    //[self zxdDownDate];
    // Do any additional setup after loading the view.
}

-(void)creatTitle
{
    self.zxdDataViewWillArr = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [YXTools stringToColor:@"#dee5eb"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[YXTools stringToColor:@"#3c4042"]}];
   // UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom] ;
   // UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(zxdConserveright)];
    self.navigationItem.rightBarButtonItem.tintColor =[YXTools stringToColor:@"#ff9600"];
    //self.navigationItem.rightBarButtonItem = btn;
  //  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(zxdConserveleft)];

}
-(void)creatViewArr
{
    //夏天 秋天 端午 暑假  七夕 5月 6月 7月 8月 9月 10月 11月 12月 1月 2月 3月 4月 冬天 春天 中秋 十一 光棍节 圣诞节 元旦 春节 情人节 清明五一
    self.arrTheme = @[@"自驾摄影",@"徒步登山",@"亲子避暑",@"潜水漂流",@"蜜月情侣",@"滑雪温泉",@"骑马赏花",@"动物骑行",@"宗教历史",@"民俗艺术",@"泡吧SPA",@"家庭艳遇",@"毕业旅行",@"夕阳红",@"踏青采摘",@"独行背包客",@"文艺美食购物"];
    self.arrType = @[@"城市古镇",@"乡村海边",@"草原森林",@"瀑布湖泊",@"湿地河流",@"峡谷雪山",@"冰川沙漠",@"雪地山",@"人文地质",@"自然休闲"];
    self.arrSeason = @[@"春天",@"夏天",@"秋天",@"冬天",@"元旦",@"春节",@"情人节",@"清明",@"五一",@"端午",@"七夕",@"中秋",@"十一",@"光棍节",@"圣诞节",@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月",];
    self.arrRegion = @[@"国内",@"港澳台",@"东北",@"西藏",@"四川",@"新疆",@"浙江",@"江苏",@"福建",@"江西",@"广西",@"贵州",@"海南",@"湖南",@"国外",@"东南亚",@"东亚",@"南亚",@"中西亚",@"欧洲",@"大洋洲",@"北美洲",@"南美洲",@"非洲",];
    self.arrAllImage =[[NSArray alloc] initWithObjects:self.arrTheme,self.arrType,self.arrSeason,self.arrRegion, nil];
    //NSArray *zxdArr = @[@"国内",@"港澳台",@"东北",@"自驾摄影",@"徒步登山",@"亲子避暑",@"城市古镇",@"乡村海边",@"草原森林",@"夏天",@"秋天",@"端午",@"暑假",@"七夕"];
   // self.zxdDownArr = [[NSMutableArray alloc] initWithArray:zxdArr];
    
}
-(void)creatView
{
    //1.先创建一个UIcollectionViewFlowLayout(是集合视图的核心)
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //2.对layout做一些基本设置
    //设置cell的大小(全局设置)(如果要单个对cell大小进行设置需要遵守UICollectionViewDelegateFlowLayout协议实现方法)
    //设置滚动的方向(水平和竖直)
    //UICollectionViewScrollDirectionHorizontal水平
    //UICollectionViewScrollDirectionVertical
    //layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //设置cell 的大小(全局设置)(如果要单个对cell 大小进行设置需要遵守UICollectionViewDelegateFlowLayout协议实现方法)
    if (windowContentWidth>320) {
        layout.itemSize = CGSizeMake(100, 30);

    }
    else
    {
        layout.itemSize = CGSizeMake(80, 30);
    }
        switch (self.Type) {
        case 0:
        {
            //6行 260
            if (windowContentWidth>380) {
                
               self.zxdCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, windowContentWidth, 320) collectionViewLayout:layout];
                
            }
            else
            {
              self.zxdCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, windowContentWidth, 290) collectionViewLayout:layout];
            }
            

        }
            break;
        case 1:
        {
            //4行 180
            if (windowContentWidth>380) {
                
                 self.zxdCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, windowContentWidth, 220) collectionViewLayout:layout];
                
            }
            else
            {
               self.zxdCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, windowContentWidth, 200) collectionViewLayout:layout];
            }
           

        }
            break;
        case 2:
        {
            //10行 420
            if (windowContentWidth>380) {
                
                 self.zxdCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, windowContentWidth, 475) collectionViewLayout:layout];
                
            }
            else
            {
                 self.zxdCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, windowContentWidth, 460) collectionViewLayout:layout];
            }
           

        }
            break;
        case 3:
        {
            //90行  345
            if (windowContentWidth>380) {
                
                self.zxdCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, windowContentWidth, 425) collectionViewLayout:layout];
                
            }
            else
            {
             self.zxdCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, windowContentWidth, 385) collectionViewLayout:layout];
            }
            

        }
            break;
        default:
            break;
    }
    //self.zxdCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, windowContentWidth, windowContentHeight/2) collectionViewLayout:layout];
    //设置代理和数据源对象
   
    self.zxdCollectionView.dataSource = self;
    self.zxdCollectionView.delegate = self;
    self.zxdCollectionView.backgroundColor = [UIColor whiteColor];
    //cell必须提前注册 复用标志要和下面队列获取cell的时候一样
    self.zxdCollectionView.scrollEnabled = NO;
       [self.zxdCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"zxdCollectionViewCell"];
    
    //如果设置分区的头尾视图那么需要进行注册(注册之后就可以采用复用队列)
    //kind 表示 是头视图还是尾视图 第三个参数就是一个复用标识符 要和下面使用保持一致
//    [self.zxdCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    //注册分区尾视图
    [self.zxdCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer"];
    [self.view addSubview:self.zxdCollectionView];
    //self.zxdCollectionView.backgroundColor = BgViewColor;

}
#pragma mark-----UIcollectionViewDataSoyrce delegate
//有多少分区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个分区有多少个cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[self.arrAllImage objectAtIndex:self.Type] count];
}
//获取指定分区内的cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"zxdCollectionViewCell";
    //从复用队列获取cell(需要提前注册)
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
     UIImageView *zxdImageView = [[UIImageView alloc] init];
    zxdImageView.layer.masksToBounds = YES;
    zxdImageView.layer.cornerRadius = 2;
    UILabel *label = [[UILabel alloc] init];
    label.layer.cornerRadius = 2;
    
//    if (indexPath.row == 16&&self.Type == 0) {
//        label.frame =CGRectMake(0, 0, 130, 30);
//        zxdImageView.frame = CGRectMake(0, 0, 130, 30);
//        if (windowContentWidth<=320) {
//            label.font = [UIFont systemFontOfSize:12];
//        }
//        
//       //UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
//    }
//   else
//   {
       if (windowContentWidth>320) {
           if (indexPath.row == 16 && self.Type == 0) {
               label.frame =CGRectMake(0, 0, 130, 30);
               zxdImageView.frame = CGRectMake(0, 0, 130, 30);
 
           }
           else
           {
          // return CGSizeMake(100, 30);
           label.frame =CGRectMake(0, 0, 100, 30);
           zxdImageView.frame = CGRectMake(0, 0, 100, 30);
           }
       }
       else
       {
           //label.font = [UIFont systemFontOfSize:12];
           if (indexPath.row >14 && self.Type == 0) {
               label.frame =CGRectMake(0, 0, 120, 30);
               zxdImageView.frame = CGRectMake(0, 0, 120, 30);
               
           }
           else
           {
               // return CGSizeMake(100, 30);
               label.frame =CGRectMake(0, 0, 80, 30);
               zxdImageView.frame = CGRectMake(0, 0, 80, 30);
           }

//           label.frame =CGRectMake(0, 0, 60, 30);
//           label.font = [UIFont systemFontOfSize:12];
//           zxdImageView.frame = CGRectMake(0, 0, 60, 30);
          // return CGSizeMake(60, 30);
       }

       
       // UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
 //  }
    label.textAlignment = NSTextAlignmentCenter;
    label.text =[[self.arrAllImage objectAtIndex:self.Type] objectAtIndex:indexPath.row];
    
    label.layer.borderWidth = 1.0;
   // label.textColor = BgViewColor;
    /* if (![zxdImageView.image isEqual:[UIImage imageNamed:@"zxd选择框"]]) {
     //cell.backgroundColor = [UIColor orangeColor];
     //UIImageView *zxdImageView = (UIImageView *)[self.view viewWithTag:100+indexPath.row];
     zxdImageView.image = [UIImage imageNamed:@"zxd选择框"];
     label.textColor = [UIColor orangeColor];
     label.layer.borderColor =[UIColor orangeColor].CGColor;
     [self.arrAddImage addObject:[[self.arrAllImage objectAtIndex:self.Type] objectAtIndex:indexPath.row]];
     }
     else
     {
     //cell.backgroundColor = BgViewColor;
     //UIImageView *zxdImageView = (UIImageView *)[self.view viewWithTag:100+indexPath.row];
     zxdImageView.image = [UIImage imageNamed:@""];
     label.textColor = [UIColor grayColor];
     label.layer.borderColor =[UIColor grayColor].CGColor;
     [self.arrAddImage removeObject:[[self.arrAllImage objectAtIndex:self.Type] objectAtIndex:indexPath.row]];
     }
*/
       if ([self isContents:label.text]) {
           zxdImageView.image = [UIImage imageNamed:@"zxd选择框"];
           label.textColor = [YXTools stringToColor:@"#ff9600"];
           label.layer.borderColor = [YXTools stringToColor:@"#ff9600"].CGColor;
          // [self.arrAddImage addObject:[[self.arrAllImage objectAtIndex:self.Type] objectAtIndex:indexPath.row]];
    }
    else
    {
      //  label.textColor =[UIColor grayColor];
       // label.layer.borderColor =[UIColor grayColor].CGColor;
        zxdImageView.image = [UIImage imageNamed:@""];
        label.textColor = [YXTools stringToColor:@"#b1b7bb"];
        label.layer.borderColor =[YXTools stringToColor:@"#b1b7bb"].CGColor;
       // [self.arrAddImage removeObject:[[self.arrAllImage objectAtIndex:self.Type] objectAtIndex:indexPath.row]];
 
    }
   
    zxdImageView.backgroundColor = [UIColor clearColor];
    //zxdImageView.image = [UIImage imageNamed:@""];
    zxdImageView.tag = indexPath.row + 100;
    label.tag = indexPath.row + 300;
    
    
    [cell addSubview:zxdImageView];
     [cell addSubview:label];
    //cell.backgroundColor = BgViewColor;
    return cell;
}
-(BOOL)isContents:(NSString *)zxdStr
{
    
    if (self.zxdDownArr.count == 0) {
        return NO;
    }
    for (int i = 0; i<self.zxdDownArr.count; i++) {
        if ([[self.zxdDownArr objectAtIndex:i] isEqualToString:zxdStr]) {
            return YES;
        }
    }
    return NO;
}
-(void)viewWillAppear:(BOOL)animated
{
    
    
   }
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    UIImageView *zxdImageView = (UIImageView *)[self.view viewWithTag:100+indexPath.row];
    UILabel *label = (UILabel *)[self.view viewWithTag:300+indexPath.row];
   // zxdImageView.image = [UIImage imageNamed:@"zxd选择框"];

   // UIColor *zxdColor = [UIColor orangeColor];
    if (![zxdImageView.image isEqual:[UIImage imageNamed:@"zxd选择框"]]) {
        //cell.backgroundColor = [UIColor orangeColor];
        //UIImageView *zxdImageView = (UIImageView *)[self.view viewWithTag:100+indexPath.row];
        zxdImageView.image = [UIImage imageNamed:@"zxd选择框"];
        label.textColor = [YXTools stringToColor:@"#ff9600"];
        label.layer.borderColor = [YXTools stringToColor:@"#ff9600"].CGColor;
        [self.arrAddImage addObject:[[self.arrAllImage objectAtIndex:self.Type] objectAtIndex:indexPath.row]];
        [self.zxdDataViewWillArr addObject:[[self.arrAllImage objectAtIndex:self.Type] objectAtIndex:indexPath.row]];
    }
    else
    {
        //cell.backgroundColor = BgViewColor;
        //UIImageView *zxdImageView = (UIImageView *)[self.view viewWithTag:100+indexPath.row];
        zxdImageView.image = [UIImage imageNamed:@""];
        label.textColor = [YXTools stringToColor:@"#b1b7bb"];
        label.layer.borderColor = [YXTools stringToColor:@"#b1b7bb"].CGColor;
        [self.arrAddImage removeObject:[[self.arrAllImage objectAtIndex:self.Type] objectAtIndex:indexPath.row]];
        [self.zxdDataViewWillArr removeObject:[[self.arrAllImage objectAtIndex:self.Type] objectAtIndex:indexPath.row]];
    }
    
}
#pragma mark - UICollectionViewDelegateFlowLayout
//下面都是 layout 对单个 cell/分区进行设置

//设置 单个 cell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

   
if (windowContentWidth>320) {
        if (self.Type == 0&&indexPath.row == 16) {
            return CGSizeMake(130, 30);
        }
        else{
           return CGSizeMake(100, 30);
        }
       }
       else
       {
           if (self.Type == 0&&indexPath.row > 14) {
               return CGSizeMake(120, 30);
           }
           else{
               return CGSizeMake(80, 30);
           }
       }
   }

////设置 指定分区  整个分区cell整体 距离分区的上下左右间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //可以对指定分区设置
//    if (windowContentWidth>380) {
//     return UIEdgeInsetsMake(20, 20, 20, 40);
//    }
    if (windowContentWidth>400) {
        return UIEdgeInsetsMake(25, 20, 25, 30);
        
    }
    return UIEdgeInsetsMake(15, 20, 20, 30);//上,左,下,右
}
//对指定分区内的 cell 最小竖直间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    //设置 竖直最小间隔
    if (windowContentWidth>400) {
        return 20.0f;
        
    }
    return 15.0f;
}
//对指定分区内的 cell 最小水平间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (windowContentWidth>380) {
        
        return 20.0f;

    }
    else
    {
        return 10.0f;
    }
}

#pragma mark - 获取分区头尾视图
//创建 分区头尾视图调用
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    //创建/获取头尾视图的时候也要用复用队列
    //判断kind 来区分头尾
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        //头视图
        //(如果满足不了需要那么就定制)
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Header" forIndexPath:indexPath];
        header.backgroundColor = [UIColor greenColor];
        return header;
    }else {
        //尾视图
        //复用队列获取
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Footer" forIndexPath:indexPath];
        footer.backgroundColor = [UIColor yellowColor];
        return footer;
    }
}

//确定按钮
-(void)zxdConserveright
{
    [self zxdDownDate];
}
//取消按钮
-(void)zxdConserveleft
{
    [self close];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)zxdDownDate
{
    NSString *url = [NSString stringWithFormat:@"%@%@",WLHTTP,@"/api/assistant/edit_member_info"];
    NSDictionary *dic = nil;
    switch (self.Type) {
        case 0:
        {
            dic =@{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                   @"theme":self.arrAddImage};
        }
            break;
        case 1:
        {
           dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
              @"type":self.arrAddImage};
        }
            break;
        case 2:
        {
            dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                    @"season":self.arrAddImage};

        }
            break;
        case 3:
        {
            dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                    @"region":self.arrAddImage};

        }
            break;
        default:
            break;
    }
    //@"theme,type,season,region"
    NSDictionary *parameters = @{@"member_id":self.uid,
                                 @"data":[[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:dic]};
    //data={"token":"7a6bd7af36e5db226281a037909fbdfd","select":"*"}&member_id=31040
    [self setHud:@"正在保存"];
    __weak typeof (self)weakSelf = self;
    AFHTTPRequestOperationManager *zxdManager = [AFHTTPRequestOperationManager manager];
    zxdManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [zxdManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        weakSelf.zxdHud.hidden = YES;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if ([dict count]==0) {
            [[LXAlterView sharedMyTools] createTishi:@"保存失败"];
            
        }
        else if ([[dict objectForKey:@"status"] integerValue]!=1)
        {
            [[LXAlterView sharedMyTools] createTishi:@"保存失败"];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        //weakSelf.zxdHud.labelText = dict[@"msg"];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        weakSelf.zxdHud.hidden = NO;
    }];

}
-(void)setHud:(NSString *)str
{
    
    self.zxdHud = [[MBProgressHUD alloc] initWithView:self.view];
    self.zxdHud.frame = self.view.bounds;
    self.zxdHud.minSize = CGSizeMake(100, 100);
    self.zxdHud.mode = MBProgressHUDModeIndeterminate;
    self.zxdHud.labelText = str;
    [self.view addSubview:self.zxdHud];
    // [_zxdTableView bringSubviewToFront:self.zxdHud];
    [self.zxdHud show:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)close
{
    //self.arrAddImage     self.zxdDataViewWillArr
    //[self zxdDownDate];
    for (id obj in self.zxdDataViewWillArr) {
        [self.arrAddImage  removeObject:obj];
    }
    [super close];
}
@end
