//
//  TradeCategoryVC.h
//  才标网
//
//  Created by caohouhong on 17/5/2.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "MainBaseViewController.h"

typedef void(^selectBlock)(NSString *string);

@interface TradeCategoryVC : MainBaseViewController

@property (nonatomic, copy) selectBlock block;

@property (nonatomic, copy) NSString *selectedStr;
@end
