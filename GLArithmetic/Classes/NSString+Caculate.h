//
//  NSString+Caculate.h
//  tetxgydt
//
//  Created by gl on 2018/3/14.
//  Copyright © 2018年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    CaculateSymbol_Priority_Error = -1,
    CaculateSymbol_Priority_low = 1,
    CaculateSymbol_Priority_middle,
    CaculateSymbol_Priority_high,
} CaculateSymbol_Priority;

@interface NSString (Caculate)
- (NSArray*)analysisCaculate;
- (CaculateSymbol_Priority)caculateSymbolPriority;
- (BOOL)isCaculateSymbol;
@end
