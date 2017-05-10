//
//  CompanyTypeModel.h
//  才标网
//
//  Created by caohouhong on 17/4/19.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompanyTypeModel : NSObject
//private String id;
//private String name;
//private String description;
//private String sort;

//任务需求标签
@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *sid;

@property(nonatomic,copy)NSString *descript;

@property(nonatomic,copy)NSString *sort;

@end
