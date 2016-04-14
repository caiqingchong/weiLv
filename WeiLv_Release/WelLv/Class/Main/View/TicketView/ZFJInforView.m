//
//  ZFJInforView.m
//  WelLv
//
//  Created by 张发杰 on 15/8/17.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJInforView.h"

@implementation ZFJInforView

- (id)initWithFrame:(CGRect)frame withInforSte:(NSString *)inforStr {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        NSAttributedString * str = [[NSAttributedString alloc] initWithData:[inforStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        CGRect rect = [str boundingRectWithSize:CGSizeMake(ViewWidth(self) - 40, 0) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        self.frame = CGRectMake(ViewX(self), ViewY(self), ViewWidth(self), rect.size.height + 30);
        self.inforImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, ViewWidth(self) - 20, rect.size.height + 25)];
        self.inforImage.image = [UIImage imageNamed:@"背景"];
        [self addSubview:self.inforImage];
        self.inforLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, ViewWidth(self) - 40, rect.size.height)];
        self.inforLabel.numberOfLines = 0;
        self.inforLabel.attributedText = str;
        [self.inforImage addSubview:self.inforLabel];

    }
    return self;
}

@end
