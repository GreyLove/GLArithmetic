//
//  OperatorCaculateFraction.m
//  test
//
//  Created by gl on 2018/4/26.
//  Copyright © 2018年 gl. All rights reserved.
//

#import "OperatorCaculateFraction.h"
#import "OperatorExpressionHandle.h"

#define kDecimalNumberWithString(v) [NSDecimalNumber decimalNumberWithString:v]
#define kDecimalNumberPowerOf10(v,power) [v decimalNumberByMultiplyingByPowerOf10:power]
#define kDecimalNumberAdd(v1,v2) [v1 decimalNumberByAdding:v2]
#define kDecimalNumberSub(v1,v2) [v1 decimalNumberBySubtracting:v2]
#define kDecimalNumberMul(v1,v2) [v1 decimalNumberByMultiplyingBy:v2]
#define kDecimalNumberDiv(v1,v2) [v1 decimalNumberByDividingBy:v2]

@implementation OperatorCaculateFraction
+ (NSString*)calculateFraction:(NSString *)infixexp errorString:(NSString **)errorString{
    if (!infixexp.length) {
        *errorString = @"字符串为空";
        return nil;
    }
    NSString *infixexp1 = [infixexp stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *infixexp2 = [infixexp1 stringByReplacingOccurrencesOfString:@"×" withString:@"*"];
    NSString *infixexp3 = [infixexp2 stringByReplacingOccurrencesOfString:@"÷" withString:@"/"];
    
    NSMutableArray *postfixExp = (NSMutableArray *)[OperatorExpressionHandle postfixExpWithInfixExp:infixexp3];
    
    NSString *result = [self calculateWithPosfixExpF:postfixExp errorString:errorString];
    result = [self ireducibleFraction:result];
    
    return result;
}

//用后缀表达式计算结果 guolei
+ (NSString*)calculateWithPosfixExpF:(NSMutableArray *)posfixExp errorString:(NSString **)errorString
{
    if (errorString == NULL) {
        NSString __autoreleasing *err = nil;
        errorString = &err;
    }
    posfixExp = [NSMutableArray arrayWithArray:[[posfixExp reverseObjectEnumerator] allObjects]];
    NSMutableArray *dealStack = [NSMutableArray array];
    
    NSString *numberStr1 = @"";
    NSString *numberStr2 = @"";
    while(posfixExp.count != 0){
        NSString *currentStr = posfixExp.lastObject;
        if([OperatorExpressionHandle isNumber:currentStr]){
            //操作数入栈
            [dealStack addObject:currentStr];
        }else if ([OperatorExpressionHandle isCaculaOperator:currentStr]) {
            
            if ([currentStr isEqualToString:@"/"]) {
                
                numberStr1 = dealStack.lastObject;
                [dealStack removeLastObject];
                numberStr2 = dealStack.lastObject;
                [dealStack removeLastObject];
                
                if (kContainsString(numberStr1,currentStr) || kContainsString(numberStr2,currentStr)) {
                    NSString *result = [self caculteFraction:numberStr2 d2:numberStr1 operator:currentStr];
                    [dealStack addObject:result];
                    
                }else{
                    
                    NSMutableString *mutableString = [NSMutableString string];
                    [mutableString appendString:numberStr2];
                    [mutableString appendString:currentStr];
                    [mutableString appendString:numberStr1];
                    if ([numberStr1 isEqualToString:@"0"] || [numberStr1 isEqualToString:@"-0"]) {
                        *errorString = @"分母或除数不能为0";
                        return nil;
                    }
                    [dealStack addObject:mutableString];
                }
                
            }else{
                
                numberStr1 = dealStack.lastObject;
                [dealStack removeLastObject];
                numberStr2 = dealStack.lastObject;
                [dealStack removeLastObject];
                
                NSString *result = [self caculteFraction:numberStr2 d2:numberStr1 operator:currentStr];
                [dealStack addObject:result];
            }
        }
        [posfixExp removeLastObject];
    }
    
    if (dealStack.count ==1) {
        return [NSString stringWithFormat:@"%@",dealStack.lastObject];
    }else {
        return nil;
    }
}

//未约分的分数
+ (NSString*)normalFraction:(NSString*)aFraction{
    if (!aFraction.length || [aFraction isKindOfClass:[NSNull class]]) {
        return @"非法";
    }
    
    NSArray<NSString*> *d1Arr = [self parseFraction:aFraction];
    NSString *f1 = d1Arr[0];
    NSString *f2 = d1Arr[1];
    
    if ([f2 isEqualToString:@"0"] || [f2 isEqualToString:@"-0"]) {
        return @"非法";
    }
    if ([f1 isEqualToString:@"0"] || [f1 isEqualToString:@"-0"]) {
        return @"0";
    }
    
    NSString *first = @"";
    
    NSInteger co = 0;
    if (kContainsString(f1, @"-")) {
        f1 = [f1 substringFromIndex:1];
        co++;
    }
    if (kContainsString(f2, @"-")) {
        f2 = [f2 substringFromIndex:1];
        co++;
    }
    if (co%2 != 0) {
        first = @"-";
    }
    
    NSInteger k = 0;
    NSInteger k1 = 0;
    
    
    if (kContainsString(f1, @".")) {
        NSRange range = [f1 rangeOfString:@"."];
        k = f1.length-range.location-1;
    }
    
    if (kContainsString(f2, @".")) {
        NSRange range = [f2 rangeOfString:@"."];
        k1 = f2.length-range.location-1;
    }
    
    short max = MAX(k, k1);
    
    NSDecimalNumber *f11;
    NSDecimalNumber *f22;
    
    if (max) {
        f11 = kDecimalNumberPowerOf10(kDecimalNumberWithString(f1),max);
        f22 = kDecimalNumberPowerOf10(kDecimalNumberWithString(f2),max);
    }else{
        f11 = kDecimalNumberWithString(f1);
        f22 = kDecimalNumberWithString(f2);
    }
    return [NSString stringWithFormat:@"%@%@/%@",first,f11,f22];
}
//ireducible
+ (NSString *)ireducibleFraction:(NSString*)aFraction{
    
    NSString *normalfraction = [self normalFraction:aFraction];
    
    if ([normalfraction isEqualToString:@"非法"]) {
        return @"非法";
    }
    
    NSString *first = @"";
    if (kContainsString(normalfraction, @"-")) {
        normalfraction = [normalfraction substringFromIndex:1];
        first = @"-";
    }
    
    NSArray<NSString*> *d1Arr = [self parseFraction:normalfraction];
    NSString *a = d1Arr[0];//分子
    NSString *b = d1Arr[1];//分母
    
    //最大公约数
    NSDecimalNumber *gcd = [self greatestCommonDivisorA:kDecimalNumberWithString(a) b:kDecimalNumberWithString(b)];
    
    NSDecimalNumber *son = kDecimalNumberDiv(kDecimalNumberWithString(a),gcd);
    NSDecimalNumber *mom = kDecimalNumberDiv(kDecimalNumberWithString(b),gcd);
    
    NSString *result;
    if ([mom isEqualToNumber:@(1)]) {
        result = [NSString stringWithFormat:@"%@%@",first,son];
    }else{
        result = [NSString stringWithFormat:@"%@%@/%@",first,son,mom];
    }
    
    return result;
}

+ (BOOL)isZeroWithSub:(NSDecimalNumber*)a b:(NSDecimalNumber*)b{
    if ([kDecimalNumberSub(a, b) compare:kDecimalNumberWithString(@"0")] != NSOrderedSame) {
        return NO;
    }
    return YES;
}

+ (NSDecimalNumber *)maxA:(NSDecimalNumber*)a b:(NSDecimalNumber*)b{
    if ([a compare:b] == NSOrderedDescending) { //a>b
        return a;
    }else{
        return b;
    }
}

+ (NSDecimalNumber *)minA:(NSDecimalNumber*)a b:(NSDecimalNumber*)b{
    if ([a compare:b] == NSOrderedDescending) { //a>b
        return b;
    }else{
        return a;
    }
}

//是否能被整除
+ (BOOL)isDivisible:(NSDecimalNumber*)d1 byD2:(NSDecimalNumber*)d2{
    NSDecimalNumber *result = kDecimalNumberDiv(d1, d2);
    NSString *resultStr = [NSString stringWithFormat:@"%@",result];
    if (kContainsString(resultStr, @".")) {
        return NO;
    }
    return YES;
}

+ (NSString*)caculteFraction:(NSString*)d1 d2:(NSString*)d2 operator:(NSString*)operator{
    
    NSString *d11 = d1;
    NSString *d22 = d2;
    
    NSArray<NSString*> *d1Arr = [self parseFraction:d11];
    NSArray<NSString*> *d2Arr = [self parseFraction:d22];
    
    //分子
    NSDecimalNumber *numerator1 = kDecimalNumberWithString(d1Arr[0]);
    NSDecimalNumber *numerator2 = kDecimalNumberWithString(d2Arr[0]);
    
    //分母
    NSDecimalNumber *denominator1 = kDecimalNumberWithString(d1Arr[1]);
    NSDecimalNumber *denominator2 = kDecimalNumberWithString(d2Arr[1]);
    
    NSDecimalNumber *numerator3;
    NSDecimalNumber *denominator3;
    if([operator isEqualToString:@"+"]) {
        numerator3 = kDecimalNumberAdd(kDecimalNumberMul(numerator1, denominator2),kDecimalNumberMul(numerator2, denominator1));
        denominator3 = kDecimalNumberMul(denominator1, denominator2);
    }else if([operator isEqualToString:@"-"]) {
        numerator3 = kDecimalNumberSub(kDecimalNumberMul(numerator1, denominator2),kDecimalNumberMul(numerator2, denominator1));
        denominator3 = kDecimalNumberMul(denominator1, denominator2);
    }else if([operator isEqualToString:@"*"]) {
        numerator3 = kDecimalNumberMul(numerator1, numerator2);
        denominator3 = kDecimalNumberMul(denominator1, denominator2);
    }else if([operator isEqualToString:@"/"]) {
        numerator3 = kDecimalNumberMul(numerator1, denominator2);
        denominator3 = kDecimalNumberMul(denominator1, numerator2);
    }else{
        return nil;
    }
    NSString *retF = [NSString stringWithFormat:@"%@/%@",numerator3,denominator3];
    return retF;
}

+ (NSArray*)parseFraction:(NSString*)num{
    NSString *numerator1 = @"";//分子
    NSString *denominator1 = @"";//分母
    
    NSArray *arr1 = [num componentsSeparatedByString:@"/"];
    
    if (arr1.count == 2) {
        numerator1 = arr1[0];
        denominator1 = arr1[1];
    }else{
        numerator1 = arr1[0];
        denominator1 = @"1";
    }
    
    NSMutableArray *fractionArr = [NSMutableArray array];
    [fractionArr addObject:numerator1];
    [fractionArr addObject:denominator1];
    
    return (NSArray*)fractionArr;
}

+ (NSString*)fractionTranslatePoint:(NSString *)fraction{
    NSString *result;
    if (kContainsString(fraction, @"/")) {
        NSArray *ar = [fraction componentsSeparatedByString:@"/"];
        NSDecimalNumber *a = kDecimalNumberWithString(ar[0]);
        NSDecimalNumber *b = kDecimalNumberWithString(ar[1]);
        result = [self rounding:kDecimalNumberDiv(a, b) afterPoint:6];
    }else{
        result = fraction;
    }
    return result;
}

//保留几位小数
+ (NSString *)rounding:(NSDecimalNumber*)num afterPoint:(NSInteger)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = num;
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

//最大公约数
+ (NSDecimalNumber*)greatestCommonDivisorA:(NSDecimalNumber*)a b:(NSDecimalNumber*)b{
    NSDecimalNumber *t;
    while (![b isEqualToNumber:[NSDecimalNumber decimalNumberWithString:@"0"]]) {
        t = [self unsignedRemainderA:a b:b];
        a = b;
        b = t;
    }
    return a;
}

+ (NSDecimalNumber*)unsignedRemainderA:(NSDecimalNumber*)a b:(NSDecimalNumber*)b{
    //商
    NSDecimalNumber *quotient = [self unsignedDivQuotient:a b:b];
    //余数
    NSDecimalNumber *remainder = [a decimalNumberBySubtracting:[b decimalNumberByMultiplyingBy:quotient]];
    return remainder;
}

//商
+ (NSDecimalNumber*)unsignedDivQuotient:(NSDecimalNumber*)a b:(NSDecimalNumber*)b{
    if (!a || !b) {
        return nil;
    }
    
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       
                                       decimalNumberHandlerWithRoundingMode:NSRoundDown
                                       
                                       scale:0
                                       
                                       raiseOnExactness:NO
                                       
                                       raiseOnOverflow:NO
                                       
                                       raiseOnUnderflow:NO
                                       
                                       raiseOnDivideByZero:YES];
    
    NSDecimalNumber *r = [a decimalNumberByDividingBy:b withBehavior:roundUp];
    
    return r;
}
@end
