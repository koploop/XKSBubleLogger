//
//  XKSDebugLogger.m
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/24.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import "XKSGeneralLogger.h"
#import "XKSStoreManager.h"
#import "XKSFormatter.h"
#import "XKSNotificationPoster.h"

void XKSVERBOSELog(NSString *message,...) {
    va_list argList;
    va_start(argList, message);
    NSString *content = [[NSString alloc] initWithFormat:message arguments:argList];
    [XKSGeneralLogger verbose:content file:nil function:nil line:0];
    va_end(argList);
}

void XKSINFOLog(NSString *message,...) {
    va_list argList;
    va_start(argList, message);
    NSString *content = [[NSString alloc] initWithFormat:message arguments:argList];
    [XKSGeneralLogger info:content file:nil function:nil line:0];
    va_end(argList);
}

void XKSWARNINGLog(NSString *message,...) {
    va_list argList;
    va_start(argList, message);
    NSString *content = [[NSString alloc] initWithFormat:message arguments:argList];
    [XKSGeneralLogger warning:content file:nil function:nil line:0];
    va_end(argList);
}

void XKSERRORLog(NSString *message,...) {
    va_list argList;
    va_start(argList, message);
    NSString *content = [[NSString alloc] initWithFormat:message arguments:argList];
    [XKSGeneralLogger error:content file:nil function:nil line:0];
    va_end(argList);
}


@interface XKSGeneralLogger ()

@property (nonatomic, strong) XKSStoreManager *store;

@end

@implementation XKSGeneralLogger
@synthesize enable;

static dispatch_queue_t logQueue;
static XKSGeneralLogger *logger = nil;
+ (nonnull instancetype)sharedLogger {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        logger = [[XKSGeneralLogger alloc] init];
        logQueue = dispatch_queue_create("com.generalLog.queue", NULL);
    });
    return logger;
}

#pragma mark - public func
+ (void)verbose:(NSString *)message
           file:(NSString *)file
       function:(NSString *)function
           line:(NSInteger)line
{
    [self handleLogLevel:XKSLogLevel_Verbose
                 message:message
                    file:file
                function:function
                    line:line];
}

+ (void)info:(NSString *)message
        file:(NSString *)file
    function:(NSString *)function
        line:(NSInteger)line
{
    [self handleLogLevel:XKSLogLevel_Info
                 message:message
                    file:file
                function:function
                    line:line];
}

+ (void)warning:(NSString *)message
           file:(NSString *)file
       function:(NSString *)function
           line:(NSInteger)line
{
    [self handleLogLevel:XKSLogLevel_Warning
                 message:message
                    file:file
                function:function
                    line:line];
}

+ (void)error:(NSString *)message
         file:(NSString *)file
     function:(NSString *)function
         line:(NSInteger)line
{
    [self handleLogLevel:XKSLogLevel_Error
                 message:message
                    file:file
                function:function
                    line:line];
}

+ (void)handleLogLevel:(XKSLogLevel)level
               message:(NSString *)message
                  file:(NSString *)file
              function:(NSString *)function
                  line:(int)line
{
    NSString *messageHead = @"";
    if (file) {
        NSString *fileName = [[file componentsSeparatedByString:@"/"] lastObject];
        if (fileName) {
            messageHead = [NSString stringWithFormat:@"%@.%@[%d]", fileName, function, line];
        }
    }
    
    dispatch_async(logQueue, ^{
        XKSGeneralLog *log = [XKSGeneralLog logWithContent:message fileInfo:messageHead level:level];
//        NSAttributedString *attrStr = [XKSFormatter formatLog:log];
//        NSLog(@"%@", attrStr);
        [[XKSGeneralLogger sharedLogger].store addLogs:@[log]];
    });
    
    // 通知XKSBubleView动画展示新的日志
    [XKSNotificationPoster postNotificationType:XKSNotiType_NewLog
                                    messageType:XKSMessageType_UserInfo
                                       logLevel:level];
    // 通知列表刷新
    [XKSNotificationPoster postNotificationType:XKSNotiType_RefreshLogs];
}


#pragma mark - getter
- (XKSStoreManager *)store {
    if (!_store) {
        _store = [XKSStoreManager storeLog:XKSLogType_Log];
    }
    return _store;
}

#pragma mark -setter
- (void)setEnable:(BOOL)enable {
    
}

@end
