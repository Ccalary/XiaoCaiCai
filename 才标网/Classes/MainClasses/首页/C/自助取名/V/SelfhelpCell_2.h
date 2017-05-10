//
//  SelfhelpCell_2.h
//  才标网
//
//  Created by baichun on 17/3/18.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^searchBlock)();

@interface SelfhelpCell_2 : UITableViewCell
+ (SelfhelpCell_2 *)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, copy) searchBlock block0;
@property(nonatomic,strong)UIButton *determineBtn;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong) UITextField *textFd;
@end
