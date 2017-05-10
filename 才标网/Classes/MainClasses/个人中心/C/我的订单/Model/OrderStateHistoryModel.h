//
//  OrderStateHistoryModel.h
//  才标网
//
//  Created by caohouhong on 17/4/7.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderStateHistoryModel : NSObject
@property (nonatomic, copy) NSString *date_added;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *comment;
@end
