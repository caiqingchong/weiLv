//
//  ScenicView.m
//  WelLv
//
//  Created by WeiLv on 16/2/16.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "ScenicView.h"

#import "ProductModel.h"

#define UISCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

@implementation ScenicView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        [self addFeatureLable];
        [self addSubview:self.featureLable];
    }
    return self;
}

- (UILabel *)featureLable{
    if (!_featureLable) {
            self.featureLable = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH / 28, 10, UISCREEN_WIDTH - UISCREEN_WIDTH / 28 * 2, 20)];
    }
    return _featureLable;
}



- (void)assignValueWithModel:(ProductModel *)productModel{
    
    NSString *htmlStr = productModel.feature;
    NSAttributedString *attrStr = [[NSAttributedString alloc]initWithData:[htmlStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
//    self.featureLable.attributedText = attrStr;
    self.featureLable.text = attrStr.string;
    self.featureLable.numberOfLines = 0;
    self.featureLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26.66];
    self.featureLable.textColor = [UIColor colorWithRed:109/255.0 green:113/255.0 blue:118/255.0 alpha:1.0];
    //赋值完成之后,重新计算 webLable 的大小
    CGRect webRect = self.featureLable.frame;
    //修改 webLable 的高
    webRect.size.height = [[self class] heightOfLable:attrStr.string];
    //修改后重新赋值
    self.featureLable.frame = webRect;

    
}

+ (CGFloat)lableHeight:(ProductModel *)model{
    NSAttributedString *attrStr = [[NSAttributedString alloc]initWithData:[model.feature dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    
    NSString *str = attrStr.string;
    
    CGFloat lableHeight = [self heightOfLable:str];

    return lableHeight;
}

+ (CGFloat)heightOfLable:(NSString *)height{
    
    CGSize contextSize = CGSizeMake(UISCREEN_WIDTH - UISCREEN_WIDTH / 28 * 2, 0);
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:UISCREEN_WIDTH / 26.66]};
    CGRect lableRect = [height boundingRectWithSize:contextSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return lableRect.size.height;
    
}

@end
