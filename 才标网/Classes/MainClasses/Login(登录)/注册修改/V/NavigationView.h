//
//  NavigationView.h
//  才标网
//
//  Created by caohouhong on 17/4/10.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NavigationViewBlock)();

@interface NavigationView : UIView

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title block:(NavigationViewBlock) block;

@end
