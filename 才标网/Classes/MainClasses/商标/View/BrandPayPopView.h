//
//  BrandPayPopView.h
//  才标网
//
//  Created by caohouhong on 17/4/7.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^cancelBlock)();
typedef void(^selectBlock)(int row);

@interface BrandPayPopView : UIView

@property (nonatomic, copy) cancelBlock closeBlock;

@property (nonatomic, copy) selectBlock wayBlock;
@end
