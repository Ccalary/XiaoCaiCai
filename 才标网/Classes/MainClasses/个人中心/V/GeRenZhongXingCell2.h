//
//  GeRenZhongXingCell2.h
//  才标网
//
//  Created by 李强 on 2017/2/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeRenZhongXingCell2 : UITableViewCell

@property (nonatomic,strong) UIImageView *imgvHeader;
@property (nonatomic,strong) UILabel *lblTitle;
@property (nonatomic,strong) UILabel *rigtTitle;


+ (GeRenZhongXingCell2 *)cellWithTableView:(UITableView *)tableView;

@end
