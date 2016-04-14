 //
//  BoutiqueTableViewController.m
//  WelLv
//
//  Created by 张子乾 on 16/1/13.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "BoutiqueTableViewController.h"
#import "TravelAllHeader.h"
#import "AFNetworking.h"
#import "ProductDetailViewController.h"
#import "GuoneiViewController.h"




@interface BoutiqueTableViewController ()
{
    NSInteger buttonHeight;
    BOOL isHide;
    NSInteger sectionTitleX;
    NSInteger secitonTitleY;
    NSInteger sectionTitleWidth;
    NSInteger sectionTitleHeight;
    NSInteger sectionTitleSize;
    CGFloat buttonY;
    
//    NSInteger 
}





@end

@implementation BoutiqueTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lineDataArray = [NSMutableArray array];
    
    if (UISCREEN_HEIGHT < 569) {
        sectionTitleSize = 14;
        sectionTitleHeight = 31;
    } else if (UISCREEN_HEIGHT == 667) {
        sectionTitleSize = 15;
        sectionTitleHeight = 37;
    } else if (UISCREEN_HEIGHT == 736) {
        sectionTitleSize = 16;
        sectionTitleHeight = 40;
    }
    
    
    
    _city_id=[[WLSingletonClass defaultWLSingleton] wlCityId];

    [self getDataFromURL];
    if (UISCREEN_HEIGHT < 667) {
        buttonHeight = 30;
    } else {
        buttonHeight = 40;
    }
    
    [self.tableView registerClass:[BoutiqueLineTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView.backgroundColor = [UIColor clearColor];
    

}

//查看更多
- (void)gotoMoreLinePage {
    
    GuoneiViewController *guoneiVC = [[GuoneiViewController alloc]init];
    guoneiVC.rote_ID = -11;
    guoneiVC.cityTitle = @"周边游";
    [self.navigationController pushViewController:guoneiVC animated:YES];
    
    TravelViewController *travelVC = (TravelViewController *)self.view.superview.viewController;
    [travelVC.navigationController pushViewController:guoneiVC animated:YES];
}


//请求数据并解析
- (void)getDataFromURL {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *weiLvStr = nil;
    
//    NSDictionary *parameters = [NSDictionary dictionary];
    if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward) {
        //管家ID
        NSString *assitID = [NSString stringWithFormat:@"assistant_id=%@",[[LXUserTool sharedUserTool]getKeeper]];
        NSString *weiLvStr2 = [NSString stringWithFormat:@"%@%@",LYHomePageURL,_city_id];
        weiLvStr = [NSString stringWithFormat:@"%@&%@",weiLvStr2,assitID];
        
    } else {
        weiLvStr = [NSString stringWithFormat:@"%@%@",LYHomePageURL,_city_id];
    }

//    NSLog(@"------%@------",weiLvStr);
    [manager GET:weiLvStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *firstDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *dataDic = firstDic[@"data"];
        
        NSArray *jpArray = dataDic[@"jp_products"];
        for (NSDictionary *jpDic in jpArray) {
            TravelJPLineModel *jpModel = [[TravelJPLineModel alloc]init];
            [jpModel setValuesForKeysWithDictionary:jpDic];
//            DLog(@"%@",jpDic);
            [self.lineDataArray addObject:jpModel];
        }
        
        for (TravelJPLineModel *lineModel in self.lineDataArray) {
            
            if (!lineModel.travel_tag || [lineModel.travel_tag isEqualToString:@""]) {
                
                buttonY += 260;
            }else{
                
                buttonY += 300;
            }
            
        }
        
        UIButton *moreButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        if (UISCREEN_WIDTH == 320) {
             moreButton.frame = CGRectMake( 10, buttonY + 70, [UIScreen mainScreen].bounds.size.width - 20, buttonHeight);
        }else{
             moreButton.frame = CGRectMake( 10, buttonY + 75, [UIScreen mainScreen].bounds.size.width - 20, buttonHeight);
        }
//        moreButton.backgroundColor = [UIColor redColor];
        moreButton.layer.masksToBounds = YES;
        
        moreButton.layer.cornerRadius = 2.f;
        
        
        
        moreButton.tintColor = [UIColor blackColor];
        moreButton.titleLabel.textColor = [UIColor blackColor];
        
        [moreButton setTitle:@"查看更多" forState:(UIControlStateNormal)];
        [moreButton setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [moreButton addTarget:self action:@selector(gotoMoreLinePage) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.view addSubview:moreButton];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        nil;
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

    return self.lineDataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BoutiqueLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    TravelJPLineModel *model = self.lineDataArray[indexPath.row];
    [cell setDataFromModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
   
    if ([[WLSingletonClass defaultWLSingleton] wlUserType]==WLMemberTypeSteward) {
        cell.commissionLabel.hidden = NO;
        //返佣
        NSString *commsionStr = [NSString stringWithFormat:@"返佣:¥%.2f",[model.gj_adult_rebate floatValue]];
        cell.commissionLabel.font = [UIFont systemFontOfSize:14];
        cell.commissionLabel.textAlignment = NSTextAlignmentCenter;
//        CGSize size = [commsionStr sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(MAXFLOAT, cell.commissionLabel.frame.size.height)];
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
        CGSize letterSize = CGSizeMake(MAXFLOAT, cell.commissionLabel.frame.size.height);
        CGRect letterRect = [commsionStr boundingRectWithSize:letterSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        NSInteger commissionX;
        if (UISCREEN_HEIGHT < 569) {
            commissionX = 5;
        } else {
            commissionX = 10;
        }
        [cell.commissionLabel setFrame:CGRectMake(CGRectGetMaxX(cell.priceLabel.frame) + commissionX, CGRectGetMinY(cell.priceLabel.frame), letterRect.size.width, 20)];
        cell.commissionLabel.layer.masksToBounds = YES;
        cell.commissionLabel.layer.cornerRadius = 10.f;
        cell.commissionLabel.text = commsionStr;
       
    } else {
        cell.commissionLabel.hidden = YES;
    }
    return cell;
}




//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 37)];
//    headerView.backgroundColor = [UIColor whiteColor];
//    return headerView;
//}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return @"精品线路";
//}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor whiteColor];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *hearderView = [[UIView alloc]init];
    UILabel *sectionTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width, sectionTitleHeight)];
    sectionTitleLabel.text = @"精品线路";
    sectionTitleLabel.font = [UIFont systemFontOfSize:sectionTitleSize];
    [hearderView addSubview:sectionTitleLabel];
    return hearderView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    TravelJPLineModel *model = self.lineDataArray[indexPath.row];
    
    if (!model.travel_tag || [model.travel_tag isEqualToString:@""]) {
        return 280;
    }
    return kLineTableViewRowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return sectionTitleHeight;
}



//选择点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductDetailViewController *productVC = [[ProductDetailViewController alloc]init];
    TravelJPLineModel *model = self.lineDataArray[indexPath.row];
    productVC.productID = model.product_id;
    productVC.gj_commission = model.gj_adult_rebate;
    
    TravelViewController *travelVC = (TravelViewController *)self.view.superview.viewController;
    [travelVC.navigationController pushViewController:productVC animated:YES];
    
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
