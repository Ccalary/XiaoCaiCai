//
//  TouGaoRenRenZhengCell1.h
//  才标网
//
//  Created by 李强 on 2017/2/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^didHaveTureNameBlock)(NSString *str);

@interface TouGaoRenRenZhengCell1 : UITableViewCell

@property (nonatomic, copy) didHaveTureNameBlock didHaveTureName;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UIButton *sureBtn;

@property (nonatomic, strong) UILabel *checkingLabel;

+ (TouGaoRenRenZhengCell1 *)cellWithTableView:(UITableView *)tableView;

@end
