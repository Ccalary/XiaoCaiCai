//
//  VersionModel.h
//  才标网
//
//  Created by caohouhong on 17/3/20.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 "state": 0,
 "fieldErrors": [],
 "data": 
 {
    "versionInfoId": 1,
    "apkVersion": "1.1",
    "downLoadPath": "fir.im/8hblhhhhhhh",
    "versionDesc": "更新了5处bug",
    "updateState": 1,
    "isForce": 1,
    "updateTips": "您需要下载新版本32323",
    "remark": "fir的IOS版本：如果apkVersion大于当前版本，则表示需要更新。如果isForce=1，表示需要强制更新。如果isForce=0，表示不用强制更新。下载新版本的地址是downLoadPath"
  }

 */

@interface VersionModel : NSObject

@property(nonatomic, assign) int versionInfoId;
/* 版本号 */
@property(nonatomic, copy) NSString *apkVersion;
/* 下载地址 */
@property(nonatomic, copy) NSString *downLoadPath;
/* 更新说明 */
@property(nonatomic, copy) NSString *versionDesc;
/* 是否强制更新 0-否  1-是 2-强制更新*/
@property(nonatomic, assign) int updateState;
/* 更新版本描述 */
@property(nonatomic, copy) NSString *updateTips;

@property(nonatomic, copy) NSString *remark;
@end
