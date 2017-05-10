//
//  ReviewResultDetailCell.h
//  才标网
//
//  Created by caohouhong on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReviewResultDetailCellBlock)();
@interface ReviewResultDetailCell : UITableViewCell

@property (nonatomic, copy) ReviewResultDetailCellBlock block;

@property (nonatomic, strong) UILabel *topTitleLabel, *leftNameLabel;
@property (nonatomic, strong) UIButton *rightButton;
@end
