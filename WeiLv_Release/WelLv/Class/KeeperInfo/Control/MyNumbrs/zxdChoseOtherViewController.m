//
//  zxdChoseOtherViewController.m
//  WelLv
//
//  Created by liuxin on 16/1/15.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "zxdChoseOtherViewController.h"

@interface zxdChoseOtherViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITextFieldDelegate,UITextViewDelegate>
@property(nonatomic,strong)NSMutableArray *arrImage1;//民族
@property(nonatomic,strong)NSMutableArray *arrImage2;//信仰

@property(nonatomic,strong)NSMutableArray *arrImage3;//家庭成员
@property(nonatomic,strong)UICollectionView *zxdCollectionView;
@property(nonatomic,strong)UITextField *zxdTextField;
@property(nonatomic,strong)UITextView *zxdTextView;
@end

@implementation zxdChoseOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTitle];
    [self creatViewInput];
    //[self creatArr];
   // [self creatView1];
   // [self creatView2];
    // Do any additional setup after loading the view.
}
-(void)creatViewInput
{
    if (self.type == 9) {
        self.zxdTextView = [[UITextView alloc] init];
        _zxdTextView.frame = CGRectMake(0, 15, windowContentWidth, 120);
        _zxdTextView.delegate = self;
        _zxdTextView.font = [UIFont systemFontOfSize:15];
        _zxdTextView.text = self.starString;
        [self.view addSubview:_zxdTextView];
          }
    else
    {
        self.zxdTextField = [[UITextField alloc] init];
        _zxdTextField.frame = CGRectMake(0, 15, windowContentWidth, 45);
        _zxdTextField.delegate = self;
        _zxdTextField.text = self.starString;
        _zxdTextField.backgroundColor = [UIColor whiteColor];
        _zxdTextField.textAlignment = NSTextAlignmentCenter;
        _zxdTextField.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:_zxdTextField];
        
    }
}
-(void)creatArr
{
    NSArray *arr1 = @[@"汉族",@"土家族",@"回族",@"白族",@"苗族",@"土族",@"维吾尔族",@"添加民族"];
    NSArray *arr2 = @[@"佛教",@"伊斯兰",@"道教",@"清真",@"基督",@"其他",@"添加信仰"];
    NSArray *arr3 = @[@"爸比",@"麻麻",@"爷爷",@"奶奶",@"舅舅",@"姥爷",@"姥姥",@"儿子",@"女儿",@"添加家庭成员"];
    self.arrImage1 = [[NSMutableArray alloc] initWithArray:arr1];
    self.arrImage2 = [[NSMutableArray alloc] initWithArray:arr2];
    self.arrImage3 = [[NSMutableArray alloc] initWithArray:arr3];
}
-(void)creatView1
{
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor whiteColor];
    view1.frame = CGRectMake(0, 15, windowContentWidth, 150);
    [self.view addSubview:view1];
}
-(void)creatView2
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(15, 175, windowContentWidth-15, 20);
    switch (self.type) {
        case 7:
        {
            label.text = @"其他民族";
        }
            break;
        case 8:
        {
            label.text = @"其他宗教信仰";
        }
            break;
        case 9:
        {
            label.text = @"其他家庭成员";
        }
            break;

        default:
            break;
    }
    [self.view addSubview:label];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize =  CGSizeMake(100, 30);
    self.zxdCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200, windowContentWidth, 260) collectionViewLayout:layout];
    self.zxdCollectionView.dataSource = self;
    self.zxdCollectionView.delegate = self;
    self.zxdCollectionView.backgroundColor = BgViewColor;
    [self.zxdCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"zxdCollectionViewCell"];
    [self.view addSubview:self.zxdCollectionView];

}
-(void)creatTitle
{
    self.view.backgroundColor = BgViewColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[YXTools stringToColor:@"#3c4042"]}];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tap.cancelsTouchesInView = NO;
    //设置为NO表示当前控件响应后会传播到其他控件上,默认为yes
    [self.view addGestureRecognizer:tap];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(doneClick)];
    self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);

}
//点击空白处收键盘
-(void)keyboardHide:(UITapGestureRecognizer *)tap
{
    
    if (self.type == 9) {
         [self.zxdTextView resignFirstResponder];
    }
    else
    {
        
        [self.zxdTextField resignFirstResponder];

    }
    
}
#pragma mark-----UIcollectionViewDataSoyrce delegate
//有多少分区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (self.type) {
        case 7:
        {
           return self.arrImage1.count;
        }
            break;
        case 8:
        {
            return self.arrImage2.count;
        }
            break;
        case 9:
        {
            return self.arrImage3.count;
        }
            break;
            
        default:
            return 0;
            break;
    }
    return 0;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"zxdCollectionViewCell";
    //从复用队列获取cell(需要提前注册)
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 80, 30);
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    switch (self.type) {
        case 7:
        {
            label.text = [NSString stringWithFormat:@"+%@",[self.arrImage1 objectAtIndex:indexPath.row]];
            //return self.arrImage1.count;
        }
            break;
        case 8:
        {
            label.text = [NSString stringWithFormat:@"+%@",[self.arrImage2 objectAtIndex:indexPath.row]];
           // return self.arrImage2.count;
        }
            break;
        case 9:
        {
            label.text = [NSString stringWithFormat:@"+%@",[self.arrImage3 objectAtIndex:indexPath.row]];
            //return self.arrImage3.count;
        }
            break;
            
        default:
            return 0;
            break;
    }

    
    [cell addSubview:label];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)zxdDelegate
{
    NSString *str = [NSString stringWithFormat:@"%@",@""];
    if (self.type == 9) {
        str = self.zxdTextView.text;
    }
    else
    {
        str = self.zxdTextField.text;
    }
    if ([self.delegate respondsToSelector:@selector(zxdViewController3:text:number:)]) {
        [self.delegate zxdViewController3:self text:str number:self.type];
    }
}
-(void)close
{
    //[self zxdDelegate];
    //[self zxdDownLoad];
    [super close];
}
-(void)doneClick
{
    switch (self.type) {
        case 9:
        {
            if (self.zxdTextView.text.length == 0) {
                [[LXAlterView sharedMyTools] createTishi:@"没有要保存的数据"];
                return;
            }
        }
            break;
            
        default:
        {
            if (self.zxdTextField.text.length == 0) {
                [[LXAlterView sharedMyTools] createTishi:@"没有要保存的数据"];
                return;
            }
        }
            break;
    }
    [self zxdDelegate];
    [self zxdDownLoad];
    
}
//上传数据
-(void)zxdDownLoad
{
     NSDictionary *dic = nil;
    switch (self.type) {
        case 7:
        {
            dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                    @"nation":[self judgeString:self.zxdTextField.text]?self.zxdTextField.text:@""};

        }
            break;
        case 8:
        {
            dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                    @"religiou":[self judgeString:self.zxdTextField.text]?self.zxdTextField.text:@""};

        }
            break;
        case 9:
        {
            dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                    @"family":[self judgeString:self.zxdTextView.text]?self.zxdTextView.text:@""};

        }
            break;
 
        default:
            dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                    @"nation":[self judgeString:self.zxdTextField.text]?self.zxdTextField.text:@""};
            break;
    }
    NSString *url = [NSString stringWithFormat:@"%@%@",WLHTTP,@"/api/assistant/edit_member_info"];
    NSDictionary *parameters = @{@"member_id":self.uid,
                                 @"data":[[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:dic]};
    __weak typeof (self)weakSelf = self;
    AFHTTPRequestOperationManager *zxdManager = [AFHTTPRequestOperationManager manager];
    zxdManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [zxdManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dict count]==0) {
            [[LXAlterView sharedMyTools] createTishi:@"保存失败"];
            
        }
        else if ([[dict objectForKey:@"status"] integerValue]!=1)
        {
            [[LXAlterView sharedMyTools] createTishi:@"保存失败"];
        }
        else
        {
            [super close];
            //NSDictionary *zxdDict = dict[@"msg"];
            // self.zxdDateDict = dict[@"data"];
            //                       [self.DateModel setValuesForKeysWithDictionary:<#(nonnull NSDictionary<NSString *,id> *)#>]
            //
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[LXAlterView sharedMyTools] createTishi:@"保存失败"];
    }];
    

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
