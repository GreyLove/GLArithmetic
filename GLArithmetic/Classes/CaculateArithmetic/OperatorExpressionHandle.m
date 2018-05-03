//
//  OperatorExpressionHandle
//  test
//
//  Created by gl on 2018/4/26.
//  Copyright © 2018年 gl. All rights reserved.
//

#import "OperatorExpressionHandle.h"

@implementation OperatorExpressionHandle

+ (NSArray*)postfixExpWithInfixExp:(NSString*)infixExp{
    if (!infixExp.length) {
        return @[];
    }
    return (NSArray*)[OperatorExpressionHandle getPostfixExpFromInfixExpTo:infixExp];
}

//通过中缀表达式获得后缀表达式
+ (NSMutableArray *)getPostfixExpFromInfixExpTo:(NSString*)infixExp
{
    //中缀表达式转数组
    BOOL preIsNumber = NO;
    char currentChar = ' ';
    NSString *currentStr = @"";
    
    NSMutableArray *infixExpArray = [NSMutableArray array];
    for(NSInteger i = 0; i < infixExp.length; i++) {
        currentChar = [infixExp characterAtIndex:i];
        if(('-'==currentChar && !preIsNumber) || ![self isOperator:currentChar]){
            //当前字符是数字字符（当前字符是负号，前一个字符不是数字，或者不是操作符）
            currentStr = [currentStr stringByAppendingFormat:@"%c", currentChar];
            preIsNumber = YES;
        }else {
            //当前字符是操作符
            //入栈之前的字符串
            if(![currentStr isEqualToString:@""]) {
                [infixExpArray addObject:currentStr];
            }
            //入栈操作符
            [infixExpArray addObject:[NSString stringWithFormat:@"%c", currentChar]];
            //清空
            currentStr = @"";
            if (')' ==currentChar) {
                preIsNumber = YES;
            }else {
                preIsNumber = NO;
            }
        }
    }
    
    if(currentStr.length != 0){
        //最后一个数字串入栈
        [infixExpArray addObject:currentStr];
    }
    
    //中缀表达式数组倒序
    infixExpArray = [NSMutableArray arrayWithArray:[[infixExpArray reverseObjectEnumerator] allObjects]];
    
    NSMutableArray *dealStack = [NSMutableArray array];
    NSMutableArray *posfixExp = [NSMutableArray array];
    while(infixExpArray.count != 0){
        currentStr = infixExpArray.lastObject;
        if([self isNumber:currentStr]) {
            //数字直接加入
            [posfixExp addObject:currentStr];
        }else if([currentStr isEqualToString:@"("]) {
            //左括号入栈
            [dealStack addObject:currentStr];
        }else if([currentStr isEqualToString:@")"]) {
            //右括号，不断弹出操作栈顶，并加入，直到出现（，最后删除（
            if(dealStack.count == 0){
                NSLog(@"%@", @"Expression is wrong...");
                return nil;
            }else{
                while(![dealStack.lastObject isEqualToString:@"("]){
                    [posfixExp addObject:dealStack.lastObject];
                    [dealStack removeLastObject];
                    if(dealStack.count == 0){
                        NSLog(@"%@", @"Expression is wrong...");
                        return nil;
                    }
                }
                if([dealStack.lastObject isEqualToString:@"("]){
                    [dealStack removeLastObject];
                }
            }
        }else if ( [self isCaculaOperator:currentStr] ){
            //是操作符，栈顶操作符不是（且优先级高于或等于当前，则不断弹出
            while (dealStack.lastObject != nil && ![dealStack.lastObject isEqualToString:@"("] &&
                   [self compareOperator1:dealStack.lastObject Operator2:currentStr] != OperatorPriorityLower) {
                [posfixExp addObject:dealStack.lastObject];
                [dealStack removeLastObject];
            }
            [dealStack addObject:currentStr];
        }
        [infixExpArray removeLastObject];
    }
    while(dealStack.count != 0){
        if([dealStack.lastObject isEqualToString:@"(" ]){
            NSLog(@"%@", @"Expression is wrong...");
            return nil;
        }
        [posfixExp addObject:dealStack.lastObject];
        [dealStack removeLastObject];
    }
    
    return posfixExp;
}

//判断是否是操作符
+ (BOOL)isOperator:(char)anOperator
{
    return ('+' == anOperator
            ||  '-' == anOperator
            ||  '*' == anOperator
            ||  '/' == anOperator
            ||  '^' == anOperator
            ||  '(' == anOperator
            ||  ')' == anOperator);
}

//判断是否是数字
+ (BOOL)isNumber:(NSString*)numberStr;
{
    return !([numberStr isEqualToString:@"+"]
             || [numberStr isEqualToString:@"^"]
             || [numberStr isEqualToString:@"-"]
             || [numberStr isEqualToString:@"*"]
             || [numberStr isEqualToString:@"/"]
             || [numberStr isEqualToString:@")"]
             || [numberStr isEqualToString:@"("]
             || [numberStr isEqualToString:@"="]);
}
//判断是否是运算符
+ (BOOL)isCaculaOperator:(NSString*)operatorStr
{
    return ([operatorStr isEqualToString:@"+"]
            ||  [operatorStr isEqualToString:@"^"]
            ||  [operatorStr isEqualToString:@"-"]
            ||  [operatorStr isEqualToString:@"*"]
            ||  [operatorStr isEqualToString:@"/"]);
}

//比较操作符优先级
+ (OperatorPriority)compareOperator1:(NSString*)operator1 Operator2:(NSString*)operator2
{
    if([operator1 isEqualToString:@"^"]){
        if( [operator2 isEqualToString:@"^" ]){
            return OperatorPriorityEqual;
        }else if([operator2 isEqualToString:@"*"]
                 || [operator2 isEqualToString:@"/"]
                 || [operator2 isEqualToString:@"+"]
                 || [operator2 isEqualToString:@"-"]){
            return OperatorPriorityHigher;
        }else{
            return OperatorPriorityError;
        }
    }else if([operator1 isEqualToString:@"*"]
             || [operator1 isEqualToString:@"/"]){
        if([operator2 isEqualToString:@"^"]){
            return OperatorPriorityLower;
        }else if([operator2 isEqualToString:@"*"]
                 || [operator2 isEqualToString:@"/" ]){
            return OperatorPriorityEqual;
        }else if([operator2 isEqualToString:@"+"]
                 || [operator2 isEqualToString:@"-" ]){
            return OperatorPriorityHigher;
        }else{
            return OperatorPriorityError;
        }
    }else if([operator1 isEqualToString:@"+" ]
             || [operator1 isEqualToString:@"-" ]) {
        if([operator2 isEqualToString:@"^" ]
           || [operator2 isEqualToString:@"*"]
           || [operator2 isEqualToString:@"/" ]) {
            return OperatorPriorityLower;
        } else if([operator2 isEqualToString:@"+"]
                  || [operator2 isEqualToString:@"-" ]) {
            return OperatorPriorityEqual;
        } else {
            return OperatorPriorityError;
        }
    }else{
        return OperatorPriorityError;
    }
}

@end
