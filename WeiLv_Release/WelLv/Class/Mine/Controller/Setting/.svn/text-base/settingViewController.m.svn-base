//
//  settingViewController.m
//  WelLv
//
//  Created by mac for csh on 15/4/16.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "settingViewController.h"

@interface settingViewController ()

@end

@implementation settingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BgViewColor;
    
    [self.navigationItem setTitle:@"设置"];
   /* UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 35, 25);
    [btn setBackgroundImage:[UIImage imageNamed:@"圆角矩形-65-拷贝.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(getBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    */
    UIButton *zjButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 15, [[UIScreen mainScreen] bounds].size.width, 40)];
    [zjButton setTitle:@"清空缓存" forState:UIControlStateNormal];
    zjButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [zjButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    zjButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [zjButton setBackgroundColor:[UIColor whiteColor]];
    [zjButton addTarget:self action:@selector(clean) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zjButton];
    
    UIImageView *igview = [[UIImageView alloc] initWithFrame:CGRectMake(20+5, 40/2 - 20/2, 20 , 20)];
    igview.image = [UIImage imageNamed:@"清除@2x.png"];
    [zjButton addSubview:igview];
    
    UIImageView *IGV = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth - 40, 6.67, 40, 26.7)];
    [IGV setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
    [zjButton addSubview:IGV];
}

-(void)clean{
    //NSLog(@"clearCache");
    
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
   // NSLog(@"files :%lu",(unsigned long)[files count]);
    for (NSString *p in files) {
        NSError *error;
        NSString *path = [cachPath stringByAppendingPathComponent:p];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        }
    }
   [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];
  /*   UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:@"缓存清除成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [al show];*/
}

-(void)clearCacheSuccess
{
    UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:@"缓存清除成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [al show];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getBack{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
