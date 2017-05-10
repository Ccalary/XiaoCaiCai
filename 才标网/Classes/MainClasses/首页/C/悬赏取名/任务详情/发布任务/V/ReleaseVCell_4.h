//
//  ReleaseVCell_4.h
//  才标网
//
//  Created by baichun on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^Block)(UIButton * button0);

@interface ReleaseVCell_4 : UITableViewCell
//传递请选择
@property (nonatomic, copy) Block block0;
@property (nonatomic, strong) UIButton *chooseBtn;

- (void)reloadButtonFrame:(UIButton *)button withTitle:(NSString *)title;

+ (ReleaseVCell_4 *)cellWithTableView:(UITableView *)tableView;

@end
