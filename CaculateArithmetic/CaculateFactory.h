//
//  CaculateFactory.h
//
//  Created by gl on 2018/3/16.
//  Copyright © 2018年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaculateFactory : NSObject
+ (double)caculateWithNum1:(NSString*)num1
                      num2:(NSString*)num2
            caculateSymbol:(NSString*)symbol;
@end
