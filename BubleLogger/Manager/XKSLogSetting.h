//
//  XKSLogSetting.h
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/24.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKSLogSetting : NSObject

/*! 是否开启网络日志记录 */
@property (nonatomic, assign) BOOL networkLogEnable;
/*! 是否记录系统NSLog日志 */
@property (nonatomic, assign) BOOL overrideSysLog;
/*! 是否启动时重置log */
@property (nonatomic, assign) BOOL resetLogsStart;
/*! 是否显示日志时间 */
@property (nonatomic, assign) BOOL logDateEnable;
/*! 是否显示文件信息 */
@property (nonatomic, assign) BOOL fileNameEnable;




+ (nonnull instancetype)sharedSetting;

@end
