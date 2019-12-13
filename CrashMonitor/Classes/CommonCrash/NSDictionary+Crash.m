//
//  NSDictionary+Crash.m
//  AutomobileAccessories
//
//  Created by yuangonmg on 2019/12/9.
//  Copyright © 2019 sensu_nikun. All rights reserved.
//

#import "NSDictionary+Crash.h"
#import <objc/runtime.h>
#import "CrashLog.h"

/**
 * NSDictionary
 */
@implementation NSDictionary (Crash)
//#if NULLSAFE_ENABLED
///> 方法交换
//+ (void)load {
+ (void)crashExchangeMethod{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getClassMethod(self, @selector(dictionaryWithObjects:forKeys:count:));
        Method swizzledMethod = class_getClassMethod(self, @selector(qpl_dictionaryWithObjects:forKeys:count:));
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

///> dictionaryWithObjects实现
+ (id)qpl_dictionaryWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt{
    
    id object = nil;
    @try {
        object = [self qpl_dictionaryWithObjects:objects forKeys:keys count:cnt];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = @"id - default is to remove nil key-values and instance a dictionary.";
        [CrashLog noteErrorWithException:exception defaultToDo:defaultToDo];
        
        id safeObjects[cnt];
        id safeKeys[cnt];
        NSUInteger j = 0;
        for (NSUInteger i = 0; i < cnt; i ++) {
            id key = keys[i];
            id obj = objects[i];
            if (!key || !obj) {
                continue;
            }
            safeKeys[j] = key;
            safeObjects[j] = obj;
            j ++;
        }
        return [self qpl_dictionaryWithObjects:safeObjects forKeys:safeKeys count:j];
        
    }
    @finally {
        return object;
    }
    
    
}

///> instancetype
- (instancetype)qpl_dictionaryWithObjects:(const id [])objects forKeys:(const id <NSCopying> [])keys count:(NSUInteger)cnt {
    
    
    
    id object = nil;
    @try {
        object = [self qpl_dictionaryWithObjects:objects forKeys:keys count:cnt];
    }
    @catch (NSException *exception) {
        
        NSString *defaultToDo = @"instancetype - default is to remove nil key-values and instance a dictionary.";
        [CrashLog noteErrorWithException:exception defaultToDo:defaultToDo];
        
        id safeObjs[cnt];
        id safeKeys[cnt];
        NSUInteger j = 0;
        for (NSUInteger i = 0; i < cnt; i ++) {
            if (!objects[i] || !keys[i]) {
                continue;
            }
            safeObjs[j++] = objects[i];
            safeKeys[j++] = keys[i];
        }
        return [self qpl_dictionaryWithObjects:safeObjs forKeys:safeKeys count:j];
    }
    @finally {
        return object;
    }
    
}
//#endif
@end


/**
 * NSMutableDictionary
 */
@implementation NSMutableDictionary (Crash)

//#if NULLSAFE_ENABLED
//+ (void)load{
+ (void)crashExchangeMethod{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = NSClassFromString(@"__NSDictionaryM");
        Method method1 = class_getInstanceMethod(cls, @selector(setObject:forKeyedSubscript:));
        Method method2 = class_getInstanceMethod(cls, @selector(qpl_setObject:forKeyedSubscript:));
        method_exchangeImplementations(method1, method2);
        
        Class cls2 = NSClassFromString(@"__NSDictionaryI");
        Method method3 = class_getInstanceMethod(cls2, @selector(objectForKeyedSubscript:));
        Method method4 = class_getInstanceMethod(cls2, @selector(qpl_objectForKeyedSubscript:));
        method_exchangeImplementations(method3, method4);
    });
}

- (void)qpl_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key{
    @try {
        [self qpl_setObject:obj forKeyedSubscript:key];
    }
    @catch (NSException *exception) {
        [CrashLog noteErrorWithException:exception defaultToDo:CrashDefaultIgnore];
    }
    @finally {
        
    }
    
}

- (id)qpl_objectForKeyedSubscript:(id)key{
    id object = nil;
    @try {
        object = [self qpl_objectForKeyedSubscript:key];
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
