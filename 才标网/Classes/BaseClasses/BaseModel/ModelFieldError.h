//
//  ModelFieldError.h
//  lingdaozhe
//
//  Created by liqiang on 16/4/20.
//  Copyright © 2016年 bckj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelFieldError : NSObject

@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) int field;

@end
