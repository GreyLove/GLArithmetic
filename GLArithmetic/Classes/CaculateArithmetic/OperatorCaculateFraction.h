//
//  OperatorCaculateFraction.h
//  test
//
//  Created by gl on 2018/4/26.
//  Copyright © 2018年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OperatorCaculateFraction : NSObject
//计算分数表达式
+ (NSString*)calculateFraction:(NSString *)infixexp errorString:(NSString **)errorString;
//分数转小数
+ (NSString*)fractionTranslatePoint:(NSString *)fraction;
@end
