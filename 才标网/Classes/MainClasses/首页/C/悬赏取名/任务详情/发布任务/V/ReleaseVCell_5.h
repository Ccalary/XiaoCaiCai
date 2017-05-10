//
//  ReleaseVCell_5.h
//  才标网
//
//  Created by baichun on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^DidHaveAttr1)(NSString *str);
@interface ReleaseVCell_5 : UITableViewCell
+ (ReleaseVCell_5 *)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, copy) DidHaveAttr1 didHaveAttr1;

@end
