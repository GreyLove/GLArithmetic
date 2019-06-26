# GLArithmetic

[![CI Status](http://img.shields.io/travis/guolei/GLArithmetic.svg?style=flat)](https://travis-ci.org/guolei/GLArithmetic)
[![Version](https://img.shields.io/cocoapods/v/GLArithmetic.svg?style=flat)](http://cocoapods.org/pods/GLArithmetic)
[![License](https://img.shields.io/cocoapods/l/GLArithmetic.svg?style=flat)](http://cocoapods.org/pods/GLArithmetic)
[![Platform](https://img.shields.io/cocoapods/p/GLArithmetic.svg?style=flat)](http://cocoapods.org/pods/GLArithmetic)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

GLArithmetic is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'GLArithmetic'
```

## Author

guolei, guolei_coder@126.com

## License

GLArithmetic is available under the MIT license. See the LICENSE file for more info.

# Arithmetic
四则运算
随机表达式生成验证此代码结果正确

```
//计算分数表达式
//errorString:正则判断表达式是否合法，不合法errorString不为nil
+ (NSString*)calculateFraction:(NSString *)infixexp errorString:(NSString **)errorString;
```
```
//分数转小数,拿到+ (NSString*)calculateFraction:(NSString *)infixexp errorString:(NSString **)errorString; 
//计算结果，转化为小数
+ (NSString*)fractionTranslatePoint:(NSString *)fraction;
```
文章：https://www.jianshu.com/p/329b4918fc19

