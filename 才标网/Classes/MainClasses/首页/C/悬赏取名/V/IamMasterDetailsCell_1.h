//
//  IamMasterDetailsCell_1.h
//  才标网
//
//  Created by baichun on 17/3/18.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskAskAnswerListModel.h"

typedef void(^editBlock)();

@interface IamMasterDetailsCell_1 : UITableViewCell
+ (IamMasterDetailsCell_1 *)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,copy) editBlock editblock;

@property (nonatomic,strong) UITextField *textFd;

@property (nonatomic,strong) UITextField *explainFD;

@property (nonatomic,strong) UIButton *editorBtn;

@property (nonatomic,strong) UIButton *deleteBtn;

@property (nonatomic,strong) UIButton *replyBtn;

@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UILabel *answerLabel;

@property (nonatomic,strong) TaskAskAnswerListModel *model;
@end
