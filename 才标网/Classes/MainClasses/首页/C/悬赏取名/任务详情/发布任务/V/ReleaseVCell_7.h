//
//  ReleaseVCell_7.h
//  才标网
//
//  Created by baichun on 17/3/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^Block)(UIButton * button0);
typedef void(^Block)(UIButton * button1);
@interface ReleaseVCell_7 : UITableViewCell

@property (nonatomic, copy) Block block0;
@property (nonatomic,strong) UIButton *wxBtn;
@property (nonatomic,strong) UIButton *payBtn;
@property (nonatomic, copy) Block block1;
+ (ReleaseVCell_7 *)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) UIButton *timeBtn;
@property (nonatomic,strong) UIButton *moneyBtn;
@end
