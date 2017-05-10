//
//  TouGaoRenRenZhengCell2.h
//  才标网
//
//  Created by 李强 on 2017/2/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TouGaoRenRenZhengCell2 : UITableViewCell
@property (nonatomic, copy) NSString *provinceName;
@property (nonatomic, copy) NSString *cityName;


- (void)afterReZheng;
+ (TouGaoRenRenZhengCell2 *)cellWithTableView:(UITableView *)tableView;

@end
