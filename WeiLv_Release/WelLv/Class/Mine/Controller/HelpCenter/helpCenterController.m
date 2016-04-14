//
//  helpCenterController.m
//  WelLv
//
//  Created by mac for csh on 15/4/23.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "helpCenterController.h"

#define ImageHeight 0;
@interface helpCenterController ()
{
    UIScrollView *_scrollView;
    
    NSArray *questionArr ;
    NSArray *answerArr ;
}

@end

@implementation helpCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"帮助中心"];
    
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.delegate = self;
        [self.view addSubview:_scrollView];
        _scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 1000);
        
       /* UIImageView *igview = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,150)];
        [igview setImage:[UIImage imageNamed:@"00@2x.png"]] ;
        [_scrollView addSubview:igview];*/
        
        
        NSString* plistPath=[[NSBundle mainBundle] pathForResource:@"helpCenter" ofType:@"plist"];
        NSDictionary *dict=[[NSDictionary alloc] initWithContentsOfFile:plistPath];
        questionArr = [[NSArray alloc] initWithArray:[dict objectForKey:@"question"]];
        answerArr = [[NSArray alloc] initWithArray:[dict objectForKeyedSubscript:@"answer"]];
        [self loadtheView];
    }
}

-(void)loadtheView{
     float y = ImageHeight;
    y = y+20;
    for (int i = 0; i < [questionArr count]; i ++) {
        UILabel *quesLabel= [[UILabel alloc] initWithFrame:CGRectMake(10, y, [[UIScreen mainScreen] bounds].size.width-20,  20)];
        [quesLabel setText:[questionArr objectAtIndex:i]];
        [quesLabel setTextAlignment:NSTextAlignmentLeft];
        quesLabel.textColor = [UIColor blackColor];
        quesLabel.font = [UIFont systemFontOfSize:15];
        [quesLabel setNumberOfLines:0];
        [quesLabel sizeToFit];
        y = y + quesLabel.frame.size.height+10;
        [_scrollView addSubview:quesLabel];
        
        UILabel *ansLabel= [[UILabel alloc] initWithFrame:CGRectMake(30, y, [[UIScreen mainScreen] bounds].size.width-20-30,  20)];
        [ansLabel setText:[answerArr objectAtIndex:i]];
        [ansLabel setTextAlignment:NSTextAlignmentLeft];
        [ansLabel setTextColor:[UIColor grayColor]];
        ansLabel.font = [UIFont systemFontOfSize:12];
        [ansLabel setNumberOfLines:0];
        [ansLabel sizeToFit];
        y = y + ansLabel.frame.size.height+15;
        [_scrollView addSubview:ansLabel];
        
      /*  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineSpacing = 4;
        
        NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:12], NSParagraphStyleAttributeName:paragraphStyle};
        ansLabel.attributedText = [[NSAttributedString alloc]initWithString:ansLabel.text attributes:attributes];
*/
    }
    _scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, y+70);
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
