//
//  XKSStoreManager.h
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/26.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XKSLog.h"

@interface XKSStoreManager : NSObject

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)storeLog:(XKSLogType)type;
- (instancetype)initWithStoreLogType:(XKSLogType)type NS_DESIGNATED_INITIALIZER;

#pragma mark -
- (NSMutableArray *)typeLogs;
- (void)addLogs:(NSArray<XKSLog*> *)logs;
- (void)clearLogs;
- (void)archiveLogs:(NSArray<XKSLog*> *)logs;

+ (void)clearAllTypeLogs;
+ (NSArray<XKSLog*> *)allOfTypeLogs;

#pragma mark -
FOUNDATION_EXPORT NSString* rawValueOfLogType(XKSLogType type);

@end
