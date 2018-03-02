//
//  XKSNotificationObserver.m
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/23.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import "XKSNotificationObserver.h"

@implementation XKSNotificationObserver

+ (instancetype)observerWithMessageType:(XKSMessageType)type
                           notification:(id<XKSLogNotificationProtocol>)notification
                      notificationBlock:(NotificationBlock)notificationBlock {
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    NSString *name = notification.notificationName;
    id<NSObject> observer = [center addObserverForName:name object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        
        NSDictionary *userInfo = note.userInfo;
        if(type == XKSMessageType_UserInfo) {
            if(!userInfo[@"value"]) {
                notificationBlock(nil);
                return;
            }
            notificationBlock(userInfo[@"value"]);
        }
        notificationBlock(nil);
    }];
    return observer;
}

@end
