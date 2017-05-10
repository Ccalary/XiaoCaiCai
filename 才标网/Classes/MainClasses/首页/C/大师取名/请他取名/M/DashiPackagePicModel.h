//
//  DashiPackagePicModel.h
//  才标网
//
//  Created by caohouhong on 17/3/23.
//  Copyright © 2017年 李强. All rights reserved.
//  大师套餐图片实体类

#import <Foundation/Foundation.h>

@interface DashiPackagePicModel : NSObject

/*主键id*/
@property(nonatomic, assign) int sid;
/* 套餐标识 */
@property(nonatomic, assign) int daShiPackageId;
/* 套餐图片 */
@property(nonatomic, copy) NSString *picPath;
/* 套餐图片标题 */
@property(nonatomic, copy) NSString *picTitle;

@end
