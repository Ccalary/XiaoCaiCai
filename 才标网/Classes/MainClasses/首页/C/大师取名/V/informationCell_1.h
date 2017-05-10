//
//  informationCell_1.h
//  才标网
//
//  Created by baichun on 17/3/18.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelMember.h"

@interface informationCell_1 : UITableViewCell

@property (nonatomic, strong)ModelMember *model;

+ (informationCell_1 *)cellWithTableView:(UITableView *)tableView;

@end
