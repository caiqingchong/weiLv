//
//  ShowFoodViewController.m
//  WelLv
//
//  Created by liuxin on 15/11/11.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "orderModel.h"
#import "OrderCell.h"
#import "ShowFoodViewController.h"
#import "DVSwitch.h"
#import "SHViewController.h"
@interface ShowFoodViewController ()<UIActionSheetDelegate>
{
    NSMutableArray *_arr;
   // NSInteger _SelectionRow;
    
    
}
@property(nonatomic,strong)NSMutableArray *arr;
@property(nonatomic,assign)NSInteger SelectionRow;
@property(nonatomic,assign)NSInteger btnNumber;
@property(nonatomic,strong) MBProgressHUD *zxdHudSF;
@end

@implementation ShowFoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.SelectionRow = -1;
    self.btnNumber = 1;
    self.navigationItem.title = @"发布的商品";
    self.view.backgroundColor = [UIColor whiteColor];
    self.arr = [[NSMutableArray alloc] init];
    [self creatDVswitch];
    [self creatButton];
    [self creatTableView];
    [self download:1];
    //[self creatheadView];
    // Do any additional setup after loading the view.
}
-(void)creatButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"上货" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor orangeColor];
    button.frame = CGRectMake(15, 65, windowContentWidth-30, 45);
    [button addTarget:self action:@selector(upFood:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}
-(void)creatTableView
{
    self.tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, windowContentWidth, windowContentHeight-94-50)];
    self.tableView1.tableFooterView = [[UIView alloc] init];//去掉多余的cell
    self.tableView1.delegate= self;
    self.tableView1.dataSource= self;
    self.tableView1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView1];
}
-(void)creatDVswitch
{
    DVSwitch *frist = [DVSwitch switchWithStringsArray:@[@"菜品",@"套餐",@"抵用劵",@"土特产",]];
    frist.frame = CGRectMake(0, 0, windowContentWidth, 50);
    
    frist.backgroundColor = kColor(44,198, 95);
    // [UIColor colorWithHue:44 saturation:198 brightness:95 alpha:1.0];
    frist.sliderColor = [UIColor whiteColor];
    frist.labelTextColorInsideSlider = [UIColor blackColor];
    frist.labelTextColorOutsideSlider = [UIColor whiteColor];
    frist.cornerRadius = 0;
    [self.view addSubview:frist];
    //下载数据的时候，需要将第一个button的数据默认设置
    [frist setWillBePressedHandler:^(NSUInteger index) {
        //[self.arr removeAllObjects];
        NSLog(@"类型--%ld",index+1);
        self.btnNumber  = index+1;
        [self download:index+1];
        [self.tableView1 reloadData];
       
        //NSLog(@"=========%ld",index);
    }];
    
}
#pragma mark - TableViewdataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
          return self.arr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"+++++++++++++%ld",indexPath.row);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier10000 = @"cellIdentifier10000";
    
    OrderCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier10000];
    
    if (cell == nil)
    {
        cell=[[OrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier10000];
        
        //单元格的选择风格，选择时单元格不出现蓝条
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    orderModel *model1 = [self.arr objectAtIndex:indexPath.row];
    [cell.btn addTarget:self action:@selector(btnCkicl:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn setBackgroundImage:[UIImage imageNamed:@"自驾吃编辑删除"] forState:UIControlStateNormal];
    //cell.btn.tag = indexPath.row;
    [cell.sw addTarget:self action:@selector(zxdSw:) forControlEvents:UIControlEventValueChanged];
        cell.sw.tag = 500+indexPath.row;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",WLHTTP,model1.imageStr]] placeholderImage:[UIImage imageNamed:@"默认图1.png"]];
    cell.imageView.image = [self imageWithImageSimple:cell.imageView.image scaledToSize:CGSizeMake(60, 60)];
    NSLog(@"图片链接===%@",[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",WLHTTP,model1.imageStr]]);
        cell.indexPath2 = indexPath;
    cell.nameLabel.text = model1.nameStr;
    if ([model1.SWStr isEqual:@"1"]) {
        cell.dataLabel.text = @"已上架";
        [cell.sw setOn:YES];
    }
    else
    {
        cell.dataLabel.text = @"未上架";
        [cell.sw setOn:NO];
    }

    

    NSLog(@"++++%@",cell.model.SWStr);
   
    
        
    return cell;
}

-(void)creatheadView
{
    UIView *view1 = [[UIView alloc] init];
    view1.frame = CGRectMake(0, 0, windowContentWidth, 50);
    view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:view1];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)upFood:(UIButton *)btn
{
    NSLog(@"上货");
    SHViewController *sh = [[SHViewController alloc] init];
    [self.navigationController pushViewController:sh animated:YES];
    
}

#pragma mark -下载
-(void)download:(NSInteger)pag
{
    [self.arr removeAllObjects];
    NSLog(@"page === %ld", pag);
    NSString *page = [NSString stringWithFormat:@"%ld",pag];
    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
   
    NSString * shopId = [[WLSingletonClass defaultWLSingleton] wlDEShopID];
    NSString *token1 = [token stringByAppendingString:shopId];
    NSDictionary *parameters = @{@"shopId":shopId,
                                 @"wltoken":[WXUtil md5:token1],
                                 @"data":[[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:@{@"type":page}]
                                 };
   
    NSString *zxdUrl = [NSString stringWithFormat:@"%@/%@",WLHTTP,@"api/drivingShop/productList"];
    NSLog(@"par=%@",parameters);
    [self sendWith:zxdUrl dict:parameters];
}
-(void)sendWith:(NSString *)url dict:(NSDictionary *)dict
{
    [self setHud:@"正在下载,,,,"];
    __weak typeof(self)weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];;
   
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"msg ==== %@",dict);
        self.zxdHudSF.labelText = dict[@"msg"];
        self.zxdHudSF.hidden = YES;
                if ([dict objectForKey:@"data"] && [[dict objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
            NSArray *arr = dict[@"data"];
            NSLog(@"99999%@",[LXTools JSONValue:[[arr objectAtIndex:0] valueForKey:@"images"]]);
                    [weakSelf.arr removeAllObjects];
            for (id str in arr) {
                orderModel *model = [[orderModel alloc] init];

                model.imageStr = [[WLSingletonClass defaultWLSingleton] wlJsonStringToDicOrArr:str[@"images"]][0];
                model.nameStr = str[@"describe"];
                model.SWStr = str[@"status"];
                    model.uid = str[@"id"];
                
                [weakSelf.arr addObject:model];
                
            }
            [weakSelf.tableView1 reloadData];

        }
        
        
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertViewFail = [[UIAlertView alloc] initWithTitle:@"下载失败" message:@"请检查您的网路是否正常" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertViewFail show];
        
        
        
    }];
}
- (NSString*)arrayToJson:(NSArray *)arr {
    
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

- (NSString*)dictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
-(void)zxdSw:(UISwitch *)zxdSW
{
    OrderCell *cell = (OrderCell *)[zxdSW superview];
    self.SelectionRow = cell.indexPath2.row;
    NSLog(@"row==%ld",self.SelectionRow);
    orderModel *model = [self.arr objectAtIndex:cell.indexPath2.row];
    if ([model.SWStr isEqual:@"1"])
    {
        model.SWStr = @"0";
    }
    else
    {
        model.SWStr = @"1";
    }
    [self upDownFood:model.SWStr Uid:model.uid];
}
-(void)btnCkicl:(UIButton *)btn
{
    NSString *str1;
    OrderCell *cell = (OrderCell *)[btn superview];
    NSLog(@"cell==%@",cell);
    self.SelectionRow = cell.indexPath2.row;
   
    NSLog(@"self.SelectionRow == %ld",self.SelectionRow);
    orderModel *model = [self.arr objectAtIndex:cell.indexPath2.row];
  
    //[self.tableView1 reloadData];
    
   // orderModel *model = [self.arr objectAtIndex:btn.tag];
    if ([model.SWStr isEqual:@"1"]) {
        str1 = @"下架";
    }
    else
    {
        str1 = @"上架";
    }
    UIActionSheet *alertView = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:str1,@"删除",@"取消", nil];
    [alertView showInView:self.view];
    
}
#pragma mark -UIActionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex == %ld",buttonIndex);
    switch (buttonIndex) {
        case 0:
        {
            orderModel *model = [self.arr objectAtIndex:self.SelectionRow];
            if ([model.SWStr isEqual:@"1"])
            {
                model.SWStr = @"0";
            }
            else
            {
                model.SWStr = @"1";
            }
            [self upDownFood:model.SWStr Uid:model.uid];
            
            
        }
            break;
        case 1:
        {
            //删除
           // [self.arr removeObjectAtIndex:self.SelectionRow];
            DLog(@"删除操作,,,,,,,,,,");
             orderModel *model = [self.arr objectAtIndex:self.SelectionRow];
            DLog(@"***************self.SelectionRow====%ld",self.SelectionRow);

            [self upDownFood:nil Uid:model.uid];
            //NSLog(@"self.SelectionRow====%ld",self.SelectionRow);
        }
            break;
        case 2:
        {
            self.SelectionRow = -1;
        }
            break;
        default:
            break;
    }
}
-(void)upDownFood:(NSString *)status Uid:(NSString *)uid
{
    [self setHud:@"正在处理,,,,"];
    //@"data":[self arrayToJson:arr]
    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
    
    NSString * shopId = [[WLSingletonClass defaultWLSingleton] wlDEShopID];
    //NSArray *arr = @[@{@"id":uid,@"status":status}];
    NSDictionary *dictArr = nil;
    NSString *zxdUrl = nil;
    if ([self judgeString:status]) {
        dictArr = @{@"id":uid,@"status":status};
        zxdUrl = [NSString stringWithFormat:@"%@/%@",WLHTTP,@"/api/drivingShop/productOnOff"];
    }
    else
    {
        dictArr =@{@"id":uid};
        zxdUrl = [NSString stringWithFormat:@"%@/%@",WLHTTP,@"/api/drivingShop/productDel"];
        DLog(@"dictArr=====%@",dictArr);
        
    }
   
    NSString *token1 = [token stringByAppendingString:shopId];
    NSDictionary *parameters = @{@"shopId":shopId,
                                 @"wltoken":[WXUtil md5:token1],
                                @"data":[self dictionaryToJson:dictArr]
                                 };
    
  //  NSString *zxdUrl = [NSString stringWithFormat:@"%@/%@",WLHTTP,@"/api/drivingShop/productOnOff"];
    DLog(@"par=%@",parameters);

    __weak typeof(self)weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];;
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:zxdUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        self.zxdHudSF.labelText =dict[@"msg"];
        self.zxdHudSF.hidden = YES;
           DLog(@"删除结果===%@",dict);
      //  [weakSelf download:weakSelf.btnNumber];
       NSString *resultStr = [NSString stringWithFormat:@"%@",dict[@"state"]];
        if ([resultStr isEqualToString:@"1"]) {
            //[weakSelf.arr removeObjectAtIndex:self.SelectionRow];
                [weakSelf download:weakSelf.btnNumber];
                [weakSelf.tableView1 reloadData];
           
        }
        else
        {
           UIAlertView *alertViewFail = [[UIAlertView alloc] initWithTitle:dict[@"msg"] message:nil delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
           [alertViewFail show];
            
        }
        
                  DLog(@"上下架结果%@",dict[@"msg"]);
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertViewFail = [[UIAlertView alloc] initWithTitle:@"操作失败" message:@"请检查您的网路是否正常" delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertViewFail show];
        
        DLog(@"%@",error);
        DLog(@"下载失败");
    }];
   
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
//压缩图片
- (UIImage *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
-(void)setHud:(NSString *)str
{
    
    self.zxdHudSF = [[MBProgressHUD alloc] initWithView:self.view];
    self.zxdHudSF.frame = self.view.bounds;
    self.zxdHudSF.minSize = CGSizeMake(100, 100);
    self.zxdHudSF.mode = MBProgressHUDModeIndeterminate;
    self.zxdHudSF.labelText = str;
    [self.view addSubview:self.zxdHudSF];
    // [_zxdTableView bringSubviewToFront:self.zxdHud];
    [self.zxdHudSF show:YES];
}

@end
