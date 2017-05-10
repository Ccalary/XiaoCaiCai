//
//  XuanShangHeardview.h
//  才标网
//
//  Created by baichun on 17/3/8.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SScreen_Width [UIScreen mainScreen].bounds.size.width
#define SScreen_Height [UIScreen mainScreen].bounds.size.height
#define MFont(a) [UIFont systemFontOfSize:a]
#define MColor(a, g, b) [UIColor colorWithRed:(a / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:1]
@class XuanShangHeardview;
@protocol XuanShangHeardviewDelegate <NSObject>

- (void)pullDownMenuView:(XuanShangHeardview *)menu didSelectedIndex:(NSIndexPath *)indexPath;
@end
@interface XuanShangHeardview : UIView

@property (nonatomic, assign) BOOL isRightViewHidden;
@property (nonatomic, weak) id<XuanShangHeardviewDelegate> menuViewDelegate;

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSArray *)titleArray withSelectColor:(UIColor *)color;
- (void)tapClick;
@end
