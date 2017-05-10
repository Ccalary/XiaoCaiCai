//
//  ReleaseVCell_3.h
//  才标网
//
//  Created by baichun on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^Block)(UIButton * button0);
typedef void(^Block)(UIButton * button1);

@interface ReleaseVCell_3 : UITableViewCell
+ (ReleaseVCell_3 *)cellWithTableView:(UITableView *)tableView;
- (void)reloadButtonFrame:(UIButton *)button withTitle:(NSString *)title;
    //传递请选择
@property (nonatomic, copy) Block block0;
    //传递分类查询
@property (nonatomic, copy) Block block1;

@property (nonnull, strong) UIButton *chooseBtn;

@end
