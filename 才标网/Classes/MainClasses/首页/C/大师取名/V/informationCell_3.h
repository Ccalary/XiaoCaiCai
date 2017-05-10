//
//  informationCell_3.h
//  才标网
//
//  Created by baichun on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelMember.h"

typedef void(^informationCell_3Block)(NSString *);

@interface informationCell_3 : UITableViewCell

@property (nonatomic, strong)ModelMember *model;

@property (nonatomic, copy) informationCell_3Block block;

+ (informationCell_3 *)cellWithTableView:(UITableView *)tableView;

@end
