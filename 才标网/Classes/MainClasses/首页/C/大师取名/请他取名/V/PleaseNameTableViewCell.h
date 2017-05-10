//
//  PleaseNameTableViewCell.h
//  才标网
//
//  Created by caohouhong on 17/3/22.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PleaseNameTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *mTextField;
@property (nonatomic, strong) UIButton *selectedButton;

+ (PleaseNameTableViewCell *)cellWithTableView:(UITableView *)tableView;

- (void)reloadButtonFrame:(UIButton *)button withTitle:(NSString *)title;
@end
