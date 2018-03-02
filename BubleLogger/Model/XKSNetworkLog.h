//
//  XKSNetworkLog.h
//  XKSBubleLogger
//
//  Created by SuperMario@lvhan on 2018/2/28.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XKSLog.h"

@interface XKSNetworkLog : XKSLog

@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *method;
@property (nonatomic, copy) NSString *errorClientDescription;

@property (nonatomic, strong) NSDictionary *headers;
@property (nonatomic, strong) NSData *httpBody;
@property (nonatomic, strong) NSData *dataResponse;

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, assign) double duration;

// getter
@property (nonatomic, strong) UIColor *codeColor;


+ (XKSNetworkLog *)logWithRequest:(NSURLRequest *)request;

- (void)codeFromResponse:(NSURLResponse *)response;

@end
