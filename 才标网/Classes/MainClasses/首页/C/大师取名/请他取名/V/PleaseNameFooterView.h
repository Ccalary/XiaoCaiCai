//
//  PleaseNameFooterView.h
//  才标网
//
//  Created by caohouhong on 17/3/23.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PleaseNameFooterViewDelegate <NSObject>

- (void)commitBtnClick;

@end
typedef void(^payWayBlock)(int);

@interface PleaseNameFooterView : UIView
@property (nonatomic, weak) id<PleaseNameFooterViewDelegate> delegate;
@property (nonatomic, copy) payWayBlock block;
@end
