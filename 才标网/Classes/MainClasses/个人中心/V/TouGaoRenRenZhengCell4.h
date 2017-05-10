//
//  TouGaoRenRenZhengCell4.h
//  才标网
//
//  Created by 李强 on 2017/2/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^didHaveAttr1Block)(NSString *str);

@interface TouGaoRenRenZhengCell4 : UITableViewCell

@property (nonatomic, copy) didHaveAttr1Block didHaveAttr1;



- (void)afterRenZhengWith:(NSString *)content;

+ (TouGaoRenRenZhengCell4 *)cellWithTableView:(UITableView *)tableView;
@end
