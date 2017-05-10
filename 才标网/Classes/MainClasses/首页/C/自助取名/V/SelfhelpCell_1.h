//
//  SelfhelpCell_1.h
//  才标网
//
//  Created by baichun on 17/3/18.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^cateBlock)();
typedef void(^searchBlock)();

@interface SelfhelpCell_1 : UITableViewCell
+ (SelfhelpCell_1 *)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, copy) cateBlock block0;
@property (nonatomic, copy) searchBlock block1;
@property (nonatomic, strong) UIButton *iconBtn;
@property (nonatomic, strong) UILabel *industryLabel;
@property (nonatomic, strong) UIButton *determineBtn;

@property (nonatomic, strong) UIButton *coverBtn;

@end
