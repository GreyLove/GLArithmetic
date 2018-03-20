//
//  GLViewController.m
//  GLArithmetic
//
//  Created by guolei on 03/17/2018.
//  Copyright (c) 2018 guolei. All rights reserved.
//

#import "GLViewController.h"
#import "GLCaculate.h"
@interface GLViewController ()

@end

@implementation GLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString *str = @"2/4*8+(8+2)*4-4+8*1";
    
    //1.
    NSString *b1 = [GLCaculate caculateArithmeticString:str];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
