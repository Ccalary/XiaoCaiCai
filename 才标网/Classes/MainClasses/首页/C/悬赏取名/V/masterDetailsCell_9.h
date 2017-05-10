//
//  masterDetailsCell_9.h
//  才标网
//
//  Created by baichun on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^saveBlock)();
@interface masterDetailsCell_9 : UITableViewCell
+ (masterDetailsCell_9 *)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,copy) saveBlock saveblock;
@property(nonatomic,strong)UIButton *saveBtn;
@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UILabel *answerLabel;
@end
