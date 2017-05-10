//
//  ReleaseVCell_1.h
//  才标网
//
//  Created by baichun on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^bandBlock)();
typedef void(^companyBlock)();

@interface ReleaseVCell_1 : UITableViewCell
+ (ReleaseVCell_1 *)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, copy) bandBlock block0;

@property (nonatomic, copy) companyBlock block1;

@property(nonatomic,strong) UIButton *rademarkBtn;
@property(nonatomic,strong) UIButton *companyBtn;

    
@end
