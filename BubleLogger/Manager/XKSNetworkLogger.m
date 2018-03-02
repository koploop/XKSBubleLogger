//
//  XKSNetworkLogger.m
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/24.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import "XKSNetworkLogger.h"
#import "XKSStoreManager.h"
#import "XKSFormatter.h"
#import "XKSNotificationPoster.h"

@interface XKSNetworkLogger ()

@property (nonatomic, strong) XKSStoreManager *store;

@end

@implementation XKSNetworkLogger
@synthesize enable;

static dispatch_queue_t logQueue;
static XKSNetworkLogger *logger = nil;
+ (nonnull instancetype)sharedLogger {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        logger = [[XKSNetworkLogger alloc] init];
        logQueue = dispatch_queue_create("com.networkLog.queue", NULL);
    });
    return logger;
}

+ (void)requestProtocol:(XKSRequestProtocol *)protocol requestCompletion:(XKSNetworkLog *)log {
    dispatch_async(logQueue, ^{
        [[XKSNetworkLogger sharedLogger].store addLogs:@[log]];
    });
    
    [XKSNotificationPoster postNotificationType:XKSNotiType_NewRequest];
    [XKSNotificationPoster postNotificationType:XKSNotiType_RefreshLogs];
}

#pragma mark - getter
- (XKSStoreManager *)store {
    if (!_store) {
        _store = [XKSStoreManager storeLog:XKSLogType_Network];
    }
    return _store;
}

#pragma mark -setter
- (void)setEnable:(BOOL)enable {
    [XKSRequestProtocol enableRequestIntercept:enable];
}

@end
