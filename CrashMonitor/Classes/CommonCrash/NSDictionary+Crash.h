//
//  NSDictionary+Crash.h
//  AutomobileAccessories
//
//  Created by yuangonmg on 2019/12/9.
//  Copyright © 2019 sensu_nikun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CrashProtocol.h"
///> NSDictionary
NS_ASSUME_NONNULL_BEGIN
@interface NSDictionary (Crash)<CrashProtocol>

@end
NS_ASSUME_NONNULL_END


///> NSMutableDictionary
NS_ASSUME_NONNULL_BEGIN
@interface NSMutableDictionary (Crash)<CrashProtocol>

@end
NS_ASSUME_NONNULL_END
