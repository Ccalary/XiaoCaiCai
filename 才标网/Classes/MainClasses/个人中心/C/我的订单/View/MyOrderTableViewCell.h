//
//  MyOrderTableViewCell.h
//  才标网
//
//  Created by caohouhong on 17/3/27.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
typedef NS_OPTIONS(NSUInteger, MyOrderTableViewCellType) {
    MyOrderTableViewCellTypeSee = 0, //查看
    MyOrderTableViewCellTypePay = 1, //付款
};

@protocol MyOrderTableViewCellDelegate <NSObject>

- (void)clickButtonWithTag:(MyOrderTableViewCellType)tag andOrderId:(NSString *)orderId;

@end

@interface MyOrderTableViewCell : UITableViewCell

@property (nonatomic, weak) id<MyOrderTableViewCellDelegate> delegete;
@property (nonatomic,strong)OrderModel *model;

@end
