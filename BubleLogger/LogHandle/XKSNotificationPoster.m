//
//  XKSNotificationPoster.m
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/24.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import "XKSNotificationPoster.h"
#import "XKSGeneralLog.h"

@implementation XKSNotificationPoster
@synthesize notificationName;
@synthesize notificationType;


+ (instancetype)posterWithNotificationType:(XKSNotiType)type {
    return [[self alloc] initWithNotificationType:type];
}

- (instancetype)init {
    self = [self initWithNotificationType:XKSNotiType_NewLog];
    return self;
}

- (instancetype)initWithNotificationType:(XKSNotiType)type {
    self = [super init];
    if(self) {
        self.notificationType = type;
    }
    return self;
}

- (NSString *)notificationName {
    switch (self.notificationType) {
        case XKSNotiType_NewLog:
            return @"newLogs";
        case XKSNotiType_RefreshLogs:
            return @"refreshLogs";
        case XKSNotiType_SettingsChanged:
            return @"settingsChanged";
        case XKSNotiType_ResetCountBadge:
            return @"resetCountBadge";
        case XKSNotiType_NewRequest:
            return @"newRequest";
        case XKSNotiType_StopRequest:
            return @"stopRequest";
        default:
            break;
    }
}

#pragma mark - XKSLogNotificationProtocol

+ (void)postNotificationType:(XKSNotiType)notificationType
                 messageType:(XKSMessageType)messageType
                    logLevel:(XKSLogLevel)logLevel {
    
    if(messageType == XKSMessageType_Void) {
        [self postNotificationType:notificationType];
        return;
    }
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    NSString *userInfoValue = [XKSGeneralLog textOfLoglevel:logLevel];
    NSDictionary *userInfo = @{@"value": userInfoValue};
    [center postNotificationName:[self notificationName:notificationType] object:nil userInfo:userInfo];
}

+ (void)postNotificationType:(XKSNotiType)notificationType {
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:[self notificationName:notificationType] object:nil userInfo:nil];
}

+ (NSString *)notificationName:(XKSNotiType)type {
    switch (type) {
        case XKSNotiType_NewLog:
            return @"newLogs";
        case XKSNotiType_RefreshLogs:
            return @"refreshLogs";
        case XKSNotiType_SettingsChanged:
            return @"settingsChanged";
        case XKSNotiType_ResetCountBadge:
            return @"resetCountBadge";
        case XKSNotiType_NewRequest:
            return @"newRequest";
        case XKSNotiType_StopRequest:
            return @"stopRequest";
        default:
            break;
    }
}

@end
