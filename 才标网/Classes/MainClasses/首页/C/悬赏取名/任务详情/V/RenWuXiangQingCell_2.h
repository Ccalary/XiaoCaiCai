//
//  RenWuXiangQingCell_2.h
//  才标网
//
//  Created by baichun on 17/3/8.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskModel.h"
#import "TTGroupTagView.h"
typedef void(^DidHaveAttr1)(NSString *str);
typedef void (^ReturnDataStingBlock)(NSString *showString);
@interface RenWuXiangQingCell_2 : UITableViewCell
+ (RenWuXiangQingCell_2 *)cellWithTableView:(UITableView *)tableView;


@property (nonatomic, copy) ReturnDataStingBlock returnDataStingBlock;

@property (nonatomic, copy) DidHaveAttr1 didHaveAttr1;

@property(nonatomic,strong)UILabel *leftLabel;
@property(nonatomic,strong)UILabel *dataLabel;
@property(nonatomic,strong)UILabel *hangYeLabel;
@property(nonatomic,strong)UILabel *RenWuLabel;
@property(nonatomic,strong)UILabel *tagLabel;
@property(nonatomic,strong)UILabel *tagLabel1;
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)TTGroupTagView *tagView;
@property(nonatomic,strong)NSMutableArray *recentHeightArray;
-(void)setTaskModel:(TaskModel *)model itemContents:(NSArray *)arr;

@property(nonatomic,copy)NSString *showStr;



@end
