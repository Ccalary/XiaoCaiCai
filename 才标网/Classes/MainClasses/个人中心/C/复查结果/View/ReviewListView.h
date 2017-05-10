//
//  ReviewListView.h
//  才标网
//
//  Created by caohouhong on 17/4/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReviewListModel.h"

@protocol  ReviewListViewDelegate<NSObject>

- (void)clickRowWithModel:(ReviewListModel *)model;

@end

@interface ReviewListView : UIView

@property (nonatomic, weak) id<ReviewListViewDelegate> delegate;

//state 查询状态：1-进行中 2-已结束 不传表示“全部”
- (instancetype)initWithFrame:(CGRect)frame andState:(int) state;
@end
