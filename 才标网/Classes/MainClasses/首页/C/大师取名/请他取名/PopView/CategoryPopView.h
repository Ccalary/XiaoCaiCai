//
//  CategoryPopView.h
//  才标网
//
//  Created by caohouhong on 17/3/22.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^dismissBlock)(int row);

@interface CategoryPopView : UIView

@property (nonatomic, copy) dismissBlock block;
- (instancetype)initWithFrame:(CGRect)frame andArray:(NSArray *)array;
@end
