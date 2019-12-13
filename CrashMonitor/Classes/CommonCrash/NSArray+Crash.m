//
//  NSArray+Crash.m
//  AutomobileAccessories
//
//  Created by yuangonmg on 2019/12/9.
//  Copyright © 2019 sensu_nikun. All rights reserved.
//

#import "NSArray+Crash.h"
#import <objc/runtime.h>
#import "CrashLog.h"

/**
 * NSArray
 */
@implementation NSArray (Crash)
//#if NULLSAFE_ENABLED
//+ (void)load {
+ (void)crashExchangeMethod{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originMethod = class_getClassMethod([NSArray class], @selector(arrayWithObjects:count:));
        Method alterMethod = class_getClassMethod([NSArray class], @selector(qpl_arrayWithObjects:count:));
        method_exchangeImplementations(originMethod, alterMethod);
        
        ///> __NSArray0
        Method originArr0ObjectAtIndexMethod = class_getInstanceMethod(NSClassFromString(@"__NSArray0"), @selector(objectAtIndex:));
        Method alterArr0ObjectAtIndexMethod = class_getInstanceMethod(NSClassFromString(@"__NSArray0"), @selector(qpl_arr0ObjectAtIndex:));
        method_exchangeImplementations(originArr0ObjectAtIndexMethod, alterArr0ObjectAtIndexMethod);
        
        ///> __NSSingleObjectArrayI
        Method originSingleObjArrIObjectAtIndexMethod = class_getInstanceMethod(NSClassFromString(@"__NSSingleObjectArrayI"), @selector(objectAtIndex:));
        Method alterSingleObjArrIObjectAtIndexMethod = class_getInstanceMethod(NSClassFromString(@"__NSSingleObjectArrayI"), @selector(qpl_singleObjArrIObjectAtIndex:));
        method_exchangeImplementations(originSingleObjArrIObjectAtIndexMethod, alterSingleObjArrIObjectAtIndexMethod);
        
        ///> __NSArrayI
        Method originArrIObjAtIndexedSubMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayI"), @selector(objectAtIndexedSubscript:));
        Method alterArrIObjAtIndexedSubMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayI"), @selector(qpl_arrIObjAtIndexedSubscript:));
        method_exchangeImplementations(originArrIObjAtIndexedSubMethod, alterArrIObjAtIndexedSubMethod);
    });
}

+ (instancetype)qpl_arrayWithObjects:(const id _Nonnull [_Nonnull])objects count:(NSUInteger)cnt {
    id instance = nil;
    id safeObjs[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i ++) {
        if (!objects[i]) {
            continue;
        }
        safeObjs[j++] = objects[i];
    }
    instance = [self qpl_arrayWithObjects:safeObjs count:j];
    return instance;
}

- (id)qpl_arr0ObjectAtIndex:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self qpl_arr0ObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = CrashDefaultReturnNil;
        [CrashLog noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}

- (id)qpl_arrIObjAtIndexedSubscript:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self qpl_arrIObjAtIndexedSubscript:index];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = CrashDefaultReturnNil;
        [CrashLog noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}

- (id)qpl_singleObjArrIObjectAtIndex:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self qpl_singleObjArrIObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = CrashDefaultReturnNil;
        [CrashLog noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}
//#endif
@end





/**
 * NSMutableArray
 */
@implementation NSMutableArray (Crash)
//#if NULLSAFE_ENABLED || NULLARRAY_ENABLED
//+ (void)load {
+ (void)crashExchangeMethod{

    Class __NSArrayMClass = NSClassFromString(@"__NSArrayM");
    
    Method originInsertObjAtIndexMethod = class_getInstanceMethod(__NSArrayMClass, @selector(insertObject:atIndex:));
    Method alterInsertObjAtIndexMethod = class_getInstanceMethod(__NSArrayMClass, @selector(qpl_insertObject:atIndex:));
    method_exchangeImplementations(originInsertObjAtIndexMethod, alterInsertObjAtIndexMethod);
    
    Method originObjAtIndexedSubMethod = class_getInstanceMethod(__NSArrayMClass, @selector(objectAtIndexedSubscript:));
    Method alterObjAtIndexedSubMethod = class_getInstanceMethod(__NSArrayMClass, @selector(qpl_arrMObjAtIndexedSubscript:));
    method_exchangeImplementations(originObjAtIndexedSubMethod, alterObjAtIndexedSubMethod);
}

- (void)qpl_insertObject:(id)obj atIndex:(NSUInteger)index {
    @try {
        [self qpl_insertObject:obj atIndex:index];
    }
    @catch (NSException *exception) {
        [CrashLog noteErrorWithException:exception defaultToDo:CrashDefaultIgnore];
    }
    @finally {
        
    }
}

- (id)qpl_arrMObjAtIndexedSubscript:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self qpl_arrMObjAtIndexedSubscript:index];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = CrashDefaultReturnNil;
        [CrashLog noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
    
}
//#endif
@end


