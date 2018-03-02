//
//  XKSNotificationObserver.h
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/23.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XKSLogNotificationProtocol.h"


@interface XKSNotificationObserver : NSObject


/**
 生成一个特定类型的观察者

 @param type 收到的消息通知参数类型
 @param notification 消息发送方<包含了观察者监听的 notificationName>
 @param notificationBlock 收到消息通知
 @return 生成观察者
 */
+ (instancetype)observerWithMessageType:(XKSMessageType)type
                           notification:(id<XKSLogNotificationProtocol>)notification
                      notificationBlock:(NotificationBlock)notificationBlock;

@end
