//
//  MainTableViewCell_6.h
//  才标网
//
//  Created by 李强 on 2017/2/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^moreBlock)();

@interface MainTableViewCell_6 : UITableViewCell

@property (nonatomic, copy) moreBlock block;

+ (MainTableViewCell_6 *)cellWithTableView:(UITableView *)tableView;

@end
