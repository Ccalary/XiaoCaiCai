//
//  masterDetailsCell_1.h
//  才标网
//
//  Created by baichun on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface masterDetailsCell_1 : UITableViewCell
+ (masterDetailsCell_1 *)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) UILabel *tagLabel;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *priceLable;
@property (nonatomic,strong) UILabel *complete;
@end
