//
//  XKSLog.m
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/23.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import "XKSLog.h"


@implementation XKSLog

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    self.logID = [aDecoder decodeObjectForKey:@"logID"];
    self.date = [aDecoder decodeObjectForKey:@"date"];
    self.type = [aDecoder decodeIntegerForKey:@"type"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:self.type forKey:@"type"];
    [aCoder encodeObject:self.logID forKey:@"logID"];
    [aCoder encodeObject:self.date forKey:@"date"];
}

@end
