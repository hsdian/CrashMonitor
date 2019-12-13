//
//  OpenerHandle.h
//  CrashMonitor
//
//  Created by yuangonmg on 2019/12/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OpenerHandle : NSObject
/**
 * 进程创建的时间
 * 作为app冷启动开始时间
 */
+ (NSTimeInterval)processStartTime;
@end

NS_ASSUME_NONNULL_END
