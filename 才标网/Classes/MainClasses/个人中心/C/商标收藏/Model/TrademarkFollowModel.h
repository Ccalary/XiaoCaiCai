//
//  TrademarkFollowModel.h
//  才标网
//
//  Created by caohouhong on 17/4/11.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrademarkFollowModel : NSObject
@property(nonatomic, strong) NSString *follow_id;//收藏id
@property(nonatomic, strong) NSString *trademark_name;
@property(nonatomic, strong) NSString *trademark_intcls;
@property(nonatomic, strong) NSString *trademark_image;
@property(nonatomic, strong) NSString *trademark_tmlaw;//商标状态
@property(nonatomic, strong) NSString *trademark_tmname;//商标名称
@property(nonatomic, strong) NSString *trademark_regno;
@end
