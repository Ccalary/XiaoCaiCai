//
//  ModelMember.m
//  才标网
//
//  Created by 李强 on 2017/2/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ModelMember.h"

static ModelMember *modelMember = nil;

@implementation ModelMember

+ (NSDictionary *)objectClassInArray
{
    return @{@"caseList":@"ModelMemberCase"};
}

//+ (ModelMember *)shareModelMember
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        if (modelMember == nil) {
//            modelMember = [[ModelMember alloc] init];
//        }
//    });
//    
//    return modelMember;
//}
//
//+ (id)allocWithZone:(struct _NSZone *)zone
//{
//    @synchronized (self) {
//        if (modelMember == nil) {
//            modelMember = [super allocWithZone:zone];
//        }
//    }
//    
//    return modelMember;
//}



@end
