//
//  ViewController.m
//  IUMethodSwizzleDemo
//
//  Created by admin on 2017/2/13.
//  Copyright © 2017年 刘海文. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+IUMethodSwizzle.h"

@interface Father : NSObject

@end

@implementation Father

- (void)call {
    NSLog(@"father call");
}

@end

@interface Son : Father

@end

@implementation Son

+ (void)load {
    [self swizzleInstanceSelector:@selector(call) toSelector:@selector(_call)];
}

- (void)_call {
    [self _call];
    NSLog(@"son call");
}

@end

@interface Grandson : Son

@end

@implementation Grandson

+ (void)load {
    [self swizzleInstanceSelector:@selector(call) toSelector:@selector(__call)];
}

- (void)__call {
    [self __call];
    NSLog(@"grandson call");
}

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"---start call father---");
    [[Father new] call];
    NSLog(@"---end call father---");
    
    NSLog(@"---start call Son---");
    [[Son new] call];
    NSLog(@"---end call Son---");

    NSLog(@"---start call Grandson---");
    [[Grandson new] call];
    NSLog(@"---end call Grandson---");
}

@end
