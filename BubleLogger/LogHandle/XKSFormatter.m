//
//  XKSFormatter.m
//  XKSBubleLogger
//
//  Created by SuperMario@lvhan on 2018/2/11.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import "XKSFormatter.h"
#import "XKSLogSetting.h"
#import "UIColor+Buble.h"


@implementation XKSFormatter

/*
 NSDateFormatter的创建比较耗时,应该缓存;
 */
static NSDateFormatter *__formatter;
+ (NSDateFormatter *)formatter {
    if (!__formatter) {
        __formatter = [[NSDateFormatter alloc] init];
        __formatter.timeZone = [NSTimeZone systemTimeZone];
        __formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    return __formatter;
}

+ (NSString *)formatterDate:(NSDate *)date {
    return [[self formatter] stringFromDate:date];
}

+ (NSAttributedString *)formatLog:(XKSGeneralLog *)log {
    
    NSMutableString *content = [NSMutableString new];
    // 时间
    NSMutableString *dateStr = [NSMutableString string];
    if (log.date && [XKSLogSetting sharedSetting].logDateEnable) {
        dateStr = [[self formatterDate:log.date] mutableCopy];
        [dateStr appendString:@"\n"];
        [content appendString:dateStr];
    }
    // 文件信息
    NSMutableString *fileName = [log.fileInfo mutableCopy];
    if (fileName && [XKSLogSetting sharedSetting].fileNameEnable) {
        [fileName appendString:@"  "];
        [content appendString:fileName];
    }
    // 日志内容
    [content appendString:log.logContent];
    
    // 设置attribute属性
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:content];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:[UIColor blackColor]
                       range:NSMakeRange(0, content.length)];
    
    [attrString addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:14]
                       range:NSMakeRange(0, content.length)];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 4;// 行间距
    [attrString addAttribute:NSParagraphStyleAttributeName
                       value:paragraphStyle
                       range:NSMakeRange(0, content.length)];
    
    
    if (log.date && [XKSLogSetting sharedSetting].logDateEnable) {
        [attrString addAttribute:NSForegroundColorAttributeName
                           value:[UIColor mainColor]
                           range:NSMakeRange(0, dateStr.length)];
        [attrString addAttribute:NSFontAttributeName
                           value:[UIFont boldSystemFontOfSize:12]
                           range:NSMakeRange(0, dateStr.length)];
    }
    
    if (fileName && [XKSLogSetting sharedSetting].fileNameEnable) {
        [attrString addAttribute:NSForegroundColorAttributeName
                           value:[UIColor grayColor]
                           range:NSMakeRange(dateStr.length, fileName.length)];
        [attrString addAttribute:NSFontAttributeName
                           value:[UIFont boldSystemFontOfSize:12]
                           range:NSMakeRange(dateStr.length, fileName.length)];
    }
    
    return [[NSAttributedString alloc] initWithAttributedString:attrString];
}

+ (NSAttributedString *)formatNetLog:(XKSNetworkLog *)log {
    
    NSMutableString *content = [NSMutableString new];
    // method
    NSString *methodString = [NSString stringWithFormat:@"[%@] [",log.method];
    [content appendString:methodString];
    // status
    NSString *statusCode = [NSString stringWithFormat:@"%d", log.code];
    [content appendString:statusCode];
    // 括号
    NSString *rightParentheses = @"] ";
    [content appendString:rightParentheses];
    // Url
    [content appendString:log.url];
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:content];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:[UIColor grayColor]
                       range:NSMakeRange(0, content.length)];
    [attrString addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:12]
                       range:NSMakeRange(0, content.length)];
    
//    [attrString addAttribute:NSForegroundColorAttributeName
//                       value:log.codeColor
//                       range:NSMakeRange(methodString.length, statusCode.length)];
    
    NSUInteger location = methodString.length + statusCode.length + rightParentheses.length;
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:[UIColor blackColor]
                       range:NSMakeRange(location, log.url.length)];
    [attrString addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:16]
                       range:NSMakeRange(location, log.url.length)];
    
    return attrString;
}







@end
