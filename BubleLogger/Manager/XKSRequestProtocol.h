//
//  XKSRequestProtocol.h
//  XKSBubleLogger
//
//  Created by SuperMario@lvhan on 2018/2/28.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XKSNetworkLog.h"

typedef void(^RequestCompletionHandler)(XKSNetworkLog *log);

@interface XKSRequestProtocol : NSURLProtocol

// 是否进行网络请求拦截
+ (void)enableRequestIntercept:(BOOL)intercept;

@end
