//
//  changeBirDayViewController.m
//  WelLv
//
//  Created by mac for csh on 15/4/15.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "changeBirDayViewController.h"
#import "LXUserTool.h"
#import "AFNetworking.h"

@interface changeBirDayViewController (){
    DateView *dateView;
}

@end

@implementation changeBirDayViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BgViewColor;
    
    [self.navigationItem setTitle:@"修改出生日期"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(conserve)];
    self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);
    
    
    btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame=CGRectMake( 0, 10, [[UIScreen mainScreen] bounds].size.width, 40);
    [btn1 setTitle:@"请选择" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor whiteColor]];
    [btn1 addTarget:self action:@selector(loadpicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    UIImageView *IGV = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth - 45, 6.65, 40, 26.7)];
    [IGV setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
    [btn1 addSubview:IGV];
    
    NSString *datestr = [[LXUserTool alloc] getBirthday];
    if ([self judgeString:datestr] == YES) {
        [btn1 setTitle:datestr forState:UIControlStateNormal];
    }

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
        
        NSDictionary *parameters = @{@"uid":[[LXUserTool alloc] getUid],@"birthday":btn1.titleLabel.text};
        
        [manager POST:UpdateUserInfo parameters:parameters
         
              success:^(AFHTTPRequestOperation *operation,id responseObject) {
                  NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
                  [settings setObject:btn1.titleLabel.text forKey:@"birthday"];
                  [[LXAlterView alloc] createTishi:@"修改成功"];
                  [self.navigationController popViewControllerAnimated:YES];
                  
              }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
                  
                  NSLog(@"Error: %@", error);
                  
              }];

    }else{
         [[LXAlterView alloc] createTishi:@"请选择出生日期"];
    }
   
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
