//
//  IamMasterFoot.h
//  才标网
//
//  Created by baichun on 17/3/30.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^saveBlock)();

@interface IamMasterFoot : UITableViewHeaderFooterView
@property (nonatomic,copy) saveBlock saveblock;
@property (nonatomic,strong) UIButton *replyBtn;
@end
