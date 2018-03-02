//
//  XKSNetworkLog.m
//  XKSBubleLogger
//
//  Created by SuperMario@lvhan on 2018/2/28.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import "XKSNetworkLog.h"

@implementation XKSNetworkLog

+ (XKSNetworkLog *)logWithRequest:(NSURLRequest *)request {
    return [[self alloc] initWithRequest:request];
}

- (instancetype)initWithRequest:(NSURLRequest *)request {
    self = [super init];
    if (self) {
        self.type = XKSLogType_Network;
        self.logID = [NSUUID UUID].UUIDString;
        self.date = [NSDate date];
        self.code = 0;
        self.method = request.HTTPMethod ?: @"N/A";
        self.url = request.URL.absoluteString ?: @"N/A";
        self.headers = request.allHTTPHeaderFields;
        self.httpBody = request.HTTPBody;
    }
    return self;
}

- (void)codeFromResponse:(NSURLResponse *)response {
    if (![response isKindOfClass:[NSHTTPURLResponse class]]) {
        return;
    }
    self.code = [(NSHTTPURLResponse*)response statusCode];
}

#pragma mark - getter
- (UIColor *)codeColor {
    if (200 <= self.code && self.code <= 299) {
        return [UIColor greenColor];
    }
    if (300 <= self.code && self.code <= 399) {
        return [UIColor cyanColor];
    }
    if (400 <= self.code && self.code <= 499) {
        return [UIColor orangeColor];
    }
    if (500 <= self.code && self.code <= 599) {
        return [UIColor redColor];
    }
    return [UIColor grayColor];
}

#pragma mark - NSCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.url = [aDecoder decodeObjectForKey:@"url"];
        self.method = [aDecoder decodeObjectForKey:@"method"];
        self.errorClientDescription = [aDecoder decodeObjectForKey:@"errorClientDescription"];
        self.headers = [aDecoder decodeObjectForKey:@"headers"];
        self.dataResponse = [aDecoder decodeObjectForKey:@"dataResponse"];
        self.httpBody = [aDecoder decodeObjectForKey:@"httpBody"];
        
        self.code = [aDecoder decodeIntegerForKey:@"code"];
        self.duration = [aDecoder decodeFloatForKey:@"duration"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.url forKey:@"url"];
    [aCoder encodeObject:self.method forKey:@"method"];
    [aCoder encodeObject:self.errorClientDescription forKey:@"errorClientDescription"];
    [aCoder encodeObject:self.headers forKey:@"headers"];
    [aCoder encodeObject:self.dataResponse forKey:@"dataResponse"];
    [aCoder encodeObject:self.httpBody forKey:@"httpBody"];
    
    [aCoder encodeInteger:self.code forKey:@"code"];
    [aCoder encodeDouble:self.duration forKey:@"duration"];
}

@end
