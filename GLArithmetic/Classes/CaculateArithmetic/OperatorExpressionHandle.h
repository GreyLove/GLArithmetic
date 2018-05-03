//
//  OperatorExpressionHandle
//  test
//
//  Created by gl on 2018/4/26.
//  Copyright © 2018年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>

/*字符串包含*/
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000
#define kContainsString(source,string) ([source containsString:string])
#else
#define kContainsString(source,string) ([source rangeOfString:string].location != NSNotFound)
#endif

typedef NS_ENUM(NSUInteger, OperatorPriority) {
    OperatorPriorityHigher,
    OperatorPriorityLower,
    OperatorPriorityEqual,
    OperatorPriorityError
};
@interface OperatorExpressionHandle : NSObject
+ (NSArray*)postfixExpWithInfixExp:(NSString*)infixExp;
//判断是否是操作符
+ (BOOL)isOperator:(char)anOperator;
//判断是否是运算符
+ (BOOL)isCaculaOperator:(NSString*)operatorStr;
//判断是否是数字
+ (BOOL)isNumber:(NSString*)numberStr;
//比较操作符优先级
+ (OperatorPriority)compareOperator1:(NSString*)operator1 Operator2:(NSString*)operator2;
@end
