//
//  TFCaculate.m
//
//  Created by gl on 2018/3/17.
//  Copyright © 2018年 gl. All rights reserved.
//

#import "GLCaculate.h"
#import "CaculateStack.h"
#import "CaculateFactory.h"
@implementation GLCaculate
//计算四则运算
+ (NSString*)caculateArithmeticString:(NSString*)str{
    NSArray *arr = [str analysisCaculate];
    return [self caculateArithmeticArray:arr];
}
//计算四则运算
+ (NSString*)caculateArithmeticArray:(NSArray*)arr{
    return [self caculteSuffixExpression:[self infixExpressionToSuffixExpression:arr]];
}

//中缀转后缀
+ (NSArray*)infixExpressionToSuffixExpression:(NSArray *)arr{
    if (!arr.count) {
        return nil;
    }
    Stack *stack = [CaculateStack stack_create];
    NSMutableArray *newArr = [NSMutableArray array];
    for (NSInteger i = 0; i < arr.count; i++) {
        NSString *str = arr[i];
        if ([str isCaculateSymbol]) {//是符号
            if ([str isEqualToString:@")"]) {//是右括号“）”
                while (![[stack stack_top] isEqualToString:@"("]) { //弹栈直到遇见“（”
                    if (![[stack stack_top] isEqualToString:@"("]
                        || ![[stack stack_top] isEqualToString:@")"]) {
                        [newArr addObject:[stack stack_top]];//
                    }
                    [stack stack_pop];
                }
                if ([[stack stack_top] isEqualToString:@"("]) {
                    [stack stack_pop];
                }
                
                
            }else{//入栈
                if ([str isEqualToString:@"("]) {
                    [stack stack_push:str];
                }else{
                    while ([str caculateSymbolPriority] <= [[stack stack_top] caculateSymbolPriority] && [[stack stack_top] isCaculateSymbol]
                           && ![[stack stack_top] isEqualToString:@"("])
                    {//弹出所有优先级大于或者等于该运算符的栈顶元素，然后将该运算符入栈
                        [newArr addObject:[stack stack_top]];
                        [stack stack_pop];
                    }
                    [stack stack_push:str];
                }
                
            }
        }else{//不是符号
            [newArr addObject:str];
        }
    }
    //栈不为空
    while (![stack stack_empty]) {
        NSString *top = [stack stack_top];//取出栈顶元素
        [newArr addObject:top];
        [stack stack_pop];
    }
    
    NSLog(@"newArr--%@&&&stack--%@",newArr,stack);
    return (NSArray*)newArr;
}


//计算caculteSuffixExpression
+ (NSString*)caculteSuffixExpression:(NSArray*)arr{
    if (!arr.count) {
        return nil;
    }
    Stack *stack = [CaculateStack stack_create];
    
    for (NSInteger i = 0; i < arr.count; i++) {
        NSString *str = arr[i];
        
        if ([str isCaculateSymbol]) {
            if ([stack stack_size]>=2) {
                NSString *num1 = [stack stack_top];
                [stack stack_pop];
                NSString *num2 = [stack stack_top];
                [stack stack_pop];
                double result = [CaculateFactory caculateWithNum1:num2 num2:num1 caculateSymbol:str];
                NSString *result1 = [NSString stringWithFormat:@"%.03f",result];
                [stack stack_push:result1];
            }
        }else{
            [stack stack_push:str];
        }
    }
    NSString * b = [stack stack_bottom];
    
    return b;
}
@end
