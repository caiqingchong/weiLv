//
//  ChangeBornDayViewController.m
//  WelLv
//
//  Created by mac for csh on 15/7/17.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ChangeBornDayViewController.h"
#import "LXUserTool.h"
#import "AFNetworking.h"

@interface ChangeBornDayViewController (){
    DateView *dateView;
}

@end

@implementation ChangeBornDayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BgViewColor;
    
    //[self.navigationItem setTitle:@"修改出生日期"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(conserve)];
    self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);
    
    //取本地数据
    infoDivtionary =[[NSMutableDictionary alloc]init];
    infoDivtionary =  [[[NSUserDefaults standardUserDefaults] objectForKey:AssitantData] mutableCopy];
    
    btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame=CGRectMake( 0, 10, [[UIScreen mainScreen] bounds].size.width, 40);
    [btn1 setTitle:@"请选择" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor whiteColor]];
    [btn1 addTarget:self action:@selector(loadpicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    UIImageView *IGV = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth - 40, 6.65, 40, 26.7)];
    [IGV setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
    [btn1 addSubview:IGV];
    
}

-(void)loadpicker{
    if (dateView) {
        [dateView removeFromSuperview];
    }
    dateView =[[DateView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-220, self.view.frame.size.width, 220)];
    dateView.g_delegate=self;
    [self.view addSubview:dateView];
    dateView.hidden = NO;
    
}

//代理方法
-(void)sendDateToSup:(NSString *)date
{
    [btn1 setTitle:date forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getBack{
    [self.navigationController popViewControllerAnimated:YES];
}

//保存
-(void)conserve{
    
    if(![btn1.titleLabel.text isEqualToString:@"请选择"]){
        //上传服务器
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
         NSDictionary *infodic = @{@"birth_date":btn1.titleLabel.text};
        
        NSDictionary *parameters = @{@"assistant_id":[infoDivtionary objectForKey:@"id"],@"data":[self dictionaryToJson:infodic]};
        [manager POST:GJManageSelfInfoUrl parameters:parameters
              success:^(AFHTTPRequestOperation *operation,id responseObject) {
                  NSString *html = operation.responseString;
                  NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
                  NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
                  if([[dict objectForKey:@"status"]integerValue] == 1){
                      [[LXAlterView sharedMyTools] createTishi:@"操作成功"];
                      // 2、cun 村本地
                      [infoDivtionary setValue:btn1.titleLabel.text forKey:@"birth_date"];
                      
                      [[NSUserDefaults standardUserDefaults] setObject:infoDivtionary forKey:AssitantData];
                      //3、修改成功返回上个页面
                      [self.navigationController popViewControllerAnimated:YES];
                  }
                  
              }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
                  
                  NSLog(@"Error: %@", error);
                  [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
              }];

    }else{
        [[LXAlterView alloc] createTishi:@"请选择出生日期"];
    }
    
}

//字典数据转Json
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
