//
//  MainHeaderView.h
//  才标网
//
//  Created by caohouhong on 17/3/29.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^moreBlock)();

@interface MainHeaderView : UIView
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *seeMoreButton;

@property (nonatomic, copy) moreBlock block;
@end
