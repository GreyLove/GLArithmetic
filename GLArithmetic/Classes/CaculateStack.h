//
//  CaculateStack.h//
//  Created by gl on 2018/3/16.
//  Copyright © 2018年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 Stack *stack = [CaculateStack stack_create];
 [stack stack_push:arr[0]];
 [stack stack_push:arr[1]];
 [stack stack_push:arr[2]];
 
 [stack stack_pop];
 NSString *bottom = [stack stack_bottom];
 NSString *top = [stack stack_top];
 
 [stack stack_clear];
 BOOL is = [stack stack_empty];
 */
typedef NSMutableArray Stack;

@interface CaculateStack : NSObject

+ (Stack*)stack_create;

@end

@interface NSMutableArray (Caculate)
- (void)stack_push:(id)value;
- (void)stack_pop;

- (id)stack_top;
- (id)stack_bottom;

- (NSInteger)stack_size;

- (BOOL)stack_empty;
- (void)stack_clear;
- (void)stack_destory;
@end
