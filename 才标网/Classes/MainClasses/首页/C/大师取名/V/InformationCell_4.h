//
//  InformationCell_4.h
//  才标网
//
//  Created by baichun on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelMember.h"
@interface InformationCell_4 : UITableViewCell

@property (nonatomic, strong)ModelMember *model;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andNum:(int) num;
@end
