//
//  NSString+Caculate.m
//  tetxgydt
//
//  Created by gl on 2018/3/14.
//  Copyright © 2018年 gl. All rights reserved.
//



#import "NSString+Caculate.h"

@implementation NSString (Caculate)

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
    
    if ([self isEqualToString:@"+"] || [self isEqualToString:@"-"]) {
        return CaculateSymbol_Priority_middle;
    }else if ([self isEqualToString:@"×"] || [self isEqualToString:@"*"] || [self isEqualToString:@"/"] || [self isEqualToString:@"÷"]){
        return CaculateSymbol_Priority_high;
    }else if ([self isEqualToString:@"("] || [self isEqualToString:@")"]){
        return CaculateSymbol_Priority_low;
    }
    return CaculateSymbol_Priority_Error;
}

- (BOOL)isCaculateSymbol{
    
    if ([self isEqualToString:@"+"] || [self isEqualToString:@"-"] || [self isEqualToString:@"×"] || [self isEqualToString:@"*"] || [self isEqualToString:@"/"] || [self isEqualToString:@"÷"] || [self isEqualToString:@"("] || [self isEqualToString:@")"]) {
        return YES;
    }else{
        return NO;
    }
}
@end
