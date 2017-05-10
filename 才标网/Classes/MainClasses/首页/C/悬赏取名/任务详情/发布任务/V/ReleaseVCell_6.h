//
//  ReleaseVCell_6.h
//  才标网
//
//  Created by baichun on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTGroupTagView.h"

@interface ReleaseVCell_6 : UITableViewCell
+ (ReleaseVCell_6 *)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)TTGroupTagView *popview;
@property(nonatomic,strong)NSMutableArray *recentHeightArray;
-(void)setDataArr:(NSMutableArray *)btn;
@end
