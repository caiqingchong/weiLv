//
//  zxdLockFourViewController.m
//  WelLv
//
//  Created by liuxin on 16/1/29.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "zxdLockFourViewController.h"

@interface zxdLockFourViewController ()<UITextViewDelegate>
@property(nonatomic,strong)UITextView *zxdTextView;
@end

@implementation zxdLockFourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTitle];
    [self creatView1];
    // Do any additional setup after loading the view.
}
-(void)creatTitle
{
    self.view.backgroundColor = BgViewColor;
    switch (self.type) {
        case 5:
        {
          self.navigationItem.title = @"毕业院校";
        }
            break;
        case 9:
        {
             self.navigationItem.title = @"家庭成员";
        }
            break;
        case 10:
        {
            self.navigationItem.title = @"出境记录";
        }
            break;
        case 12:
        {
            self.navigationItem.title = @"忌口";
        }
            break;
        default:
            break;
    }
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[YXTools stringToColor:@"#3c4042"]}];
    //确定按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(doneClick)];
    self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);
        //取消按钮
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(BackClick)];
    //    self.navigationItem.leftBarButtonItem.tintColor = kColor(255, 165, 98);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tap.cancelsTouchesInView = NO;
    //设置为NO表示当前控件响应后会传播到其他控件上,默认为yes
    [self.view addGestureRecognizer:tap];
    
}
//点击空白处收键盘
-(void)keyboardHide:(UITapGestureRecognizer *)tap
{
    
    [self.zxdTextView resignFirstResponder];
    
}

-(void)doneClick
{
    if (self.zxdTextView.text.length == 0) {
        [[LXAlterView sharedMyTools] createTishi:@"保存的内容为空"];
    }
    else
    {
        [self zxdChangeData];
    }
}
-(void)zxdChangeData
{
    NSDictionary *dic = nil;
    switch (self.type) {
        case 5:
        {
            dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                    @"info_school":self.zxdTextView.text};

        }
            break;
        case 9:
        {
            dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                    @"family":self.zxdTextView.text};
        }
            break;
        case 10:
        {
            dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                    @"exit_log":self.zxdTextView.text};

        }
            break;
        case 12:
        {
            dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                    @"diet_taboo":self.zxdTextView.text};
        }
            break;
        default:
           [[LXAlterView sharedMyTools] createTishi:@"保存失败"];
            return;
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
            if ([weakSelf.delegate respondsToSelector:@selector(zxdViewController5:text:number:)]) {
                [weakSelf.delegate zxdViewController5:weakSelf text:weakSelf.zxdTextView.text number:weakSelf.type];
                            }
            [self.navigationController popViewControllerAnimated:YES];
            //NSDictionary *zxdDict = dict[@"msg"];
            // self.zxdDateDict = dict[@"data"];
            //                       [self.DateModel setValuesForKeysWithDictionary:<#(nonnull NSDictionary<NSString *,id> *)#>]
            //
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    


}
-(void)close
{
    [super close];
}
-(void)creatView1
{
    self.zxdTextView = [[UITextView alloc] init];
    _zxdTextView.frame = CGRectMake(0, 15, windowContentWidth, 120);
    _zxdTextView.text = self.starString;
    _zxdTextView.delegate= self;
    
    self.zxdTextView.textAlignment = NSTextAlignmentCenter;
    self.zxdTextView.font = [UIFont systemFontOfSize:17];
    _zxdTextView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_zxdTextView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-----限制字数
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSInteger longString;
    if (self.type == 5) {
        longString = 20;
    }
    else
    {
       longString = 40;
    }
    NSString *newString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger res = longString -[newString length];
    if (res >=0) {
        return  YES;
    }
    else
    {
        NSRange rg = {0,[text length]+res};
        if (rg.length>0) {
            NSString *s = [text substringWithRange:rg];
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        [[LXAlterView sharedMyTools] createTishi:[NSString stringWithFormat:@"最长只能输入%ld个",longString]];
        return  NO;
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
