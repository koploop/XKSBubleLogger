//
//  XKSBubleManager.m
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/22.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKSBubleManager.h"
#import "XKSBubleWindow.h"
#import "XKSBubleViewController.h"
#import "XKSCrashLogger.h"
#import "XKSNetworkLogger.h"
#import "XKSGeneralLogger.h"
#import "XKSLogSetting.h"
#import "XKSStoreManager.h"
#import "XKSRequestProtocol.h"

@interface XKSBubleManager () <ManagerWindowDelegate>

@property (nonatomic, strong) XKSBubleWindow* window;
@property (nonatomic, strong) XKSBubleViewController* controller;
@property (nonatomic, strong) NSCache<NSObject*, NSObject*>* cache;

@end

@implementation XKSBubleManager

static XKSBubleManager *manager = nil;
+ (nonnull instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XKSBubleManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if(self) {
        self.window = [[XKSBubleWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return self;
}

- (void)enable {
    [self initLogsManager];
    self.window.rootViewController = self.controller;
    [self.window makeKeyAndVisible];
    self.window.delegate = self;
    XKSNetworkLogger.sharedLogger.enable = [XKSLogSetting sharedSetting].networkLogEnable;
    XKSGeneralLogger.sharedLogger.enable = YES;
    XKSCrashLogger.sharedLogger.enable = YES;
}

- (void)disable {
    self.window.rootViewController = nil;
    [self.window resignKeyWindow];
    [self.window removeFromSuperview];
    XKSNetworkLogger.sharedLogger.enable = NO;
    XKSGeneralLogger.sharedLogger.enable = NO;
    XKSCrashLogger.sharedLogger.enable = NO;
}

- (void)addNetworkLoggerSessionConfig:(NSURLSessionConfiguration* )configuration {
    if (configuration.protocolClasses) {
        NSMutableArray *array = [configuration.protocolClasses mutableCopy];
        [array insertObject:[XKSRequestProtocol class] atIndex:0];
        configuration.protocolClasses = [NSArray arrayWithArray: array];
    }
}

#pragma mark - func
- (void)initLogsManager {
    if (XKSLogSetting.sharedSetting.resetLogsStart) {
        [[XKSStoreManager storeLog:XKSLogType_Log] clearLogs];
        [[XKSStoreManager storeLog:XKSLogType_Network] clearLogs];
    }
}

#pragma mark - ManagerWindowDelegate
- (BOOL)isPointEvent:(CGPoint)point {
    return [self.controller shouldReceiveAtPoint:point];
}

#pragma mark - getter
- (XKSBubleViewController *)controller {
    if (!_controller) {
        _controller = [[XKSBubleViewController alloc] init];
    }
    return _controller;
}

@end
