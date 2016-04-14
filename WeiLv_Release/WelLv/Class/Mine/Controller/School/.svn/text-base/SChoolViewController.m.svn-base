//
//  SChoolViewController.m
//  WelLv
//
//  Created by mac for csh on 15/9/1.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "SChoolViewController.h"
#import "detailViewController.h"

@interface SChoolViewController ()
{
    NSArray *sortArray;
   // NSArray *titleArray ;
}
@end

@implementation SChoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"管家学堂";
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.backgroundColor = BgViewColor;
    [self.view addSubview:_scrollView];
    
    [self initTitleArray];
}

-(void)initTitleArray{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:getSchoolSources parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject){
        
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        id arr = [dict objectForKeyedSubscript:@"result"];
        if ( arr && [arr isKindOfClass:[NSArray class]]) {
            sortArray = [dict objectForKeyedSubscript:@"result"];
            if (sortArray.count>0) {
                [self initView];
            }
        }else{
            [[LXAlterView sharedMyTools]createTishi:@"暂无数据"];
        }
        
    }failure:^(AFHTTPRequestOperation *operation,NSError *error){
        NSLog(@"error = %@",error);
    }];

}

-(void)initView{
    for (int i = 0; i< sortArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 45*i, ViewWidth(_scrollView), 45);
        button.tag = i;
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:button];
        
        UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 45*i + 10, 25, 25)];
        leftImageView.image = [UIImage imageNamed:[[sortArray objectAtIndex:i] objectForKey:@"name"]];
        [_scrollView addSubview:leftImageView];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(leftImageView) + ViewWidth(leftImageView) +10, 45*i , ViewWidth(_scrollView) - ViewX(leftImageView) - ViewWidth(leftImageView) -10, 45)];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.font = [UIFont systemFontOfSize:17];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.text = [[sortArray objectAtIndex:i] objectForKey:@"name"];
        [_scrollView addSubview:nameLabel];
        
        UIImageView *IGV = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(_scrollView) - 45, 7.5 + 45*i, 45, 30)];
        [IGV setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
        [_scrollView addSubview:IGV];
        
        if (i != sortArray.count-1) {
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 45*(i+1) -0.7, ViewWidth(_scrollView), 0.7)];
            lab.backgroundColor = bordColor;
            [_scrollView addSubview:lab];
        }
    }
}

-(void)click:(UIButton *)btn{
    detailViewController *detrailVC = [[detailViewController alloc] init];
    detrailVC.title = [[sortArray objectAtIndex:btn.tag] objectForKey:@"name"];
    detrailVC.idd = [[sortArray objectAtIndex:btn.tag] objectForKey:@"id"];
    [self.navigationController pushViewController:detrailVC animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
