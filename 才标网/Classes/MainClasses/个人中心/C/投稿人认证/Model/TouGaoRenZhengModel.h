//
//  TouGaoRenZhengModel.h
//  才标网
//
//  Created by caohouhong on 17/4/18.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 "cityName" : "无锡市",
 "original1" : "\/32a3d8b6514d26.jpg",
 "authType" : 1,
 "applyTime" : 1492493245,
 "memberName" : "137****7057",
 "memberId" : 1104,
 "attr1" : "就斤斤计较",
 "applyTimes" : 1,
 "provinceName" : "江苏省",
 "applyId" : 6,
 "checkResult" : 1,
 "provinceId" : 19,
 "trueName" : "1",
 "cityId" : 4648
 */

@interface TouGaoRenZhengModel : NSObject
@property (nonatomic, copy) NSString *trueName;
@property (nonatomic, copy) NSString *provinceName;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *attr1;

@property (nonatomic, copy) NSString *original1;

@property (nonatomic, assign) int checkResult;//是否上传， 1是 0否


@end
