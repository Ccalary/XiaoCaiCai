//
//  TouGaoRenRenZhengCell5.h
//  才标网
//
//  Created by 李强 on 2017/2/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^didChoosePtotoBlock)(UIImage *image);

@interface TouGaoRenRenZhengCell5 : UITableViewCell

@property (nonatomic, copy) didChoosePtotoBlock didChoosePtoto;

@property (nonatomic, strong) UIButton *uploadButton ;

@property (nonatomic, strong) UIImageView *idImageView;

+ (TouGaoRenRenZhengCell5 *)cellWithTableView:(UITableView *)tableView;

@end
