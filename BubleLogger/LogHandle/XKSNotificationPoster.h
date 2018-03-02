//
//  XKSNotificationPoster.h
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/24.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XKSLogNotificationProtocol.h"

/*
 * 所有的消息通知都通过 XKSNotificationPoster 来发送.
 */

@interface XKSNotificationPoster : NSObject <XKSLogNotificationProtocol>

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)initWithNotificationType:(XKSNotiType)type NS_DESIGNATED_INITIALIZER;
+ (instancetype)posterWithNotificationType:(XKSNotiType)type;

@end
