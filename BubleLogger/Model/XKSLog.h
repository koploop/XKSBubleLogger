//
//  XKSLog.h
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/23.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 消息通知类型
 
 - XKSNotiType_NewLog: 产生新日志
 - XKSNotiType_RefreshLogs: 刷新日志通知
 - XKSNotiType_SettingsChanged: 设置改变通知
 - XKSNotiType_ResetCountBadge: 重置消息个数角标
 - XKSNotiType_NewRequest: 产生新请求
 - XKSNotiType_StopRequest: 结束请求
 */
typedef NS_ENUM(NSUInteger, XKSNotiType) {
    XKSNotiType_NewLog,
    XKSNotiType_RefreshLogs,
    XKSNotiType_SettingsChanged,
    XKSNotiType_ResetCountBadge,
    XKSNotiType_NewRequest,
    XKSNotiType_StopRequest
};

/**
 日志级别
 
 - XKSLogLevel_Verbose: VERBOSE
 - XKSLogLevel_Info: INFO
 - XKSLogLevel_Warning: WARNING
 - XKSLogLevel_Error: ERROR
 */
typedef NS_ENUM(NSUInteger, XKSLogLevel) {
    XKSLogLevel_Verbose = 1 << 0,
    XKSLogLevel_Info    = 1 << 1,
    XKSLogLevel_Warning = 1 << 2,
    XKSLogLevel_Error   = 1 << 3
};

/**
 消息中附带参数类型
 
 - XKSMessageType_UserInfo: 有值
 - XKSMessageType_Void: 无附加参数
 */
typedef NS_ENUM(NSUInteger, XKSMessageType) {
    XKSMessageType_UserInfo,
    XKSMessageType_Void
};


/**
 日志类型

 - XKSLogType_Log: 普通日志
 - XKSLogType_Network: 网络日志
 - XKSLogType_Crash: 崩溃日志
 */
typedef NS_ENUM(NSUInteger, XKSLogType) {
    XKSLogType_Log = 0,
    XKSLogType_Network,
    XKSLogType_Crash
};

typedef void(^NotificationBlock)(NSString* _Nullable content);


@interface XKSLog : NSObject <NSCoding>

@property (nonatomic, assign) XKSLogType type;
@property (nonatomic, copy, nullable) NSString* logID;
@property (nonatomic, strong, nullable) NSDate *date;

@end





