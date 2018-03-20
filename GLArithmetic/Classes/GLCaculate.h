//
//  TFCaculate.h
//
//  Created by gl on 2018/3/17.
//  Copyright © 2018年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Caculate.h"

/*
 用法，暂时无法算分数
 NSString *str = @"2/4*8+(8+2)*4-4+8*1";
 
 //1.
 NSString *b1 = [GLCaculate caculateArithmeticString:str];
 
 */

@interface GLCaculate : NSObject
//计算四则运算
+ (NSString*)caculateArithmeticString:(NSString*)str;
//计算四则运算
+ (NSString*)caculateArithmeticArray:(NSArray*)arr;
//中缀转后缀
+ (NSArray*)infixExpressionToSuffixExpression:(NSArray *)arr;
//后缀计算
+ (NSString*)caculteSuffixExpression:(NSArray*)arr;
@end
