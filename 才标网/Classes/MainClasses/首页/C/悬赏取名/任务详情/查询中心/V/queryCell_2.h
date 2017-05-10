//
//  queryCell_2.h
//  才标网
//
//  Created by baichun on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^queryBlock)();
@interface queryCell_2 : UITableViewCell
+ (queryCell_2 *)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong)UIButton *weChatBtn;
@property (nonatomic,strong)UIButton *payBtn;
@property (nonatomic,strong)UILabel *priceLable;
@property (nonatomic,strong)UITextField *textField;

@property (nonatomic, copy) queryBlock block0;

@end
