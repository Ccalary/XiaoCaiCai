//
//  reportCell.h
//  才标网
//
//  Created by baichun on 17/3/27.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface reportCell : UITableViewCell
+ (reportCell *)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *imageV;
@end
