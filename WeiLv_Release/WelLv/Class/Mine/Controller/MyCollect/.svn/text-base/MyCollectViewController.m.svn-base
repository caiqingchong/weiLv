//
//  MyCollectViewController.m
//  WelLv
//
//  Created by WeiLv on 16/1/31.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "MyCollectViewController.h"

#import "MyCollectViewCell.h"

#import "AFNetworking.h"

#import "ProductModel.h"

#import "ProductDetailViewController.h"

@interface MyCollectViewController ()<ProductDetailViewControllerDelegate>

@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSMutableArray *timeSource;
@property (nonatomic,strong) ProductModel *productModel;

@end

@implementation MyCollectViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        self.dataSource  = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)timeSource{
    if (!_timeSource) {
        self.timeSource = [NSMutableArray array];
    }
    return _timeSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的收藏";
    
    
    [self readDataFromNet];
    
    //注册 cell
    [self.tableView registerClass:[MyCollectViewCell class] forCellReuseIdentifier:@"myCell"];
    self.tableView.tableFooterView= [[UIView alloc]init];
    
    [self addLeftItem];
    
}

#pragma mark ********自定义左 Item*****
- (void)addLeftItem{
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:(240/255.) green:(145/255.) blue:(40/255.) alpha:1];
}

- (void)leftItemAction:(UIBarButtonItem *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ********数据解析********
- (void)readDataFromNet{
    
//    self.dataSource = nil;
    self.timeSource = nil;

    NSString *user_id = [[[LXUserTool alloc]init] getUid];
    NSString *str = [NSString stringWithFormat:@"%@/api/newtravel/guanzhu?member_id=%ld&offset=1",WLHTTP,[user_id integerValue]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager POST:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        if (responseObject != nil) {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        

            if ([dictionary[@"status"] integerValue] == 1) {
                NSDictionary *dataDict = dictionary[@"data"];
                NSArray *array = dataDict[@"attentionList"];
                //开始解析数据时清空数据源
                [self.dataSource removeAllObjects];
                
                //遍历数组中的字典
                for (NSDictionary *dict in array) {
                    
                    if ([dict[@"status"] isEqualToString:@"5"]) {
                        self.productModel = [ProductModel new];
                        [self.productModel setValuesForKeysWithDictionary:dict];
                        
                        [self.dataSource addObject:_productModel];
                        
                        
                        NSArray *timeArr = dict[@"timetables"];
                        NSString *appendStr = [NSString string];
                        for (NSDictionary *timeDic in timeArr) {
                            
                            
                            ProductModel *timeModel = [ProductModel new];
                            
                            [timeModel setValuesForKeysWithDictionary:timeDic];
                            appendStr = [appendStr stringByAppendingString:[NSString stringWithFormat:@"%@、",timeModel.date_time]];
                            
                            
                            [self.productModel setValuesForKeysWithDictionary:timeDic];
                            appendStr = [appendStr stringByAppendingString:[NSString stringWithFormat:@"%@、",_productModel.date_time]];
                            
                        }
                        
                        NSString *totaoStr = [NSString stringWithString:appendStr];
                        [self.timeSource addObject:totaoStr];

                    }


                    
                }
                
            }
        }

        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
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

    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyCollectViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    self.productModel = self.dataSource[indexPath.row];
    //判读 self.productModel 是不是被收藏过
    
       [cell assignValueWithModel:_productModel];
       cell.dateLable.text = [NSString stringWithFormat:@"%@",self.timeSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UIScreen mainScreen].bounds.size.height / 5.97;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductDetailViewController *productVC = [ProductDetailViewController new];
    productVC.delegate = self;
    
    self.productModel = self.dataSource[indexPath.row];
    productVC.productID = _productModel.product_id;
    [self.navigationController pushViewController:productVC animated:YES];
    
}
#pragma mark -ProductDetailViewControllerDelegate 
/**
 *  判断 如果：当取消的产品 id 和cell里的id一致的话  移除cell
 *  textID:取消收藏 产品的product_id
 */
-(void)productDetailControllerWith:(NSString *)textID
{
    [self.dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        ProductModel *model =obj;
        
        if ([model.product_id intValue]==[textID intValue]) {
             *stop =YES;
            [self.dataSource removeObject:model];
        }
        
    }];
    [self.tableView reloadData];
    
}
#pragma mark *******Cell 的编辑*******
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//设置删除的文字格式
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
#pragma mark *******提交删除结果***********
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * user_id = [[[LXUserTool alloc] init] getUid];
    NSString *collectStr = COLLECT_NET;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    self.productModel = self.dataSource[indexPath.row];
    
    NSDictionary *parameters = @{@"member_id":user_id,@"product_id":self.productModel.product_id,@"product_type":self.productModel.route_type,@"is_delete":@"1"};

    [manager POST:collectStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([parameters[@"is_delete"] isEqualToString:@"1"]) {
           
            [self.dataSource removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
            [self.tableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       [[LXAlterView sharedMyTools] createTishi:@"删除失败"];
    }];
    

    
}



@end
