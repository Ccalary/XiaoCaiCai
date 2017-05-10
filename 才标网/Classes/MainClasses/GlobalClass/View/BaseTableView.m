//
//  BaseTableView.m
//  才标网
//
//  Created by caohouhong on 17/4/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "BaseTableView.h"
#import "FBKVOController.h"

@interface BaseTableView()
@property (nonatomic, strong) FBKVOController *kvoController;
@property (nonatomic, strong) UIView *holdView;

@end

@implementation BaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self){
        //默认无数据高度
        self.noDataHeight = 20*UIRate;
        
        [self drawView];
        [self initFBKVO];
    }
    return self;
}

- (void)drawView{
    
    _holdView = [[UIView alloc] init];
    _holdView.backgroundColor = [UIColor clearColor];
    _holdView.hidden = YES;
    [self addSubview:_holdView];
    
    UIImageView *defaultImageView = [[UIImageView alloc] init];
    defaultImageView.image = [UIImage imageNamed:@"c_default_nothing_98x106"];
    [_holdView addSubview:defaultImageView];
    
    UILabel *stringLabel = [[UILabel alloc] init];
    stringLabel.text = @"没有更多了";
    stringLabel.font = SYSTEM_FONT_(15*UIRate);
    stringLabel.textAlignment = NSTextAlignmentCenter;
    stringLabel.textColor = COLOR_Gray;
    [_holdView addSubview:stringLabel];
    
    _holdView.sd_layout
    .centerXEqualToView(self)
    .centerYEqualToView(self)
    .widthIs(ScreenWidth)
    .heightIs(200*UIRate);

    defaultImageView.sd_layout
    .centerXEqualToView(_holdView)
    .topEqualToView(_holdView)
    .widthIs(98*UIRate)
    .heightIs(106*UIRate);
    
    stringLabel.sd_layout
    .centerXEqualToView(_holdView)
    .topSpaceToView(defaultImageView,10*UIRate)
    .widthIs(ScreenWidth)
    .heightIs(20*UIRate);
}

- (void)initFBKVO{
    
    //KVO
    __weak typeof (self) weakSelf = self;
    self.kvoController = [FBKVOController controllerWithObserver:self];
    [self.kvoController observe:self keyPath:@"contentSize" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        
        CGFloat height =  weakSelf.contentSize.height;
        if ( height > weakSelf.noDataHeight){
            _holdView.hidden = YES;
        }else {
            _holdView.hidden = NO;
            _holdView.center = self.center;
        }
    }];
}

@end
