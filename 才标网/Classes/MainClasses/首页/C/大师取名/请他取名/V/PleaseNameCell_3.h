//
//  PleaseNameCell_3.h
//  才标网
//
//  Created by baichun on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^Block)(UIButton * button0);

@interface PleaseNameCell_3 : UITableViewCell
+ (PleaseNameCell_3 *)cellWithTableView:(UITableView *)tableView;
//传递请选择
@property (nonatomic, copy) Block block0;
@property (nonatomic, strong) UIButton *birthdayBtn;

@end
