//
//  XKSGeneralLog.h
//  XKSBubleLogger
//
//  Created by SuperMario@lvhan on 2018/3/1.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import "XKSLog.h"

@interface XKSGeneralLog : XKSLog

@property (nonatomic, assign) XKSLogLevel level;
@property (nonatomic, copy, nullable) NSString* logContent;
@property (nonatomic, copy, nullable) NSString* fileInfo;

+ (XKSGeneralLog* _Nonnull)logWithContent:(NSString* _Nonnull)content
                                 fileInfo:(NSString* _Nullable)fileInfo
                                    level:(XKSLogLevel)level;

+ (NSString* _Nonnull)textOfLoglevel:(XKSLogLevel)level;

+ (UIColor* _Nonnull)colorOfLoglevel:(XKSLogLevel)level;

@end
