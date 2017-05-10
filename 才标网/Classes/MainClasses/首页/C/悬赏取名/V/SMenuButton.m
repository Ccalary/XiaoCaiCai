//
//  SMenuButton.m
//  meidianjie
//
//  Created by HYS on 16/3/4.
//  Copyright © 2016年 HYS. All rights reserved.
//

#import "SMenuButton.h"

@implementation SMenuButton

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageEdgeInsets = UIEdgeInsetsMake(0, CGRectGetMaxX(self.titleLabel.frame), 0, 0);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
}



@end
