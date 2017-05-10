//
//  MainTableViewCell_4.h
//  才标网
//
//  Created by caohouhong on 17/3/28.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^moreBlock)();

@interface MainTableViewCell_4 : UITableViewCell

@property (nonatomic, copy) moreBlock block;

+ (MainTableViewCell_4 *)cellWithTableView:(UITableView *)tableView;
@end
