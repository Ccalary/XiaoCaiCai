//
//  NamedSearchPopView.h
//  才标网
//
//  Created by caohouhong on 17/4/5.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^cancelBlock)();
typedef void(^searchBlock)(NSString *brandName, NSString *name, NSString *phoneNum);

@interface NamedSearchPopView : UIView

@property (nonatomic, strong) UITextField *trademarkTF;
@property (nonatomic, strong) UITextField *iphoneTF;
@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic, copy) cancelBlock closeBlock;
@property (nonatomic, copy) searchBlock searchBlock;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *btn;
- (instancetype)initWithFrame:(CGRect)frame;
@end
