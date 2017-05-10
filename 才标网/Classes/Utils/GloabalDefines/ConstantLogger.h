//
//  ConstantLogger.h
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/9.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#ifndef ConstantLogger_h
#define ConstantLogger_h

/**
 *  Define等级Log
 */
#ifdef DEBUG
#define NSLog( s, ... ) printf("%s %s\n", [[NSString stringWithFormat:@"%@", [NSDate date]] UTF8String], [[NSString stringWithFormat:@"<%@:(%d)>: %@", [NSString stringWithUTF8String:__FUNCTION__], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__]] UTF8String])
#else
#define NSLog( s, ... )
#endif

/**
 *  Debug等级Log
 */
#ifdef DEBUG
#define DLog(format, ...) NSLog(@"<DEBUG>: %@", [NSString stringWithFormat:format, ## __VA_ARGS__])
#else
#define DLog(format, ...) do {} while (0)
#endif

/**
 *  Info等级Log
 */
#ifdef DEBUG
#define ILog(format, ...) NSLog(@"<Info>: %@", [NSString stringWithFormat:format, ## __VA_ARGS__])
#else
#define ILog(format, ...) do {} while (0)
#endif

/**
 *  Error等级Log
 */
#ifdef DEBUG
#define ELog(format, ...) NSLog(@"<Error>: %@", [NSString stringWithFormat:format, ## __VA_ARGS__])
#else
#define ELog(format, ...) do {} while (0)
#endif

#endif /* ConstantLogger_h */
