//
//  UITextField+LQCategory.m
//  ZhouMo
//
//  Created by liqiang on 16/9/14.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "UITextField+LQCategory.h"

@implementation UITextField (LQCategory)

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

@end
