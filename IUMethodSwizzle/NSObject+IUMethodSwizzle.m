//
//  NSObject+IUMethodSwizzle.m
//  IUMethodSwizzle
//
//  Created by admin on 2017/2/9.
//  Copyright © 2017年 刘海文. All rights reserved.
//

#import "NSObject+IUMethodSwizzle.h"
#import <objc/runtime.h>

@implementation NSObject (IUMethodSwizzle)

+ (void)swizzleInstanceSelector:(SEL)fromSelector toSelector:(SEL)toSelector {
    Method fromMethod = class_getInstanceMethod(self, fromSelector);
    NSAssert(fromMethod, @"%@ instance method not implemented : %@", NSStringFromClass(self), NSStringFromSelector(fromSelector));
    
    Method toMethod = class_getInstanceMethod(self, toSelector);
    NSAssert(toMethod, @"%@ instance method not implemented : %@", NSStringFromClass(self), NSStringFromSelector(toSelector));
    
    class_addMethod(self, fromSelector, [[self superclass] instanceMethodForSelector:fromSelector], method_getTypeEncoding(fromMethod));
    method_exchangeImplementations(class_getInstanceMethod(self, fromSelector), toMethod);
}

+ (void)swizzleClassSelector:(SEL)fromSelector toSelector:(SEL)toSelector {
    Method fromMethod = class_getClassMethod(self, fromSelector);
    NSAssert(fromMethod, @"%@ class method not implemented : %@", NSStringFromClass(self), NSStringFromSelector(fromSelector));
    
    Method toMethod = class_getClassMethod(self, toSelector);
    NSAssert(toMethod, @"%@ class method not implemented : %@", NSStringFromClass(self), NSStringFromSelector(toSelector));
    
    class_addMethod(self, fromSelector, [[self superclass] methodForSelector:fromSelector], method_getTypeEncoding(fromMethod));
    method_exchangeImplementations(class_getClassMethod(self, fromSelector), toMethod);
}

@end
