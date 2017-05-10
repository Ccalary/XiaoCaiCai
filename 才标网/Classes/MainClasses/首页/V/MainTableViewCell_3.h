//
//  MainTableViewCell_3.h
//  才标网
//
//  Created by caohouhong on 17/3/28.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelMember.h"


typedef void(^cellBlock)(ModelMember *model);

@interface MainTableViewCell_3 : UITableViewCell

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, copy) cellBlock block;

+ (MainTableViewCell_3 *)cellWithTableView:(UITableView *)tableView;

@end
