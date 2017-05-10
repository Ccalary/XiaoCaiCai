//
//  ReviewTableViewCell.h
//  才标网
//
//  Created by caohouhong on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"
#import "ReviewListModel.h"

@interface ReviewTableViewCell : UITableViewCell

//消息
@property (nonatomic, strong) MessageModel *messageModel;

//复查
@property (nonatomic, strong) ReviewListModel *reviewModel;

@end
