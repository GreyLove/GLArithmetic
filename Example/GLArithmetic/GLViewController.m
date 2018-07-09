//
//  GLViewController.m
//  GLArithmetic
//
//  Created by guolei on 03/17/2018.
//  Copyright (c) 2018 guolei. All rights reserved.
//

#import "GLViewController.h"
#import "OperatorCaculateFraction.h"

@interface Node:NSObject
@property (nonatomic,strong) id father;
@property (nonatomic,strong) id val;
@property (nonatomic,strong) id left;
@property (nonatomic,strong) id right;
@end

@implementation Node

@end

@interface GLViewController ()

@end

@implementation GLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSInteger n = 10000;
    NSMutableArray *arr1 = [NSMutableArray array];
    for (NSInteger i = 0; i < n; i++) {
        Node *node = [self create:5 fatherNode:nil];
        NSMutableArray *arr = [NSMutableArray array];
        [self print:node arr:arr ];
        NSString *tt = [arr componentsJoinedByString:@""];
        [arr1 addObject:tt];
    }

    NSArray *arr = arr1;

//    NSLog(@"%@",arr);
    //
    CFTimeInterval cu = CFAbsoluteTimeGetCurrent();
    for (NSString *exp in arr) {
        NSString *result1;
        NSString *result = [OperatorCaculateFraction calculateFraction:exp errorString:nil];
        result1 = [OperatorCaculateFraction fractionTranslatePoint:result];
//                NSLog(@"%@===%@",result,result1);
        NSLog(@"%@",result1);

    }
    CFTimeInterval cu1 = CFAbsoluteTimeGetCurrent();

    NSLog(@"%f--%f",cu1-cu,(cu1-cu)/n);
    


//    NSString *err = nil;
//    NSString *result = [OperatorCaculateFraction calculateFraction:@"100000000000000000/2/3" errorString:&err];
//
    
}
- (void)print:(Node*)node arr:(NSMutableArray*)arr{
    if (!node) {
        return;
    }
    [self print:node.left arr:arr];
    [arr addObject:node.val];
    [self print:node.right arr:arr];
}

- (Node*)create:(NSInteger)dep fatherNode:(Node*)node1{
    if (dep == 1) {
        Node *node = [[Node alloc] init];
        node.father = node1;
        int x = arc4random() % 1000000;
        int x1 = arc4random() % 1000000;
        NSString *point = arc4random() % 2 ? [NSString stringWithFormat:@"%d.%d",x,x1]:[NSString stringWithFormat:@"%d",x];
        NSString *sym = [self randomStringWithLength1:arc4random() % 2];
        if (sym.length>0) {
            node.val = [NSString stringWithFormat:@"(%@%@)",sym,point];
            
        }else{
            node.val = [NSString stringWithFormat:@"%@",point];
            
        }
        node.left = nil;
        node.right = nil;
        return node;
    }else{
        Node *node = [[Node alloc] init];
        node.val = [self randomStringWithLength:1];
        
        dep--;
        node.father = node1;
        node.left = [self create:dep fatherNode:node];
        node.right = [self create:dep fatherNode:node];
        NSString *ss = [self randomStringWithLength:1];
        if ([node.val isEqualToString:ss]) {
            [self findLeft:node];
            [self findRight:node];
        }
        return node;
    }
}

- (void)findLeft:(Node*)node{
    if (node.left == nil) {
        node.val = [NSString stringWithFormat:@"(%@",node.val];
        return;
    }
    [self findLeft:node.left];
}

- (void)findRight:(Node*)node{
    if (node.right == nil) {
        node.val = [NSString stringWithFormat:@"%@)",node.val];
        return;
    }
    [self findRight:node.right];
}

-(NSString *)randomStringWithLength1:(NSInteger)len {
    NSString *letters = @"-";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (NSInteger i = 0; i < len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((uint32_t)[letters length])]];
    }
    return randomString;
}
-(NSString *)randomStringWithLength:(NSInteger)len {
    NSString *letters = @"+-*/";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (NSInteger i = 0; i < len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((uint32_t)[letters length])]];
    }
    return randomString;
}




@end
