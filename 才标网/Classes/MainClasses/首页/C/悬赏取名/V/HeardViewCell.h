//
//  HeardViewCell.h
//  才标网
//
//  Created by baichun on 17/3/8.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeardViewCell : UITableViewCell
@property (nonatomic, weak) UILabel *titleLabel;
+ (HeardViewCell *)cellWithTableView:(UITableView *)tableView;

@end
