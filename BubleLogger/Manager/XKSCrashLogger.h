//
//  XKSCrashLogger.h
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/24.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XKSLoggerProtocol.h"

@interface XKSCrashLogger : NSObject <XKSLoggerProtocol>

/*! 崩溃个数 */
@property (nonatomic, assign) NSInteger crashCount;


+ (nonnull instancetype)sharedLogger;

@end
