//
//  XKSLogSetting.m
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/24.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import "XKSLogSetting.h"
#import "XKSBubleFunction.h"

@implementation XKSLogSetting

static XKSLogSetting *setting = nil;
+ (nonnull instancetype)sharedSetting {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        setting = [[XKSLogSetting alloc] init];
    });
    return setting;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        if (![self applicationFirstLaunch]) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            self.networkLogEnable = [userDefaults boolForKey:@"networkLogEnable"];
            self.overrideSysLog = [userDefaults boolForKey:@"overrideSysLog"];
            self.resetLogsStart = [userDefaults boolForKey:@"resetLogsStart"];
            self.logDateEnable = [userDefaults boolForKey:@"logDateEnable"];
            self.fileNameEnable = [userDefaults boolForKey:@"fileNameEnable"];
        }
    }
    return self;
}

- (BOOL)applicationFirstLaunch {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults stringForKey:@"firstLaunchKey"]) {
        self.networkLogEnable = YES;
        self.overrideSysLog = YES;
        self.resetLogsStart = YES;
        self.logDateEnable = YES;
        self.fileNameEnable = YES;
        [userDefaults setObject:@"firstLaunchValue" forKey:@"firstLaunchKey"];
        return YES;
    }
    return NO;
}

#pragma mark - setter
- (void)setNetworkLogEnable:(BOOL)networkLogEnable {
    _networkLogEnable = networkLogEnable;
    [[NSUserDefaults standardUserDefaults] setBool:networkLogEnable forKey:@"networkLogEnable"];
}
- (void)setOverrideSysLog:(BOOL)overrideSysLog {
    _overrideSysLog = overrideSysLog;
    [[NSUserDefaults standardUserDefaults] setBool:overrideSysLog forKey:@"overrideSysLog"];
}
- (void)setResetLogsStart:(BOOL)resetLogsStart {
    _resetLogsStart = resetLogsStart;
    [[NSUserDefaults standardUserDefaults] setBool:resetLogsStart forKey:@"resetLogsStart"];
}
- (void)setLogDateEnable:(BOOL)logDateEnable {
    _logDateEnable = logDateEnable;
    [[NSUserDefaults standardUserDefaults] setBool:logDateEnable forKey:@"logDateEnable"];
}
- (void)setFileNameEnable:(BOOL)fileNameEnable {
    _fileNameEnable = fileNameEnable;
    [[NSUserDefaults standardUserDefaults] setBool:fileNameEnable forKey:@"fileNameEnable"];
}

@end
