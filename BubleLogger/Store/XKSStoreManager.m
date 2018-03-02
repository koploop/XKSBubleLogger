//
//  XKSStoreManager.m
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/26.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import "XKSStoreManager.h"

@interface XKSStoreManager ()

@property (nonatomic, assign) XKSLogType logType;

@end

@implementation XKSStoreManager

- (instancetype)initWithStoreLogType:(XKSLogType)type {
    self = [super init];
    if (self) {
        self.logType = type;
    }
    return self;
}

+ (instancetype)storeLog:(XKSLogType)type {
    return [[self alloc] initWithStoreLogType:type];
}

#pragma mark -
NSString* rawValueOfLogType(XKSLogType type) {
    switch (type) {
        case XKSLogType_Log:
            return @"logs";
        case XKSLogType_Network:
            return @"networks";
        case XKSLogType_Crash:
            return @"crashs";
    }
}

#pragma mark - public func
- (NSMutableArray *)typeLogs {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:rawValueOfLogType(self.logType)];
    if (!data) {
        return [NSMutableArray array];
    }
    NSArray* logs = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return [NSMutableArray arrayWithArray:logs];
}

- (void)archiveLogs:(NSArray<XKSLog*> *)logs {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:logs];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:rawValueOfLogType(self.logType)];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)addLogs:(NSArray<XKSLog*> *)logs {
    NSMutableArray *tempLogs = [self typeLogs];
    [tempLogs addObjectsFromArray:logs];
    [self archiveLogs:tempLogs];
}

- (void)clearLogs {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:rawValueOfLogType(self.logType)];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)clearAllTypeLogs {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:rawValueOfLogType(XKSLogType_Log)];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:rawValueOfLogType(XKSLogType_Network)];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:rawValueOfLogType(XKSLogType_Crash)];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSArray<XKSLog*> *)allOfTypeLogs {
    NSMutableArray *arr = [NSMutableArray array];
    
    NSData *logData = [[NSUserDefaults standardUserDefaults] objectForKey:rawValueOfLogType(XKSLogType_Log)];
    NSData *networkData = [[NSUserDefaults standardUserDefaults] objectForKey:rawValueOfLogType(XKSLogType_Network)];
    NSData *crashData = [[NSUserDefaults standardUserDefaults] objectForKey:rawValueOfLogType(XKSLogType_Crash)];
    
    NSArray* logs = [NSKeyedUnarchiver unarchiveObjectWithData:logData];
    NSArray* networks = [NSKeyedUnarchiver unarchiveObjectWithData:networkData];
    NSArray* crashs = [NSKeyedUnarchiver unarchiveObjectWithData:crashData];
    
    [arr addObjectsFromArray:logs];
    [arr addObjectsFromArray:networks];
    [arr addObjectsFromArray:crashs];
    return [NSArray arrayWithArray:arr];
}



@end
