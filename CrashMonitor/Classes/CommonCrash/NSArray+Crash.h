//
//  NSArray+Crash.h
//  AutomobileAccessories
//
//  Created by yuangonmg on 2019/12/9.
//  Copyright © 2019 sensu_nikun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CrashProtocol.h"
///> NSArray
NS_ASSUME_NONNULL_BEGIN
@interface NSArray (Crash)<CrashProtocol>

@end
NS_ASSUME_NONNULL_END



///> NSMutableArray
NS_ASSUME_NONNULL_BEGIN
@interface NSMutableArray (Crash)<CrashProtocol>

@end
NS_ASSUME_NONNULL_END
