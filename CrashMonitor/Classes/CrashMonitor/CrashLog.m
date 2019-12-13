//
//  CrashLog.m
//  test12311
//
//  Created by yuangonmg on 2019/12/12.
//  Copyright © 2019 Dian. All rights reserved.
//

#import "CrashLog.h"


@implementation CrashLog
+ (void)noteErrorWithException:(NSException *)exception defaultToDo:(NSString *)defaultToDo {
    
    //堆栈数据
    NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
    
    //获取在哪个类的哪个方法中实例化的数组  字符串格式 -[类名 方法名]  或者 +[类名 方法名]
    NSString *mainCallStackSymbolMsg = [CrashLog getMainCallStackSymbolMessageWithCallStackSymbols:callStackSymbolsArr];
    
    if (mainCallStackSymbolMsg == nil) {
        
        mainCallStackSymbolMsg = @"崩溃方法定位失败,请您查看函数调用栈来排查错误原因";
        
    }
    
    NSString *errorName = exception.name;
    NSString *errorReason = exception.reason;
    //errorReason 可能为 -[__NSCFConstantString CrashCharacterAtIndex:]: Range or index out of bounds
    //将Crash去掉
    errorReason = [errorReason stringByReplacingOccurrencesOfString:@"Crash" withString:@""];
    
    NSString *errorPlace = [NSString stringWithFormat:@"Error Place:%@",mainCallStackSymbolMsg];
    
    NSString *logErrorMessage = [NSString stringWithFormat:@"\n\n%@\n\n%@\n%@\n%@\n%@",CrashSeparatorWithFlag, errorName, errorReason, errorPlace, defaultToDo];
    
    logErrorMessage = [NSString stringWithFormat:@"%@\n\n%@\n\n",logErrorMessage,CrashSeparator];
    CrashNSLog(@"%@",logErrorMessage);
    
    
    //请忽略下面的赋值，目的只是为了能顺利上传到cocoapods
    logErrorMessage = logErrorMessage;
    
    NSDictionary *errorInfoDic = @{
                                   @"errorName"        : errorName,
                                   @"errorReason"      : errorReason,
                                   @"errorPlace"       : errorPlace,
                                   @"defaultToDo"      : defaultToDo,
                                   @"exception"        : exception,
                                   @"callStackSymbols" : callStackSymbolsArr
                                   };
    
    //将错误信息放在字典里，用通知的形式发送出去
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"%@", [NSThread currentThread]);
        [[NSNotificationCenter defaultCenter] postNotificationName:CrashNotification object:nil userInfo:errorInfoDic];
    });
}




/**
 *  获取堆栈主要崩溃精简化的信息<根据正则表达式匹配出来>
 *
 *  @param callStackSymbols 堆栈主要崩溃信息
 *
 *  @return 堆栈主要崩溃精简化的信息
 */

+ (NSString *)getMainCallStackSymbolMessageWithCallStackSymbols:(NSArray<NSString *> *)callStackSymbols {
    
    //mainCallStackSymbolMsg的格式为   +[类名 方法名]  或者 -[类名 方法名]
    __block NSString *mainCallStackSymbolMsg = nil;
    
    //匹配出来的格式为 +[类名 方法名]  或者 -[类名 方法名]
    NSString *regularExpStr = @"[-\\+]\\[.+\\]";
    
    
    NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:regularExpStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    
    for (int index = 2; index < callStackSymbols.count; index++) {
        NSString *callStackSymbol = callStackSymbols[index];
        
        [regularExp enumerateMatchesInString:callStackSymbol options:NSMatchingReportProgress range:NSMakeRange(0, callStackSymbol.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            if (result) {
                NSString* tempCallStackSymbolMsg = [callStackSymbol substringWithRange:result.range];
                
                //get className
                NSString *className = [tempCallStackSymbolMsg componentsSeparatedByString:@" "].firstObject;
                className = [className componentsSeparatedByString:@"["].lastObject;
                
                NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(className)];
                
                //filter category and system class
                if (![className hasSuffix:@")"] && bundle == [NSBundle mainBundle]) {
                    mainCallStackSymbolMsg = tempCallStackSymbolMsg;
                    
                }
                *stop = YES;
            }
        }];
        
        if (mainCallStackSymbolMsg.length) {
            break;
        }
    }
    
    return mainCallStackSymbolMsg;
}


@end
