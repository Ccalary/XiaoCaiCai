//
//  BaseWebViewController.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/3/10.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "MainBaseViewController.h"

@interface BaseWebViewController : MainBaseViewController
-(instancetype)initWithTitle:(NSString *)title andUrl:(NSString *)url;

@property (nonatomic, assign) BOOL isCanGoBack;//是否网页有回退,默认YES

@end
