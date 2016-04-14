//
//  photoViewController.m
//  WelLv
//
//  Created by liuxin on 15/11/14.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "photoViewController.h"

@interface photoViewController ()<UIScrollViewDelegate>

@end

@implementation photoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationItem.title = @"查看图片";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatPv];
        // Do any additional setup after loading the view.
}
-(void)creatPv
{
    //获取图片
    //获取屏幕大小
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    //创建UIScrollView
    UIScrollView *mainScrollview = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    //设置内容尺寸
    mainScrollview.contentSize = CGSizeMake(screenSize.width*self.arrimagepv.count, screenSize.height);
    //设置滚动视图按页显示
    mainScrollview.pagingEnabled = YES;
    //关闭弹簧效果
    mainScrollview.bounces = NO;
    //设置滚动视图代理
    mainScrollview.delegate = self;
    [self.view addSubview:mainScrollview];
    int i =0;
    for (UIImage *imagePv in self.arrimagepv) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*screenSize.width, 0, screenSize.width, screenSize.height-100)];
        imageView.image = imagePv;
        //添加图片视图到滚动视图
        [mainScrollview addSubview:imageView];
        i++;
    }
    //选中哪张图片就显示
    mainScrollview.contentOffset = CGPointMake(self.index*screenSize.width, 0);
    //设置视图控制器的标题
    self.title = [NSString stringWithFormat:@"%ld/%ld",self.index+1,self.arrimagepv.count];
}
//减速结束,计算当前页
#pragma mark -UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index1 = scrollView.contentOffset.x/self.view.bounds.size.width;
    self.title = [NSString stringWithFormat:@"%ld/%ld",index1+1,self.arrimagepv.count];
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
