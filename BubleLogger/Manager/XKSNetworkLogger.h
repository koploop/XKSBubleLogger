//
//  XKSNetworkLogger.h
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/24.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XKSLoggerProtocol.h"
#import "XKSNetworkLog.h"
#import "XKSRequestProtocol.h"


@interface XKSNetworkLogger : NSObject <XKSLoggerProtocol>

+ (instancetype)sharedLogger;

+ (void)requestProtocol:(XKSRequestProtocol *)protocol requestCompletion:(XKSNetworkLog *)log;

@end
