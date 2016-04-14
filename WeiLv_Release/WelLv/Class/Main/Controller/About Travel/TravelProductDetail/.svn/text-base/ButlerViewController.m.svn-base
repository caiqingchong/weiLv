//
//  ButlerViewController.m
//  TraveDetail
//
//  Created by WeiLv on 16/1/12.
//  Copyright © 2016年 WeiLv. All rights reserved.
//

#import "ButlerViewController.h"

#import "ButlerViewCell.h"

#import "AFNetworking.h"

#import "ProductModel.h"

#import "ProductDetailViewController.h"

@interface ButlerViewController ()

@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation ButlerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //初始化数据源
    self.dataArray = [NSMutableArray array];
    
    self.title = @"管家列表";
    //注册cell
    [self.tableView registerClass:[ButlerViewCell class] forCellReuseIdentifier:@"butler"];
    
    //调用解析数据的方法
    [self readDataFromNet:self.admin_ID];
    
    //添加左右 Item
    [self addLeftAndRightOfItem];
}

#pragma mark *****添加左右 Item *********

- (void)addLeftAndRightOfItem{
    
    //左边返回 Item
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    //右边咨询客服 Item
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"咨询客服" style:UIBarButtonItemStylePlain target:self action:@selector(referAction:)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:(240/255.) green:(145/255.) blue:(40/255.) alpha:1];
    
}

#pragma mark *****Item 关联事件 ********
- (void)backAction:(UIBarButtonItem *)item{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)referAction:(UIBarButtonItem *)item{
//    NSLog(@"开始咨询客服");
    NSString *mobileStr = [NSString stringWithFormat:@"tel:%@",self.admin_Mobile];
    NSURL *url = [NSURL URLWithString:mobileStr];
    [[UIApplication sharedApplication] openURL:url];
    
}


#pragma mark ******网络数据请求*******
- (void)readDataFromNet:(NSString *)admin_ID{
    
    NSString *string = [NSString stringWithFormat:@"%@%@",M_CALL_HOUSEKEEPER_LIST_URL,admin_ID];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:string parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = dictionary[@"data"];
        for (NSDictionary *dict in array) {
            ProductModel *model = [ProductModel new];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataArray addObject:model];
        }
        //验证
        //        NSLog(@"%@",self.dataArray);
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
        [self readDataFromNet:admin_ID];
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ButlerViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"butler" forIndexPath:indexPath];
    
    ProductModel *model = self.dataArray[indexPath.row];
    [cell assignValueByModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductModel *mobile = self.dataArray[indexPath.row];
    NSString *mobileStr = [NSString stringWithFormat:@"tel:%@",mobile.mobile];
    NSURL *url = [NSURL URLWithString:mobileStr];
    [[UIApplication sharedApplication] openURL:url];
    
}

/**
 *  返回 cell 的高
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UIScreen mainScreen].bounds.size.height / 6;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
