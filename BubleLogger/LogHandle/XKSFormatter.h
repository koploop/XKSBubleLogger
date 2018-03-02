//
//  XKSFormatter.h
//  XKSBubleLogger
//
//  Created by SuperMario@lvhan on 2018/2/11.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XKSGeneralLog.h"
#import "XKSNetworkLog.h"

@interface XKSFormatter : NSObject

+ (NSString *)formatterDate:(NSDate *)date;

+ (NSAttributedString *)formatLog:(XKSGeneralLog *)log;

+ (NSAttributedString *)formatNetLog:(XKSNetworkLog *)log;

@end
