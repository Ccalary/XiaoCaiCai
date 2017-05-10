//
//  GeRenZhongXingCell3.h
//  才标网
//
//  Created by 李强 on 2017/2/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelMemberExtend.h"

@protocol GeRenZhongXingCell3Delegate <NSObject>

- (void)GeRenZhongXingCell3ClickButtonWithTag:(int)tag andMsgNum:(int)num;

@end

@interface GeRenZhongXingCell3 : UITableViewCell

@property (nonatomic, weak) id<GeRenZhongXingCell3Delegate> delegate;

@property (nonatomic, strong) ModelMemberExtend *model;

+ (GeRenZhongXingCell3 *)cellWithTableView:(UITableView *)tableView;

@end
