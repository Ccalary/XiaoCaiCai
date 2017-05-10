//
//  listDictiionaryItemsModel.h
//  才标网
//
//  Created by baichun on 17/3/22.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>

//"id" : 1,
//"groupCode" : "dg_task_tag",
//"itemContent" : "中文名"

@interface listDictiionaryItemsModel : NSObject
//任务需求标签
@property(nonatomic,copy)NSString *itemContent;

@property(nonatomic,copy)NSString *sid;

@property(nonatomic,copy)NSString *groupCode;


@property(nonatomic,copy)NSString *categoryId;

@end
