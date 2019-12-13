//
//  CrashLog.h
//  test12311
//
//  Created by yuangonmg on 2019/12/12.
//  Copyright © 2019 Dian. All rights reserved.
//

#import <Foundation/Foundation.h>


#define CrashDefaultIgnore     @"default is to ignore this operation to crash."
#define CrashDefaultReturnNil  @"default is to return nil to crash."



#define CrashNotification @"CrashNotification"

#define CrashSeparatorWithFlag @"==========================❌Crash Log❌============================="
#define CrashSeparator         @"===================================================================="
#define CrashLog(...) NSLog(@"%@",[NSString stringWithFormat:__VA_ARGS__])

NS_ASSUME_NONNULL_BEGIN

@interface CrashLog : NSObject
+ (void)noteErrorWithException:(NSException *)exception defaultToDo:(NSString *)defaultToDo;
@end

NS_ASSUME_NONNULL_END
