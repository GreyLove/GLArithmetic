//
//  CaculateDivide.m
//  tetxgydt
//
//  Created by gl on 2018/3/14.
//  Copyright © 2018年 gl. All rights reserved.
//

#import "CaculateDivide.h"

@implementation CaculateDivide
+ (double)divide:(double)num1 b:(double)num2{
    if (num2 == 0) {
        return -1;
    }
    return num1/num2;
}

@end
