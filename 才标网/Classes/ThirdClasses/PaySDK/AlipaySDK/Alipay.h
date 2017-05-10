//
//  Alipay.h
//  才标网
//
//  Created by caohouhong on 17/3/30.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Alipay : NSObject

- (instancetype)initWithProductSubject:(NSString *)subject andPrice:(NSString *)price andOutTradeNo:(NSString *)outTradeNo;

- (void)doAlipayPay;
@end
