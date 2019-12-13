//
//  NSObject+Crash.m
//  AutomobileAccessories
//
//  Created by yuangonmg on 2019/12/9.
//  Copyright © 2019 sensu_nikun. All rights reserved.
//

#import "NSObject+Crash.h"
#import <objc/Runtime.h>
#import "CrashLog.h"

static NSArray *respondClasses;
@implementation NSObject (Crash)


//+ (void)load{
+ (void)crashExchangeMethod{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method method3 = class_getInstanceMethod(NSClassFromString(@"NSObject"), @selector(methodSignatureForSelector:));
        Method method4 = class_getInstanceMethod(NSClassFromString(@"NSObject"), @selector(qpl_methodSignatureForSelector:));
        method_exchangeImplementations(method3, method4);
        
        Method method5 = class_getInstanceMethod(NSClassFromString(@"NSObject"), @selector(forwardInvocation:));
        Method method6 = class_getInstanceMethod(NSClassFromString(@"NSObject"), @selector(qpl_forwardInvocation:));
        method_exchangeImplementations(method5, method6);
    });
}


- (NSMethodSignature *)qpl_methodSignatureForSelector:(SEL)aSelector{
    NSMethodSignature *signature = [self qpl_methodSignatureForSelector:aSelector];
    if (!signature) {
        Class responededClass = [self qpl_responedClassForSelector:aSelector];
        if (responededClass) {
            @try {
                signature = [responededClass instanceMethodSignatureForSelector:aSelector];
            } @catch (NSException *exception) {
                signature = [NSMethodSignature signatureWithObjCTypes:"v@:"];
            }@finally {
                
            }
        }else{
            signature = [NSMethodSignature signatureWithObjCTypes:"v@:"];
        }
    }
    return signature;
}

- (void)qpl_forwardInvocation:(NSInvocation *)anInvocation{
    @try {
        [self qpl_forwardInvocation:anInvocation];
    } @catch (NSException *exception) {
        ///> 数据错误上报
        NSString *defaultToDo = CrashDefaultIgnore;
        [CrashLog noteErrorWithException:exception defaultToDo:defaultToDo];
    } @finally {
        
    }
}

- (Class)qpl_responedClassForSelector:(SEL)selector {

    respondClasses = @[
                       [NSMutableArray class],
                       [NSMutableDictionary class],
                       [NSMutableString class],
                       [NSNumber class],
                       [NSDate class],
                       [NSData class]
                       ];
    for (Class someClass in respondClasses) {
        if ([someClass instancesRespondToSelector:selector]) {
            return someClass;
        }
    }
    return nil;
}



@end
