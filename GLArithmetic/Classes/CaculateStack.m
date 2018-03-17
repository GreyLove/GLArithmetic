//
//  CaculateStack.m
//  tetxgydt
//
//  Created by gl on 2018/3/16.
//  Copyright © 2018年 gl. All rights reserved.
//

#import "CaculateStack.h"

@implementation CaculateStack

+ (Stack*)stack_create{
    Stack *stack = (Stack*)[NSMutableArray array];
    return stack;
}
@end

@implementation NSMutableArray (Caculate)
- (void)stack_push:(id)value{
    if (value) {
        [self addObject:value];
    }
}
- (void)stack_pop{
    if (![self stack_empty]) {
        [self removeLastObject];
    }
}

- (id)stack_top{
    if (![self stack_empty]) {
        return [self lastObject];
    }
    return nil;
}

- (id)stack_bottom{
    if (![self stack_empty]) {
        return [self firstObject];
    }
    return nil;
}

- (NSInteger)stack_size{
    if (![self stack_empty]) {
        return self.count;
    }else{
        return 0;
    }
}

- (BOOL)stack_empty{
    if (self.count>0) {
        return NO;
    }else{
        return YES;
    }
}

- (void)stack_clear{
    [self removeAllObjects];
}

- (void)stack_destory{
    [self removeAllObjects];
}
@end
