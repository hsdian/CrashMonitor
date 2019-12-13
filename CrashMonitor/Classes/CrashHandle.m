//
//  CrashHandle.m
//  test12311
//
//  Created by yuangonmg on 2019/12/13.
//  Copyright © 2019 Dian. All rights reserved.
//

#import "CrashHandle.h"
#import "NSArray+Crash.h"
#import "NSDictionary+Crash.h"
#import "NSObject+Crash.h"
#import "CrashLog.h"



@interface CrashHandle()
@property (nonatomic, copy) exceptionBlock exception;

@end

@implementation CrashHandle


/**
 * share
 * @return CrashHandle
 */
+ (CrashHandle *)share{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void)handleAllCrash{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject crashExchangeMethod];
        [NSArray crashExchangeMethod];
        
        [NSMutableArray crashExchangeMethod];
        
        [NSDictionary crashExchangeMethod];
        [NSMutableDictionary crashExchangeMethod];
    });
}

- (void)handleAllCrashWithExceptionBlock:(exceptionBlock)exception{
    [CrashHandle handleAllCrash];
    self.exception = exception;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleException:) name:CrashNotification object:nil];
}

- (void)handleException:(NSNotification *)noti{
    NSLog(@"%@", [NSThread currentThread]);
    if (self.exception) {
        self.exception(noti.userInfo);
    }
}




@end
