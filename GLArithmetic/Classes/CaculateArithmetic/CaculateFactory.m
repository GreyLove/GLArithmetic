//
//  CaculateFactory.m
//
//  Created by gl on 2018/3/16.
//  Copyright © 2018年 gl. All rights reserved.
//

#import "CaculateFactory.h"
#import "CaculateAdd.h"
#import "CaculateMinus.h"
#import "CaculateMultiply.h"
#import "CaculateDivide.h"
#import "NSString+Caculate.h"
@implementation CaculateFactory
+ (double)caculateWithNum1:(NSString*)num1
                   num2:(NSString*)num2
         caculateSymbol:(NSString*)symbol{
    double num3 = [num1 doubleValue];
    double num4 = [num2 doubleValue];
    if ([symbol isAddString]) {
        return [CaculateAdd add:num3 b:num4];

    }else if ([symbol isMinusString]){
        return [CaculateMinus minus:num3 b:num4];

    }else if ([symbol isMultiplyString]){
        return [CaculateMultiply multiply:num3 b:num4];

    }else if ([symbol isDivideString]){
        return [CaculateDivide divide:num3 b:num4];
    }
    return -1;
}
@end