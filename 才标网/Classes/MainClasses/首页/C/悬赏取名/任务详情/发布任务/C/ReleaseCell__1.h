//
//  ReleaseCell__1.h
//  才标网
//
//  Created by baichun on 17/3/22.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Block)(UIButton * button0);
typedef void(^Block)(UIButton * button1);

@interface ReleaseCell__1 : UITableViewCell
+ (ReleaseCell__1 *)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, copy) Block block0;

@property (nonatomic, copy) Block block1;

@property(nonatomic,strong) UIButton *rademarkBtn;
@property(nonatomic,strong) UIButton *companyBtn;
@end
