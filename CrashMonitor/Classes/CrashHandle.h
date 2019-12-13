//
//  CrashHandle.h
//  test12311
//
//  Created by yuangonmg on 2019/12/13.
//  Copyright © 2019 Dian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^exceptionBlock)(NSDictionary *exception);//点击动作
@interface CrashHandle : NSObject

/**
 * 单利
 */
+ (CrashHandle *)share;


/**
 * 处理所有与崩溃记录并输出在控制台中
 */
+ (void)handleAllCrash;


/**
 * 处理所有与崩溃记录并输出在控制台中
 */
- (void)handleAllCrashWithExceptionBlock:(exceptionBlock )exception;

@end

NS_ASSUME_NONNULL_END
