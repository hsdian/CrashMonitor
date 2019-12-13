//
//  NSObjectTest.m
//  test12311
//
//  Created by yuangonmg on 2019/12/10.
//  Copyright © 2019 Dian. All rights reserved.
//

#import "NSObjectTest.h"
#import <objc/Runtime.h>
#import "NSObjectSendTest.h"

@implementation NSObjectTest
//- (void)test{
//    NSLog(@"%s", __func__);
//}


//- (id)forwardingTargetForSelector:(SEL)aSelector{
//    if (aSelector == @selector(test)) {
//        return [[NSObjectSendTest alloc]init];
//    }
//    return [super forwardingTargetForSelector:aSelector];
////    return [self forwardingTargetForSelector:aSelector];
//}


//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
//    return [[[NSObjectSendTest alloc]init] methodSignatureForSelector:aSelector];
//}
//
//- (void)forwardInvocation:(NSInvocation *)anInvocation{
//    
//    NSLog(@"啦啦啦");
//    //    [self qpl_forwardInvocation:anInvocation];
//}

@end
