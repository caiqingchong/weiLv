//
//  ChangEducationalViewController.m
//  WelLv
//
//  Created by mac for csh on 15/7/17.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ChangEducationalViewController.h"

@interface ChangEducationalViewController ()

@end

@implementation ChangEducationalViewController
@synthesize eduString;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BgViewColor;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(conserve)];
    self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);
    
    //取本地数据
    infoDivtionary =[[NSMutableDictionary alloc]init];
    infoDivtionary =  [[[NSUserDefaults standardUserDefaults] objectForKey:AssitantData] mutableCopy];
    
    btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame=CGRectMake( 0, 10, [[UIScreen mainScreen] bounds].size.width, 40);
    NSString *strrrr = [self judgeReturnString:eduString withReplaceString:@"请选择"];
    [btn1 setTitle:strrrr forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor whiteColor]];
    [btn1 addTarget:self action:@selector(loadpicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    UIImageView *IGV = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth - 40, 6.65, 40, 26.7)];
    [IGV setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
    [btn1 addSubview:IGV];


}

-(void)loadpicker{
    names = [[NSArray alloc] initWithObjects:@"初中",@"高中",@"大专",@"本科",@"研究生", nil];
    picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 25, [[UIScreen mainScreen] bounds].size.width, 100)];
    picker.backgroundColor = [UIColor whiteColor];
    picker.delegate = self; picker.dataSource =self;
    pView= [[UIView alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-130-64, [[UIScreen mainScreen] bounds].size.width, 130)];
    pView.backgroundColor =[UIColor clearColor]; //[UIColor colorWithWhite:1 alpha:1];
    pView.hidden = NO;
    [pView addSubview:picker];
    [self.view addSubview:pView];
    if ([btn1.titleLabel.text isEqualToString:@"初中"]) {
        [picker selectRow:0 inComponent:0 animated:NO];
    }else if ([btn1.titleLabel.text isEqualToString:@"高中"]) {
        [picker selectRow:1 inComponent:0 animated:NO];
    }else if ([btn1.titleLabel.text isEqualToString:@"大专"]) {
        [picker selectRow:2 inComponent:0 animated:NO];
    }else if ([btn1.titleLabel.text isEqualToString:@"本科"]){
        [picker selectRow:3 inComponent:0 animated:NO];
    }else if ([btn1.titleLabel.text isEqualToString:@"研究生"]){
        [picker selectRow:4 inComponent:0 animated:NO];
    }else{
        [btn1 setTitle:@"初中" forState:UIControlStateNormal];
        [picker selectRow:0 inComponent:0 animated:NO];
    }


    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake( 0,0, windowContentWidth, 25)];
    lab.backgroundColor = [UIColor whiteColor];
    [pView addSubview:lab];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake( [[UIScreen mainScreen] bounds].size.width-40,1, 40, 25);
    [btn setTitle:@"确定" forState:UIControlStateNormal];
     btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    [pView addSubview:btn];
}

-(void)setting{
    pView.hidden = YES;
}

//保存
-(void)conserve{
    
    if(![btn1.titleLabel.text isEqualToString:@"请选择"]){
        //上传服务器
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSDictionary *infodic = @{@"education_background":btn1.titleLabel.text};
        
        NSDictionary *parameters = @{@"assistant_id":[infoDivtionary objectForKey:@"id"],@"data":[self dictionaryToJson:infodic]};
        [manager POST:GJManageSelfInfoUrl parameters:parameters
              success:^(AFHTTPRequestOperation *operation,id responseObject) {
                  NSString *html = operation.responseString;
                  NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
                  NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
                  if([[dict objectForKey:@"status"]integerValue] == 1){
                      [[LXAlterView sharedMyTools] createTishi:@"操作成功"];
                      // 2、cun 村本地
                      [infoDivtionary setValue:btn1.titleLabel.text forKey:@"education_background"];
                      
                      [[NSUserDefaults standardUserDefaults] setObject:infoDivtionary forKey:AssitantData];
                      //3、修改成功返回上个页面
                      [self.navigationController popViewControllerAnimated:YES];
                  }
                  
              }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
                  
                  NSLog(@"Error: %@", error);
                  [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
              }];
        
    }else{
        [[LXAlterView alloc] createTishi:@"请选择学历"];
    }
    
}

//字典数据转Json
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}


#pragma mark -
#pragma mark UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UIView *v=[[UIView alloc]
               initWithFrame:CGRectMake(0,0,
                                        [self pickerView:pickerView widthForComponent:component],
                                        [self pickerView:pickerView rowHeightForComponent:component])];
    [v setOpaque:TRUE];
    [v setBackgroundColor:[UIColor clearColor]];
    UILabel *lbl=nil;
    lbl= [[UILabel alloc]
          initWithFrame:CGRectMake(8,0,
                                   [self pickerView:pickerView widthForComponent:component]-16,
                                   [self pickerView:pickerView rowHeightForComponent:component])];
    lbl.textAlignment = NSTextAlignmentCenter;
    [lbl setBackgroundColor:[UIColor clearColor]];
    NSString *ret=@"";
    
    switch (component) {
        case 0:
            ret=[names objectAtIndex:row];
            break;
    }
    [lbl setText:ret];
    [lbl setFont:[UIFont boldSystemFontOfSize:18]];
    [v addSubview:lbl];
    return v;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [btn1 setTitle:[names objectAtIndex:row] forState:UIControlStateNormal];
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 200;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 25;
}

#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return names.count;
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
