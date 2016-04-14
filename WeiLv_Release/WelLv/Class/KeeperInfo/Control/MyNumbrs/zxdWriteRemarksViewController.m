//
//  zxdWriteRemarksViewController.m
//  WelLv
//
//  Created by liuxin on 16/1/19.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "zxdWriteRemarksViewController.h"
#import "MBProgressHUD.h"
#import "zxdMemberModel.h"
@interface zxdWriteRemarksViewController ()<UITextViewDelegate>
@property(nonatomic,strong)UITextView *zxdTextView;
@property(nonatomic,strong) MBProgressHUD *zxdHud;
@property(nonatomic,strong)NSMutableArray *zxdBackArr;
@property(nonatomic,strong)UILabel *zxdLabel;
@end

@implementation zxdWriteRemarksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTitle];
    [self creatView1];
    // Do any additional setup after loading the view.
}
-(void)creatTitle
{
    self.view.backgroundColor = BgViewColor;
    self.navigationItem.title = @"编辑备注";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[YXTools stringToColor:@"#3c4042"]}];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(zxdConserveright)];
    self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zxdtapSH:)];
    [self.view addGestureRecognizer:singleTap];

    
}
-(void)creatView1
{
    [self.zxdTextView removeFromSuperview];
    self.zxdTextView = [[UITextView alloc] init];
    self.zxdTextView.frame = CGRectMake(15, 15,windowContentWidth-30 , 200);
    self.zxdTextView.delegate = self;
    self.zxdTextView.font = [UIFont systemFontOfSize:17];
    self.zxdLabel = [[UILabel alloc] init];
    self.zxdLabel.frame = CGRectMake(windowContentWidth/2-60, 50, windowContentWidth-120, 50);
    self.zxdLabel.textColor = [UIColor grayColor];
    self.zxdLabel.text = @"请输入编辑信息";
    [self.zxdTextView addSubview:self.zxdLabel];
    [self.view addSubview:self.zxdTextView];
}
-(void)zxdConserveright
{
    [self zxdData];
}
-(void)zxdtapSH:(UITapGestureRecognizer *)tapClick
{
    [self.zxdTextView resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)zxdData
{
    if (self.zxdTextView.text.length == 0 ) {
        [[LXAlterView sharedMyTools] createTishi:@"亲,没有可以保存的信息"];
        return;
    }
    NSDictionary *parameters = @{@"member_id":self.uid,
                                 @"assistant_id":self.assId,
                                 @"tag":self.zxdTextView.text,
                                 };
    [self setHud:@"正在保存"];
    __weak typeof (self)weakSelf = self;
    AFHTTPRequestOperationManager *zxdManager = [AFHTTPRequestOperationManager manager];
    zxdManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [zxdManager POST:zxdAddMemberUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
         weakSelf.zxdHud.hidden = YES;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dict[@"status"] integerValue] == 1) {
            [[LXAlterView sharedMyTools] createTishi:@"保存成功"];
            NSArray *arrItem = dict[@"data"];
            weakSelf.zxdBackArr = [[NSMutableArray alloc] init];
            for (NSDictionary *itemDict in arrItem) {
                zxdMemberModel *model = [[zxdMemberModel alloc] init];
                [model setValuesForKeysWithDictionary:itemDict];
                NSMutableArray *arrSection = [[NSMutableArray alloc] init];
                [arrSection addObject:model];
                [weakSelf.zxdBackArr addObject:arrSection];
            }
            if ([weakSelf.delegate respondsToSelector:@selector(viewController:text:zxddate:isChange:)]) {
                [weakSelf.delegate viewController:weakSelf text:nil zxddate:self.zxdBackArr isChange:1];
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
        else{
            [[LXAlterView sharedMyTools] createTishi:@"保存失败"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        weakSelf.zxdHud.hidden = YES;
        [[LXAlterView sharedMyTools] createTishi:@"保存失败"];
    }];
}
-(void)setHud:(NSString *)str
{
    
    self.zxdHud = [[MBProgressHUD alloc] initWithView:self.view];
    self.zxdHud.frame = self.view.bounds;
    self.zxdHud.minSize = CGSizeMake(100, 100);
    self.zxdHud.mode = MBProgressHUDModeIndeterminate;
    self.zxdHud.labelText = str;
    [self.view addSubview:self.zxdHud];
    // [_zxdTableView bringSubviewToFront:self.zxdHud];
    [self.zxdHud show:YES];
}
#pragma mark-----限制字数
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSInteger longString = 200;
   
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
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.zxdTextView becomeFirstResponder];
    self.zxdLabel.hidden = YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (self.zxdTextView.text.length == 0) {
        self.zxdLabel.hidden = NO;
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
