//
//  XKSCrashLogger.m
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/24.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import "XKSCrashLogger.h"
#import "XKSStoreManager.h"

@interface XKSCrashLogger ()

@property (nonatomic, strong) XKSStoreManager *store;

@end

@implementation XKSCrashLogger
@synthesize enable;

static XKSCrashLogger *logger = nil;
+ (nonnull instancetype)sharedLogger {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        logger = [[XKSCrashLogger alloc] init];
    });
    return logger;
}


#pragma mark - getter
- (XKSStoreManager *)store {
    if (!_store) {
        _store = [XKSStoreManager storeLog:XKSLogType_Crash];
    }
    return _store;
}

@end
