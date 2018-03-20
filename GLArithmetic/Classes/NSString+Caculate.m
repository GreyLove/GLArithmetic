//
//  NSString+Caculate.m
//
//  Created by gl on 2018/3/14.
//  Copyright © 2018年 gl. All rights reserved.
//



#import "NSString+Caculate.h"
#import "CaculateSymbolString.h"

@implementation NSString (Caculate)

- (BOOL)legalCaculate{
    NSArray *arr = [self analysisCaculate];
    NSString *preStr = @"$";
    for (NSString *str in arr) {
        if (![preStr isEqualToString:@"str"]) {
            preStr = str;
        }else{
            if (![str isLeftBracketString] || ![str isRightBracketString]) {
                return NO;
            }
        }
    }
    return YES;
}


- (NSArray*)analysisCaculate{
    NSMutableArray *mutableArray = [NSMutableArray array];
    NSMutableString *mutableString = [NSMutableString string];
    for (NSInteger i = 0; i < self.length; i++) {
        NSString *a = [NSString stringWithFormat:@"%c",[self characterAtIndex:i]];
        if ([a isCaculateSymbol]) {
            if (mutableString.length) {
                [mutableArray addObject:mutableString];
            }
            [mutableArray addObject:a];
            mutableString = nil;
            mutableString = [NSMutableString string];
        }else{
            [mutableString appendString:a];
        }
    }
    if (mutableString.length) {
        [mutableArray addObject:mutableString];
    }
    mutableString = nil;
    
    return (NSArray*)mutableArray;
}


- (CaculateSymbol_Priority)caculateSymbolPriority{
    
    if (![self isCaculateSymbol]) {
        return CaculateSymbol_Priority_Error;
    }
    
    if ([self isAddString] || [self isMinusString])
    {
        return CaculateSymbol_Priority_middle;
    }
    else if ([self isMultiplyString] || [self isDivideString])
    {
        return CaculateSymbol_Priority_high;
    }
    else if ([self isLeftBracketString] || [self isRightBracketString])
    {
        return CaculateSymbol_Priority_low;
    }
    return CaculateSymbol_Priority_Error;
}

- (BOOL)isCaculateSymbol{
    
    if ([self isAddString]
        || [self isMinusString]
        || [self isDivideString]
        || [self isMultiplyString]
        || [self isLeftBracketString]
        || [self isRightBracketString]) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark --
- (BOOL)isAddString{
    return [self isEqualToString:caculateSymbolString_add];
}
- (BOOL)isMinusString{
    return [self isEqualToString:caculateSymbolString_minus];
}
- (BOOL)isDivideString{
    return [self isEqualToString:caculateSymbolString_divide] || [self isEqualToString:caculateSymbolString_divide1];
}
- (BOOL)isMultiplyString{
    return [self isEqualToString:caculateSymbolString_multiply] || [self isEqualToString:caculateSymbolString_multiply1];
}
- (BOOL)isLeftBracketString{
    return [self isEqualToString:caculateSymbolString_leftBracket];
}
- (BOOL)isRightBracketString{
    return [self isEqualToString:caculateSymbolString_rightBracket];
}

- (BOOL)isAddOrMinusString{
    return [self isAddString] || [self isMinusString];
}
- (BOOL)isMultiplyOrDivideString{
    return [self isMultiplyString] || [self isDivideString];
}

@end
