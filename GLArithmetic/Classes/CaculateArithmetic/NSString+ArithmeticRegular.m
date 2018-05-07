//
//  NSString+ArithmeticRegular.m
//  正则表达式
//
//  Created by gl on 2018/3/22.
//  Copyright © 2018年 gl. All rights reserved.
//

#import "NSString+ArithmeticRegular.h"

@implementation NSString (ArithmeticRegular)

- (BOOL)isValidArithmetic{
    return [self isValidArithmeticWithErrorString:nil];
}

- (BOOL)isValidArithmeticWithErrorString:(NSString**)errorString{
    if (errorString == NULL) {
        NSString __autoreleasing *err = nil;
        errorString = &err;
    }
    NSString *ss = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    *errorString = @"";
    if (![ss isArithmetic1]) {
        *errorString = @"字符串必须由数字，小数，符号和括号组成";
    }else if (![ss isArithmetic2]){
        *errorString = @"字符串开头必须是，数字，负号，左括号中的一个";
        
    }else if (![ss isArithmetic3]){
        *errorString = @"结尾是）或 数字";
        
    }else if (![ss isArithmetic4]){
        *errorString = @"不允许符号后面接符号或右括号,点后面接符号或者右括号或点";
        
    }else if (![ss isArithmetic5]){
        *errorString = @"不允许左括号后接运算符（- 可以表示负号）";
        
    }else if (![ss isArithmetic6]){
        *errorString = @"不允许左括号前有数字或右括号";
        
    }else if (![ss isArithmetic7]){
        *errorString = @"不允许右括号后接数字";
        
    }else if (![ss isArithmetic8]){
        *errorString = @"括号不匹配";
    }else if (![ss isArithmetic9]){
        *errorString = @"小数点前只能是数字";
    }else if (![ss isArithmetic10]){
        *errorString = @"小数点后只能是数字";
    }
    if ((*errorString).length) {
        return NO;
    }else{
        *errorString = nil;
    }
    return YES;
}



- (BOOL)check:(NSString*)regex{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

//规则0，字符串必须由数字，小数，符号和括号组成
- (BOOL)isArithmetic1{
    NSString *regex = @"[\\-|\\+|\\*|\\/|(|)|[0-9]|\\.]*";
    BOOL isValid = [self check:regex];
    return isValid;
}

//规则1 ，字符串开头必须是，数字，负号，左括号中的一个
- (BOOL)isArithmetic2{
    NSString *regex = @"^[\\-|(|\\d].*";
    BOOL isValid = [self check:regex];
    return isValid;
}
//规则2 结尾是）或 数字
- (BOOL)isArithmetic3{
    NSString *regex = @".*[)|\\d]$";
    BOOL isValid = [self check:regex];
    return isValid;
}
//规则3 不允许符号后面接符号或右括号,点后面接符号或者右括号或点
- (BOOL)isArithmetic4{
    NSString *regex = @".*[\\+|\\/|\\-|\\*][\\+|\\/|\\-|\\*|)].*";
    BOOL isValid = [self check:regex];
    return !isValid;
}

//规则4 不允许左括号后接运算符（- 可以表示负号）
- (BOOL)isArithmetic5{
    NSString *regex = @".*[(][\\+|\\/|\\*|)].*";
    BOOL isValid = [self check:regex];
    return !isValid;
}
//规则5 不允许左括号前有数字或右括号
- (BOOL)isArithmetic6{
    NSString *regex = @".*[[0-9]|)][(].*";
    BOOL isValid = [self check:regex];
    return !isValid;
}
//规则6 不允许右括号后接数字
- (BOOL)isArithmetic7{
    NSString *regex = @".*[)][0-9].*";
    BOOL isValid = [self check:regex];
    return !isValid;
}
//规则7 匹配括号
- (BOOL)isArithmetic8{
    NSMutableArray *arr1 = [NSMutableArray array];
    NSMutableArray *arr2 = [NSMutableArray array];
    
    for (NSInteger i = 0; i < self.length; i++) {
        char c = [self characterAtIndex:i];
        NSString *c1 = [NSString stringWithFormat:@"%c",c];
        if ([c1 isEqualToString:@"("]) {
            [arr1 addObject:c1];
        }else if ([c1 isEqualToString:@")"]){
            [arr2 addObject:c1];
        }
    }
    if (arr1.count != arr2.count) {
        return NO;
    }
    return YES;
}
//规则8 小数点前只能是数字
- (BOOL)isArithmetic9{
    NSString *regex = @".*[\\+|\\/|\\-|\\*|(|)|\\.]+[.].*";
    BOOL isValid = [self check:regex];
    return !isValid;
}

//规则8 小数点后只能是数字
- (BOOL)isArithmetic10{
    NSString *regex = @".*[.][\\+|\\/|\\-|\\*|(|)|\\.]+.*";
    BOOL isValid = [self check:regex];
    return !isValid;
}

//数字,正负 小数
- (BOOL)isValidNumber{
    return [self isPoint] || [self isPositive];
}

//正负小数
- (BOOL)isPoint{
    NSString *regex = @"-{0,1}[0-9]+\\.[0-9]+";
    return [self check:regex];
}

//正负正数
- (BOOL)isPositive{
    NSString *regex = @"-{0,1}[0-9]+";
    return [self check:regex];
}
//Zero
- (BOOL)isZero{
    NSString *regex = @"-{0,1}[0]{1,}[.]{0,}[0]{0,}";
    return [self check:regex];
}
@end
