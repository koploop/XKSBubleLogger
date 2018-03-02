//
//  XKSLogNotificationProtocol.h
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/22.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XKSLog.h"


@protocol XKSLogNotificationProtocol <NSObject>

@property (nonatomic, copy) NSString* notificationName;

@property (nonatomic, assign) XKSNotiType notificationType;


/**
 发送消息通知

 @param notificationType 监听的消息类型
 @param messageType 是否存在消息附加值
 @param logLevel 日志Level
 */
+ (void)postNotificationType:(XKSNotiType)notificationType
                 messageType:(XKSMessageType)messageType
                    logLevel:(XKSLogLevel)logLevel;


/**
 发送一个不附带任何信息的通知

 @param notificationType 监听的消息类型
 */
+ (void)postNotificationType:(XKSNotiType)notificationType;

@end
