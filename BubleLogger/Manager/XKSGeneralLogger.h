//
//  XKSDebugLogger.h
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/24.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XKSLoggerProtocol.h"

/*
 Use for save simple log without function and line output
 */
FOUNDATION_EXPORT void XKSVERBOSELog(NSString *message,...) NS_FORMAT_FUNCTION(1,2);
FOUNDATION_EXPORT void XKSINFOLog(NSString *message,...) NS_FORMAT_FUNCTION(1,2);
FOUNDATION_EXPORT void XKSWARNINGLog(NSString *message,...) NS_FORMAT_FUNCTION(1,2);
FOUNDATION_EXPORT void XKSERRORLog(NSString *message,...) NS_FORMAT_FUNCTION(1,2);


/*
 Use for save the complete log info
 */
#define XKSVEROSE(message, ...)                                                     \
    [XKSGeneralLogger verbose: [NSString stringWithFormat: message, ##__VA_ARGS__]  \
                         file: [NSString stringWithUTF8String:__FILE__]             \
                     function: [NSString stringWithUTF8String:__FUNCTION__]         \
                         line: __LINE__]

#define XKSINFO(message, ...)                                                       \
    [XKSGeneralLogger info: [NSString stringWithFormat: message, ##__VA_ARGS__]     \
    file: [NSString stringWithUTF8String:__FILE__]                                  \
    function: [NSString stringWithUTF8String:__FUNCTION__]                          \
    line: __LINE__]

#define XKSWARNING(message, ...)                                                    \
    [XKSGeneralLogger warning: [NSString stringWithFormat: message, ##__VA_ARGS__]  \
    file: [NSString stringWithUTF8String:__FILE__]                                  \
    function: [NSString stringWithUTF8String:__FUNCTION__]                          \
    line: __LINE__]

#define XKSERROR(message, ...)                                                      \
    [XKSGeneralLogger error: [NSString stringWithFormat: message, ##__VA_ARGS__]    \
    file: [NSString stringWithUTF8String:__FILE__]                                  \
    function: [NSString stringWithUTF8String:__FUNCTION__]                          \
    line: __LINE__]


@interface XKSGeneralLogger : NSObject <XKSLoggerProtocol>

+ (instancetype)sharedLogger;

#pragma mark - prepare for save log
+ (void)verbose:(NSString *)message file:(NSString *)file function:(NSString *)function line:(NSInteger)line;
+ (void)info:(NSString *)message file:(NSString *)file function:(NSString *)function line:(NSInteger)line;
+ (void)warning:(NSString *)message file:(NSString *)file function:(NSString *)function line:(NSInteger)line;
+ (void)error:(NSString *)message file:(NSString *)file function:(NSString *)function line:(NSInteger)line;

@end
