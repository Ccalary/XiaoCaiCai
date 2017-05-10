//
//  HomeAdsModel.h
//  才标网
//
//  Created by caohouhong on 17/4/1.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 "advertisementId": 4,
 "state": 0,
 "adPosition": 1,
 "adType": -9,  
 "adName": "我是外部链接",
 "adImg": "/444.png",
 "adLink": "http://www.baidu.com",
 "orderNo": 0,
 "beginTimestamp": 0,
 "endTimestamp": 0,
 "createdTimestamp": 0,
 "creatorId": 0,
 "lastModified": 0,
 "lastModifierId": 0
 */

@interface HomeAdsModel : NSObject
/*
 
 "state" : 0,
 "adPosition" : 3,
 "refEntityId" : 71,
 "adImg" : "\/326623315e9e94.png",
 "adName" : "tom",
 "beginTimestamp" : 0,
 "endTimestamp" : 0,
 "lastModifierId" : 0,
 "adLink" : "发明专利",
 "adType" : 6,
 "orderNo" : 0,
 "lastModified" : 0,
 "createdTimestamp" : 0,
 "creatorId" : 0,
 "advertisementId" : 51
 */



/*id*/
@property(nonatomic, assign) int advertisementId;
//代表  如果是任务就是taskId  
@property(nonatomic, assign) int refEntityId;

@property(nonatomic, assign) int state;

@property(nonatomic, assign) int adPosition;
//跳转到哪里的指向
@property(nonatomic, assign) int adType;
/* 广告头部名 */
@property(nonatomic, copy) NSString *adName;
/* 图片 */
@property(nonatomic, copy) NSString *adImg;
/* 外链地址 */
@property(nonatomic, copy) NSString *adLink;

@end
