//
//  FriendlyMsgViewController.m
//  WelLv
//
//  Created by mac for csh on 15/11/25.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "FriendlyMsgViewController.h"

@interface FriendlyMsgViewController ()

@end

@implementation FriendlyMsgViewController
@synthesize arrayIndex;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BgViewColor;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(conserve)];
    self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);
    
    textV = [[CSHTextView1 alloc] initWithFrame:CGRectMake(0, 15, windowContentWidth, 100)];
    textV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textV];
}

-(void)conserve{
    if(!textV.contentView.text || [textV.contentView.text isEqualToString:@""] || textV.contentView.text == nil || [textV.contentView.text isEqualToString:@"(null)"] ){
        [[LXAlterView sharedMyTools]createTishi:@"请填写内容"];
    }else{
        //创建通知
        NSDictionary *dic = @{@"type":@"1",@"index":[NSString stringWithFormat:@"%ld",(long)self.arrayIndex],@"text":textV.contentView.text};
        NSNotification *notification =[NSNotification notificationWithName:@"OStongzhi" object:nil userInfo:dic];
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    }
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

@implementation CSHTextView1
@synthesize contentView = _contentView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self initView];
    }
    return self;
}
- (void)initView
{
    _contentView = [[UITextView alloc] initWithFrame:CGRectMake(Begin_X,  0, ViewWidth(self)-Begin_X*2, self.frame.size.height)];
    _contentView.delegate = self;
    _contentView.font = [UIFont systemFontOfSize:14];
    [self addSubview:_contentView];
    
    _placeholderLabel = [YXTools allocLabel:@"请填写详细地址..." font:systemFont(14) textColor:[UIColor grayColor] frame:CGRectMake(Begin_X+5, ViewY(_contentView)+5, ViewWidth(_contentView)-5, 20) textAlignment:0];
    
    [self addSubview:_placeholderLabel];
}

-(void)textViewDidChange:(UITextView *)textView
{
    NSString *content=textView.text;
    
    if (content.length > 0)
    {
        _placeholderLabel.hidden = YES;
        
    }
    else
    {
        _placeholderLabel.hidden = NO;
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    //  NSLog(@"1is%ld",textView.text.length);
    if ([text isEqualToString:@"\n"]){
        [_contentView resignFirstResponder];
        return NO;
    }
    
    return YES;
}
/*
 -(void)keyboardHide:(UITapGestureRecognizer*)tap{
 [mesTextView resignFirstResponder];
 }
 */
@end

