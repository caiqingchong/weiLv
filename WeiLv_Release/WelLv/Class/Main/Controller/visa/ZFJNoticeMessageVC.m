//
//  ZFJNoticeMessageVC.m
//  WelLv
//
//  Created by 张发杰 on 15/4/16.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJNoticeMessageVC.h"

@interface ZFJNoticeMessageVC ()
@property (nonatomic, strong) NSAttributedString *attrStr;

@property (nonatomic, strong) UIScrollView *textScrollView;
@property (nonatomic, strong) UILabel * textLabel;

@property (nonatomic, copy) NSString *htmlString;


@end

@implementation ZFJNoticeMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleString;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addTextView];
    
   
    // Do any additional setup after loading the view.
}

- (void)addTextView
{
    
    NSString * str = @"\n1.签证属于特殊商品，公司会按照使领馆的要求为客人准备最合适的送签材料，确保您的材料有最高出签可能，但是您所申请的签证是否成功，是取决于使领馆对您资料的审核，若发生拒签，请申请人自然接受结果，同时放弃追究本公司任何责任的权利。\n\n2.我司在收取申请人资料后，经二次审核发现不符合签证申请资格的，保留作出不予受理申请人签证申请决定的权利。\n\n3.申请人需要保证提供的材料的真实性，完整性，有效性，如因隐瞒曾有不良记录，或从事非法活动，被相关部门查处或有滞留倾向拒签，我司不承担责任。请申请人特别注意诚实信用的原则。\n\n4.办签证前请客人自留护照信息，以备签证期间订机票等之用。\n\n5.如果您的护照在办理过程中丢失，公司每本赔付1000元\n\n6.订单生效后如欲中途取消签证申请，则在已经将您的签证申请送交使领馆的情况下，您已经支付的订单款项将不予退还。\n\n7.加入贴签是为了加快使馆分拣护照，如给您带来不便请您谅解。我们选取了最容易撕启的标签，您可以轻易撕启。\n\n8.重要提醒 ：在办理签证期间，护照持有人未在中华人民共和国境内(即不在中国大陆）或办理人所要办理的国家（地区）签证在有效期内、签证逾期未进行签证注销、没有出入境章（和出入境记录）的情形下，我公司一律不予办理，如遇此情况我们将提交有关部门处理，敬请见谅。\n\n\n\n\n\n\n\n\n";
    
    NSString *questionStr = @"<p class=MsoNormal><b><span style=font-size:12.0pt;font-family:微软雅黑;color:red;>Q</span></b><b><span style=font-size:12.0pt;font-family:微软雅黑;color:red;>：</span></b><b><span style=font-size:12.0pt;font-family:微软雅黑;>什么是签证？</span></b><span style=font-size:12.0pt;font-family:微软雅黑;></span></p><p class=MsoNormal><b><span style=font-size:12.0pt;font-family:微软雅黑;color:#385623;>A</span></b><b><span style=font-size:12.0pt;font-family:微软雅黑;color:#385623;>：</span></b><span style=font-size:11.5pt;font-family:微软雅黑;>签证是一个国家的主权机关在本国或外国公民所持的护照或其他旅行证件上的签注、盖印，以表示允许其出入本国国境或者经过国境的手续，也可以说是颁发给他们的一项签注式的证明。签证是一个主权国家为维护本国主权、尊严、安全和利益而采取的一项措施，是一个主权国家实施出入本国国境管理的一项重要手段。一个国家的公民如果希望到其他国家旅行、定居、商贸、留学等，除必须拥有本人的有效护照或旅行证件外，另一个必备的条件，就是必须获得前往国家的签证。<span></span></span></p><p class=MsoNormal><b><span style=font-size:12.0pt;font-family:微软雅黑;color:red;>Q</span></b><b><span style=font-size:12.0pt;font-family:微软雅黑;color:red;>：</span></b><b><span style=font-size:12.0pt;font-family:微软雅黑;>什么是领区范围？</span></b><span style=font-size:12.0pt;font-family:微软雅黑;></span></p><p class=MsoNormal><b><span style=font-size:12.0pt;font-family:微软雅黑;color:#385623;>A</span></b><b><span style=font-size:12.0pt;font-family:微软雅黑;color:#385623;>：</span></b><span style=font-size:11.0pt;font-family:微软雅黑;>同我国有正式外交关系的国家，基本都在北京设有大使馆。但中国幅员广阔，人口众多，在北京的大使馆很难顾及到全国各个地方。这样为管理方便，就在各地区性的中心城市开设领事馆。领事馆主要在所辖地区行使大使馆的签证领事功能。申请签证，一般应在其居住地所属的大使馆或领事馆申请，跨领区通常不允许。这里需要说明的是：居住地和我们所说的户口所在地是有区别的。外国人一般没有户口的概念，只有长住地的概念。一个持有上海户口的人，长期住在北京，如果申请美国签证，应该是在北京申请。但申请人需出示在京居住的证据，比如暂住证、工作单位的证明等。<span></span></span></p><p class=MsoNormal><b><span style=font-size:12.0pt;font-family:微软雅黑;color:red;>Q</span></b><b><span style=font-size:12.0pt;font-family:微软雅黑;color:red;>：</span></b><b><span style=font-size:12.0pt;font-family:微软雅黑;>签证的有效期及停留期</span></b><span style=font-size:12.0pt;font-family:微软雅黑;></span></p><p class=MsoNormal><b><span style=font-size:12.0pt;font-family:微软雅黑;color:#385623;>A</span></b><b><span style=font-size:12.0pt;font-family:微软雅黑;color:#385623;>：</span></b><span style=font-size:11.0pt;font-family:微软雅黑;>1</span><span style=font-size:11.0pt;font-family:微软雅黑;>）签证有效期，是指签证的使用期限，即签证在特定的时间段内有超过了这段时间，签证也就无效了。所以，对于申请某国<span>(</span>地区<span>)</span>签证的申请人来讲，必须在获得签证后，牢记住该签证的有效期，并在该有效期内抵达目的地。一般国家的签证基本上是在<span>3</span>个月内的任何一天抵达都有效。所以，申请人取得签证后，一定要向签发签证的官员询问清楚。<span></span></span></p><p class=MsoNormal><span style=font-size:11.0pt;font-family:微软雅黑;>2</span><span style=font-size:11.0pt;font-family:微软雅黑;>） 有效期的表达方式：世界上各个国家表达签证有效期的方式各有不同：<span></span></span></p><p class=MsoNormal><span style=font-size:11.0pt;font-family:微软雅黑;>A</span><span style=font-size:11.0pt;font-family:微软雅黑;>、 用“有效期至”；<span></span></span></p><p class=MsoNormal><span style=font-size:11.0pt;font-family:微软雅黑;>B</span><span style=font-size:11.0pt;font-family:微软雅黑;>、 用“从……到……”，或“自……起，到……止”（英文用“<span>FROM</span>……<span>TO</span>……”），“……”内填写年、月、日；<span></span></span></p><p class=MsoNormal><span style=font-size:11.0pt;font-family:微软雅黑;>C</span><span style=font-size:11.0pt;font-family:微软雅黑;>、 用“在<span>X</span>个月内有效”英文用“<span>WITHIN</span>……<span>MONTH(S)</span>”，“……”内填写阿拉伯数字。<span></span></span></p><p class=MsoNormal><span style=font-size:11.0pt;font-family:微软雅黑;>3</span><span style=font-size:11.0pt;font-family:微软雅黑;>） 签证的停留期，是指准许签证获得者在前往国家（地区）停留的期限。其在签证页上的表达方式有：<span></span></span></p><p class=MsoNormal><span style=font-size:11.0pt;font-family:微软雅黑;>A</span><span style=font-size:11.0pt;font-family:微软雅黑;>、 每次停留<span>XX</span>天英文为“<span>DURATION OF EACH STAY</span>……<span>DAYS</span>”或 “<span>DURATION OF STAY</span>……<span>DAYS</span>”；<span></span></span></p><p class=MsoNormal><span style=font-size:11.0pt;font-family:微软雅黑;>B</span><span style=font-size:11.0pt;font-family:微软雅黑;>、 准许停留<span>XX</span>天英文为“<span>WITH A STAY OF </span>……<span> DAYS</span>”。“……”处填写阿拉伯数字；<span></span></span></p><p class=MsoNormal><span style=font-size:11.0pt;font-family:微软雅黑;>C</span><span style=font-size:11.0pt;font-family:微软雅黑;>、 停留期与有效期是一致的：即“从<span>X</span>年<span>X</span>月<span>X</span>日到<span>X</span>年<span>X</span>月<span>X</span>日”英文为“<span>FROM</span>……<span>TO</span>……”；<span></span></span></p><p class=MsoNormal><b><span style=font-size:12.0pt;font-family:微软雅黑;color:red;>Q</span></b><b><span style=font-size:12.0pt;font-family:微软雅黑;color:red;>：</span></b><b><span style=font-size:12.0pt;font-family:微软雅黑;>面试时间可以自选不？</span></b><span style=font-size:12.0pt;font-family:微软雅黑;></span></p><p class=MsoNormal><b><span style=font-size:12.0pt;font-family:微软雅黑;color:#385623;>A</span></b><b><span style=font-size:12.0pt;font-family:微软雅黑;color:#385623;>：</span></b><span style=font-size:11.0pt;font-family:微软雅黑;>亲，面试时间是由领馆决定的哦。当然我们会在领馆允许的时间下尽量帮您协调，同时也建议您尽早安排好行程，以免因预约到的时间过晚影响出行时间哦。<span></span></span></p><p class=MsoNormal><b><span style=font-size:12.0pt;font-family:微软雅黑;color:red;>Q</span></b><b><span style=font-size:12.0pt;font-family:微软雅黑;color:red;>：</span></b><span style=font-size:12.0pt;font-family:微软雅黑;>儿童需要办理签证吗？<span></span></span></p><p class=MsoNormal><b><span style=font-size:12.0pt;font-family:微软雅黑;color:#385623;>A</span></b><b><span style=font-size:12.0pt;font-family:微软雅黑;color:#385623;>：</span></b><span style=font-size:11.0pt;font-family:微软雅黑;>只要不属于该国免签国家的公民都需要办理签证，不分成人及儿童哦。<span></span></span></p><p class=MsoNormal><b><span style=font-size:12.0pt;font-family:微软雅黑;color:red;>Q</span></b><b><span style=font-size:12.0pt;font-family:微软雅黑;color:red;>：</span></b><span style=font-size:12.0pt;font-family:微软雅黑;>申办签证，对护照有何要求？<span></span></span></p><p class=MsoNormal><b><span style=font-size:12.0pt;font-family:微软雅黑;color:#385623;>A</span></b><b><span style=font-size:12.0pt;font-family:微软雅黑;color:#385623;>：</span></b><span style=font-size:11.0pt;font-family:微软雅黑;>一般国家都要求护照的有效期至少距离回国后还有<span>3-6</span>个月哦，否则不受理签证申请，具体按各国家的要求执行。 因私护照成年人的有效期为<span>10</span>年，未成年人的有效期为<span>5</span>年。请您留意您的护照首页上的有效期。</span><span style=font-size:12.0pt;font-family:微软雅黑;></span></p></p></p>";
    
    // 状态栏(statusbar)
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    // 导航栏（navigationbar）
    CGRect rectNav = self.navigationController.navigationBar.frame;

    self.textScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight - rectNav.size.height - rectStatus.size.height)];
    
    
    self.textLabel = [[UILabel alloc] init];
    _textLabel.numberOfLines = 0;
    
    
    if ([self.titleString isEqualToString:@"常见问题"]) {
        self.attrStr = [[NSAttributedString alloc] initWithData:[questionStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    } else if ([self.titleString isEqualToString:@"预订须知"] && ![self.sourceStr isEqualToString:@"邮轮"]){
        _textLabel.text = str;
        
        //[self returnTextCGRectText:attrStr textFont:17];
        _textLabel.font = [UIFont systemFontOfSize:14];
        _textLabel.frame = CGRectMake(15, 0, windowContentWidth - 30, [self returnTextCGRectText:str textFont:14].size.height);
        _textScrollView.contentSize = CGSizeMake(windowContentWidth, [self returnTextCGRectText:str textFont:14].size.height );
        
        [_textScrollView addSubview:_textLabel];
        
        [self.view addSubview:_textScrollView];
        return;
    } else if ([self.sourceStr isEqualToString:@"邮轮"]){
          self.attrStr = [[NSAttributedString alloc] initWithData:[self.textString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    }
    else{
        //self.attrStr = [[NSAttributedString alloc] initWithData:[self.textString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
         [self loadData];
    }
    
    CGRect rect = [_attrStr boundingRectWithSize:CGSizeMake(windowContentWidth - 20, 0) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    _textLabel.attributedText = _attrStr;
    
    //[self returnTextCGRectText:attrStr textFont:17];
    _textLabel.frame = CGRectMake(10, 10, windowContentWidth - 20, rect.size.height);
    _textScrollView.contentSize = CGSizeMake(windowContentWidth, rect.size.height );
    
    [_textScrollView addSubview:_textLabel];
    
    [self.view addSubview:_textScrollView];
}







- (CGRect)returnTextCGRectText:(NSString *)str textFont:(CGFloat)font
{
    NSDictionary * textDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil];
    CGRect rect = [str boundingRectWithSize:CGSizeMake(windowContentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
    return rect;
}

//- (CGRect)returnTextCGRectText:(NSAttributedString *)attributedText textFont:(UIFont *)font
//{
//    NSDictionary *textDic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
//    CGRect rect = [attributedText boundingRectWithSize:<#(CGSize)#> options:<#(NSStringDrawingOptions)#> context:<#(NSStringDrawingContext *)#>]
//    
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)loadData
{
    //NSLog(@"++++-%@+++", self.textString);
    if ([self.textString isEqual:@""]) {
        UIView * aView = [[UIView alloc] initWithFrame:self.view.bounds];
        aView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:aView];
        UIImageView *bgView=[[UIImageView alloc] init];
        bgView.frame=CGRectMake((windowContentWidth-200)/2, (windowContentHeight-200-140)/2, 200, 200);
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.image=[UIImage imageNamed:@"没找到相关内容.png"];
        [aView addSubview:bgView];
        [bgView bringSubviewToFront:aView];
        return;
    }

    NSString *str=[NSString stringWithFormat:@"%@?libs=%@",VisaDetailNeedMateria, self.textString];
    
    NSLog(@"++++++++++++%@", str);
    __weak ZFJNoticeMessageVC * noticeMesageVC  = self;
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
               
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
//        NSLog(@"获取到的数据为：%@",dict);
        
        
        NSString * bigTitle = @"";
        NSString * smallTitle = @"";
        NSString * contentStr = @"";
        NSString * oneSmallTitle = @"";
        NSString * oneBigTitle = @"";
        NSString * oneAllSmallTitle = @"";
        for (int i = 0; i < [[dict objectForKey:@"data"] allKeys].count; i++) {
            //NSLog(@"++++++++++++++++++++++++%@", [[[dict objectForKey:@"data"] objectForKey:[[[dict objectForKey:@"data"] allKeys] objectAtIndex:i]] objectForKey:@"child"]);
            //NSLog(@"bigTitle = %@", [[[dict objectForKey:@"data"] objectForKey:[[[dict objectForKey:@"data"] allKeys] objectAtIndex:i]] objectForKey:@"name"]);
            for (int j = 0; j < [[[[dict objectForKey:@"data"] objectForKey:[[[dict objectForKey:@"data"] allKeys] objectAtIndex:i]] objectForKey:@"child"] allKeys].count; j++) {
                
                for (int k = 0; k < [[[[[[dict objectForKey:@"data"] objectForKey:[[[dict objectForKey:@"data"] allKeys] objectAtIndex:i]] objectForKey:@"child"] objectForKey:[[[[[dict objectForKey:@"data"] objectForKey:[[[dict objectForKey:@"data"] allKeys] objectAtIndex:i]] objectForKey:@"child"] allKeys] objectAtIndex:j]] objectForKey:@"child"] allKeys].count; k++) {
               
                    contentStr = [NSString stringWithFormat:@"%@%@", contentStr, [NSString stringWithFormat:@"<p>&nbsp;&nbsp;&nbsp;&nbsp;%@ </p>", [[[[[[dict objectForKey:@"data"] objectForKey:[[[dict objectForKey:@"data"] allKeys] objectAtIndex:i]] objectForKey:@"child"] objectForKey:[[[[[dict objectForKey:@"data"] objectForKey:[[[dict objectForKey:@"data"] allKeys] objectAtIndex:i]] objectForKey:@"child"] allKeys] objectAtIndex:j]] objectForKey:@"child"] objectForKey:[[[[[[[dict objectForKey:@"data"] objectForKey:[[[dict objectForKey:@"data"] allKeys] objectAtIndex:i]] objectForKey:@"child"] objectForKey:[[[[[dict objectForKey:@"data"] objectForKey:[[[dict objectForKey:@"data"] allKeys] objectAtIndex:i]] objectForKey:@"child"] allKeys] objectAtIndex:j]] objectForKey:@"child"] allKeys] objectAtIndex:k]]]];
                       //NSLog(@"%@", contentStr);
                    
                }
                smallTitle = [NSString stringWithFormat:@"%@%@", smallTitle, [NSString stringWithFormat:@"<h3>%@</h3>", [[[[[dict objectForKey:@"data"] objectForKey:[[[dict objectForKey:@"data"] allKeys] objectAtIndex:i]] objectForKey:@"child"] objectForKey:[[[[[dict objectForKey:@"data"] objectForKey:[[[dict objectForKey:@"data"] allKeys] objectAtIndex:i]] objectForKey:@"child"] allKeys] objectAtIndex:j]] objectForKey:@"name"]]];
                
                oneSmallTitle = [NSString stringWithFormat:@"%@%@", smallTitle, contentStr];
                //NSLog(@"oneSmallTitle = %@", oneSmallTitle);
                contentStr = @"";
                smallTitle = @"";
                oneAllSmallTitle = [NSString stringWithFormat:@"%@%@", oneAllSmallTitle, oneSmallTitle];
                oneSmallTitle = @"";
            }
        
            bigTitle = [NSString stringWithFormat:@"%@%@", bigTitle, [NSString stringWithFormat:@"<h2>%@</h2>", [[[dict objectForKey:@"data"] objectForKey:[[[dict objectForKey:@"data"] allKeys] objectAtIndex:i]] objectForKey:@"name"]]];
            
            oneBigTitle = [NSString stringWithFormat:@"%@%@%@", oneBigTitle ,bigTitle, oneAllSmallTitle];
            bigTitle = @"";
            oneAllSmallTitle = @"";
           // NSLog(@"++++++++++++++++++++++++++++++++++%@", oneBigTitle);
            
            
        }

    self.attrStr = [[NSAttributedString alloc] initWithData:[oneBigTitle dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        
        
        
        CGRect rect = [_attrStr boundingRectWithSize:CGSizeMake(windowContentWidth - 20, 0) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        
        _textLabel.attributedText = _attrStr;
        
        //[self returnTextCGRectText:attrStr textFont:17];
        _textLabel.frame = CGRectMake(10, 10, windowContentWidth - 20, rect.size.height);
        _textScrollView.contentSize = CGSizeMake(windowContentWidth, rect.size.height );
        
        [_textScrollView addSubview:_textLabel];
        
        [noticeMesageVC.view addSubview:_textScrollView];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
               
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
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
