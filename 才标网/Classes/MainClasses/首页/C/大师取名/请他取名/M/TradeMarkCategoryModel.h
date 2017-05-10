//
//  TradeMarkCategoryModel.h
//  才标网
//
//  Created by caohouhong on 17/3/22.
//  Copyright © 2017年 李强. All rights reserved.
//  商标类型实体类

#import <Foundation/Foundation.h>

@interface TradeMarkCategoryModel : NSObject
/* 商标类型标识 */
@property(nonatomic,copy) NSString *sid;
/* 状态 */
@property(nonatomic,assign) int state;
/* ?? */
@property(nonatomic,copy) NSString *category_number;
/* 商标类型名称*/
@property(nonatomic,copy) NSString *category_name;
/* 标题*/
@property(nonatomic,copy) NSString *category_title;
/* 描述*/
@property(nonatomic,copy) NSString *category_descrption;

@property(nonatomic,copy) NSString *category_group_number;

@property(nonatomic,copy) NSString *category_trademark_code;


/*====================== 冗余  =======================*/
/* 子商标*/
@property(nonatomic,strong) NSArray *children;

@end
