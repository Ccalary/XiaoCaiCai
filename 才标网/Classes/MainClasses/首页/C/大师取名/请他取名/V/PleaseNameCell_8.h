//
//  PleaseNameCell_8.h
//  才标网
//
//  Created by baichun on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^payWayBlock)(int);

@interface PleaseNameCell_8 : UITableViewCell

@property (nonatomic, copy)payWayBlock block;

+ (PleaseNameCell_8 *)cellWithTableView:(UITableView *)tableView;

@end
