//
//  MasterFoot.h
//  才标网
//
//  Created by baichun on 17/3/29.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^saveBlock)();

@interface MasterFoot : UITableViewHeaderFooterView
@property(nonatomic,strong)UIButton *registeredBtn;
@property (nonatomic,copy) saveBlock saveblock;
@end
