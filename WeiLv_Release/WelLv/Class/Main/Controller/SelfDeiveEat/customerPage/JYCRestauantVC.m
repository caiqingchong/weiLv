//
//  JYCRestauantVC.m
//  WelLv
//
//  Created by lyx on 15/11/11.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "JYCRestauantVC.h"
#import "JYCLeftView.h"
#import "JYCRightView.h"
#import "JYCOrderVC.h"
#import "JYCDishDetailVC.h"
#import "OpenTimeViewController.h"
#import "JYCCustomerTicket.h"
#import "JYCorderStateVC.h"
#import "JYCcurrentPosition.h"
@interface JYCRestauantVC ()<UIScrollViewDelegate,UIActionSheetDelegate,clickRightBtndelegate>
{
    UIView *chooessLine;
    
    UIButton *searchBtn;
    JYCRightView *rightView;
    JYCLeftView *leftView;
    NSString *chuStr;
}

@property(nonatomic,strong)UIView *chooseView;
@property (nonatomic, strong) UIButton *tempBut;
@property(nonatomic,strong)UIScrollView *scrollView;



@end





@implementation JYCRestauantVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    if (self.type==1) {
        chuStr=self.model.userid;
    }else if (self.type==2)
    {
        chuStr=[[WLSingletonClass defaultWLSingleton]wlDEShopID];
       
    }
    
    searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.hidden=YES;
    searchBtn.frame=CGRectMake(0, 0, 17, 22);
    [searchBtn setImage:[UIImage imageNamed:@"6服务电话"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    [self initTopView];
    self.scrollView= [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, windowContentWidth, windowContentHeight-64-40)];
    self.scrollView.delegate=self;
    [self.view addSubview:self.scrollView];
    [self createScrollView];
   
}
-(void)searchBtnClick
{

   
  UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"咨询店家" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"手机" otherButtonTitles:nil, nil];

    [actionsheet showInView:self.view];
    
}
#pragma mark  UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUserDefaults * telSets = [NSUserDefaults standardUserDefaults];
    
    NSString *str=[telSets objectForKey:@"main_phone"];
    NSLog(@"%@",str);
    
    if (buttonIndex == 0){
        NSString * telString = [NSString stringWithFormat:@"tel:%@", str];
        NSURL * telUrl = [NSURL URLWithString:telString];
        [[UIApplication sharedApplication] openURL:telUrl];

    }
        
   }
-(void)initTopView
{
    self.chooseView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, 40)];
    self.chooseView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.chooseView];
    NSArray * chooseTitleArr = @[@"商品", @"店家信息"];
    
    for (int i = 0; i < chooseTitleArr.count; i++) {
        UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i==0) {
            but.frame = CGRectMake(60, 0, 80, ViewHeight(self.chooseView));
            [but setTitle:[chooseTitleArr objectAtIndex:i] forState:UIControlStateNormal];
            [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [but addTarget:self action:@selector(chooseBut:) forControlEvents:UIControlEventTouchUpInside];
            but.tag=101+i;
            but.backgroundColor = [UIColor whiteColor];
            [but setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            self.tempBut = but;
        }else if(i==1){
            but.frame = CGRectMake(ViewWidth(self.chooseView)-60-80, 0, 80, ViewHeight(self.chooseView));
            [but setTitle:[chooseTitleArr objectAtIndex:i] forState:UIControlStateNormal];
            [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [but addTarget:self action:@selector(chooseBut:) forControlEvents:UIControlEventTouchUpInside];
            but.tag=101+i;
            but.backgroundColor = [UIColor whiteColor];
        }
        [self.chooseView addSubview:but];
        
    }
    chooessLine = [[UIView alloc] initWithFrame:CGRectMake(60, 40 - 2.5, 80, 2)];
    chooessLine.backgroundColor = [UIColor orangeColor];
    UIView *botomLine=[[UIView alloc]initWithFrame:CGRectMake(0, 40-1, windowContentWidth, 1)];
    botomLine.backgroundColor=bordColor;
    [self.chooseView addSubview:chooessLine];
    [self.chooseView addSubview:botomLine];

}

- (void)chooseBut:(UIButton *)button{
    if (self.tempBut==button) {
        return;
    }
    if (button.tag==101) {
        searchBtn.hidden=YES;
    }else
        searchBtn.hidden=NO;
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width*(button.tag-101), 0)animated:YES];
    
    chooessLine.frame = CGRectMake(ViewX(button), ViewHeight(self.chooseView) - 2.5, ViewWidth(button), 2);
    
    if (![button isEqual:self.tempBut]){
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self.tempBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    self.tempBut = button;
}

-(void)createScrollView
{
    
    
    leftView=[[JYCLeftView alloc]initWithFrame:CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) with:chuStr];
    leftView.delegate=self;
   
    
    [self.scrollView addSubview:leftView];
    rightView=[[JYCRightView alloc]initWithFrame:CGRectMake(self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)with:chuStr];
    rightView.delegate=self;
    [self.scrollView addSubview:rightView];

   [self.scrollView  setContentSize:CGSizeMake(2*self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
   [self.scrollView setBounces:NO];
   [self.scrollView setPagingEnabled:YES];
   [self.scrollView setShowsHorizontalScrollIndicator:NO];
   [self.scrollView setShowsVerticalScrollIndicator:NO];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float tmp = self.scrollView.contentOffset.x/self.scrollView.frame.size.width;
    
    UIButton *btn1 = (UIButton *)[self.chooseView viewWithTag:101+tmp];
    btn1.selected=YES;
    [btn1 setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    UIButton *btn2=(UIButton *)[self.chooseView viewWithTag:102-tmp];
    btn2.selected=NO;
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    chooessLine.frame = CGRectMake(ViewX(btn1), ViewHeight(self.chooseView) - 2.5, ViewWidth(btn1), 2);
    self.tempBut=btn1;
    
   
}
-(void)didSelectToPresent:(NSMutableDictionary *)dict{
    
    JYCDishDetailVC *VC=[[JYCDishDetailVC alloc]init];;
   
    VC.modalTransitionStyle=0;
    VC.model=dict[@1];
    VC.cell=dict[@2];
    VC.arr=dict[@3];
    //VC.model=model;
   // VC.cell=ceell;
  
   [self.navigationController pushViewController:VC animated:YES];
 
}
-(void)clickPush:(NSDictionary *)dict
{
    JYCcurrentPosition *jycPosition=[[JYCcurrentPosition alloc]init];
    jycPosition.latitude=[dict[@"1"] floatValue];
    jycPosition.longitude=[dict[@"2"]floatValue];
    self.navigationController.navigationBarHidden=YES;
    [self.navigationController pushViewController:jycPosition animated:YES];
}


-(void)clickToPush:(NSMutableArray *)arr
{
    
    JYCOrderVC *vc=[[JYCOrderVC alloc]init];
    vc.arr=arr;
    vc.type=1;
    vc.title=self.title;
    [self.navigationController pushViewController:vc animated:YES];
    
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
