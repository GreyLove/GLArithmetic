#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "CaculateAdd.h"
#import "CaculateDivide.h"
#import "CaculateFactory.h"
#import "CaculateMinus.h"
#import "CaculateMultiply.h"
#import "CaculateSymbolString.h"
#import "CaculateStack.h"
#import "GLCaculate.h"
#import "NSString+Caculate.h"

FOUNDATION_EXPORT double GLArithmeticVersionNumber;
FOUNDATION_EXPORT const unsigned char GLArithmeticVersionString[];

