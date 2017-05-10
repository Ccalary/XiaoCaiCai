//
//  masterDetailsCell_10.h
//  才标网
//
//  Created by baichun on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^saveBlock)();

@interface masterDetailsCell_10 : UITableViewCell
+ (masterDetailsCell_10 *)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)UIButton *registeredBtn;
@property (nonatomic,copy) saveBlock saveblock;
@end
