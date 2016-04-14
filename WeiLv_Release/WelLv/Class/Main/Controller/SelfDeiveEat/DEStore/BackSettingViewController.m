//
//  BackSettingViewController.m
//  WelLv
//
//  Created by liuxin on 15/11/10.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "BackSettingViewController.h"

@interface BackSettingViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UILabel *labeltext;
    NSMutableArray *_arr;
    
}
@property(nonatomic,strong)NSMutableArray *arr;
@end

@implementation BackSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // NSArray *arr1 = @[@"免扣款",@"扣款10%",@"扣款30%",@"扣款50%",@"扣款100%"];
    //arr = [NSMutableArray arrayWithObjects:@"免扣款",@"扣款10%",@"扣款30%",@"扣款50%",@"扣款100%", nil];
    self.navigationItem.title = @"扣款设置";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(consver)];
    self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);
    self.view.backgroundColor = BgViewColor;
    [self creatView];
    [self creatlabel];
    [self creatarr];
    [self creatPicker];
   
    // Do any additional setup after loading the view.
}
-(void)creatarr
{
    self.arr = [[NSMutableArray alloc] init];
    for (int i =0; i<=100; i++) {
        [self.arr addObject:[NSString stringWithFormat:@"%d",i]];
    }
}
-(void)creatPicker
{
    UIPickerView *pick = [[UIPickerView alloc] init];
    pick.frame = CGRectMake(windowContentWidth*0.25, 100, windowContentWidth*0.5, 150);
    pick.delegate= self;
    pick.dataSource = self;
    [self.view addSubview:pick];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(windowContentWidth*0.25+20, 75-10, 30, 20);
    label.text = @"%";
    label.font = [UIFont systemFontOfSize:17];
    [pick addSubview:label];
}

-(void)creatView
{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(15, 10, windowContentWidth-30, 50);
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 10, 80, 30);
    label.font = [UIFont systemFontOfSize:17];
    [view addSubview:label];
    labeltext = [[UILabel alloc] init];
    labeltext.text = @"0";
    labeltext.font = [UIFont systemFontOfSize:25];
    labeltext.textAlignment = NSTextAlignmentLeft;
    labeltext.font =[UIFont systemFontOfSize:20];
    labeltext.frame = CGRectMake(15+120, 5, 150, 40);
    [view addSubview:labeltext];
    label.text = @"当前设置";
    
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.arr.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.arr objectAtIndex:row];
}
-(void)select:(id)sender
{
    NSLog(@"++");
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
    labeltext.text = [NSString stringWithFormat:@"%@",[self.arr objectAtIndex:row]];
}
//-(void)creatView2
//{
//   
//    for (int i=0; i<arr.count; i++) {
//        UIView *view1 = [[UIView alloc] init];
//        view1.frame = CGRectMake(30, 100+10+i*60, windowContentWidth-60, 45);
//        view1.backgroundColor = [UIColor whiteColor];
//        UILabel *label2 = [[UILabel alloc] init];
//        label2.textAlignment = NSTextAlignmentLeft;
//        label2.text = arr[i];
//        label2.font = [UIFont systemFontOfSize:15];
//        label2.frame = CGRectMake(10, 10, 100, 30);
//        [view1 addSubview:label2];
//        UIButton *zxdBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//        zxdBtn.frame = CGRectMake(0, 0, windowContentWidth-60, 45);
//        zxdBtn.tag = 21+i;
//      //  zxdBtn.backgroundColor = [UIColor redColor];
//        [zxdBtn addTarget:self action:@selector(zxdbtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [view1 addSubview:zxdBtn];
//        [self.view addSubview:view1];
//    }
//    
//    
//}
//-(void)zxdbtnClick:(UIButton *)btn
//{
//    labeltext.text = arr[btn.tag-21];
//    NSLog(@"-----------%ld",btn.tag);
//}
-(void)creatlabel
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(50, 70, windowContentWidth-100, 30);
    label.text = @"提示:如不选择,默认为免扣款";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blueColor];
    [self.view addSubview:label];
}

-(void)consver
{
    //创建通知
    
    NSDictionary *dic = @{@"arrindex1":[NSString stringWithFormat:@"%ld",(long)self.arrindex1],@"arrindex2":[NSString stringWithFormat:@"%ld",(long)self.arrindex2],@"text":labeltext.text};
    NSNotification *notification = [NSNotification notificationWithName:@"ZxdTZ" object:nil userInfo:dic];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
