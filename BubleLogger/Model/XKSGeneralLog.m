//
//  XKSGeneralLog.m
//  XKSBubleLogger
//
//  Created by SuperMario@lvhan on 2018/3/1.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import "XKSGeneralLog.h"
#import "UIColor+Buble.h"

@implementation XKSGeneralLog

+ (XKSGeneralLog* _Nonnull)logWithContent:(NSString* _Nonnull)content
                                 fileInfo:(NSString* _Nullable)fileInfo
                                    level:(XKSLogLevel)level {
    return [[self alloc] initWithContent:content fileInfo:fileInfo level:level];
}

- (instancetype)initWithContent:(NSString* _Nonnull)content
                       fileInfo:(NSString* _Nullable)fileInfo
                          level:(XKSLogLevel)level {
    self = [super init];
    if (self) {
        self.type = XKSLogType_Log;
        self.logID = [NSUUID UUID].UUIDString;
        self.date = [NSDate date];
        self.logContent = content;
        self.fileInfo = fileInfo;
        self.level = level;
    }
    return self;
}

#pragma mark - helper
+ (NSString * _Nonnull )textOfLoglevel:(XKSLogLevel)level {
    switch (level) {
        case XKSLogLevel_Error:
            return @"🚫";
        case XKSLogLevel_Warning:
            return @"⚠️";
        case XKSLogLevel_Verbose:
            return @"✳️";
        case XKSLogLevel_Info:
            return @"🛠";
        default:
            break;
    }
}

+ (UIColor* _Nonnull)colorOfLoglevel:(XKSLogLevel)level {
    switch (level) {
        case XKSLogLevel_Verbose:
            return [UIColor lightGrayColor];
        case XKSLogLevel_Info:
            return [UIColor cyanColor];
        case XKSLogLevel_Warning:
            return [UIColor yellowColor];
        case XKSLogLevel_Error:
            return [UIColor redColor];
        default:
            break;
    }
}

#pragma mark - NSCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.level = [aDecoder decodeIntegerForKey:@"level"];
        self.logContent = [aDecoder decodeObjectForKey:@"logContent"];
        self.fileInfo = [aDecoder decodeObjectForKey:@"fileInfo"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeInteger:self.level forKey:@"level"];
    [aCoder encodeObject:self.logContent forKey:@"logContent"];
    [aCoder encodeObject:self.fileInfo forKey:@"fileInfo"];
}

@end
