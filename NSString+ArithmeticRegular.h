//
//  NSString+ArithmeticRegular.h
//  正则表达式
//
//  Created by gl on 2018/3/22.
//  Copyright © 2018年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ArithmeticRegular)
- (BOOL)isValidArithmetic;
- (BOOL)isValidArithmeticWithErrorString:(NSString**)errorString;

- (BOOL)isValidNumber;
- (BOOL)isZero;

@end
