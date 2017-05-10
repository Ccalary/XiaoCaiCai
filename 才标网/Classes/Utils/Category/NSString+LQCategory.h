
#import <Foundation/Foundation.h>

@interface NSString (LQCategory)

/**
 *  字典转字符串
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

/**
 *  计算文本的size
 */
+ (CGSize)calculateStringSizeWithMaxSize:(CGSize)maxSize font:(UIFont *)font string:(NSString *)string;

@end
