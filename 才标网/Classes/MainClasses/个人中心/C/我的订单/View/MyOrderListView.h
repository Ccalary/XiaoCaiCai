//
//  MyOrderListView.h
//  才标网
//
//  Created by caohouhong on 17/3/27.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MyOrderListViewBlock)(int tag, NSString *orderId);

@interface MyOrderListView : UIView

@property (nonatomic, copy)MyOrderListViewBlock block;
- (instancetype)initWithFrame:(CGRect)frame;
@end
