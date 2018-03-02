//
//  XKSRequestProtocol.m
//  XKSBubleLogger
//
//  Created by SuperMario@lvhan on 2018/2/28.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import "XKSRequestProtocol.h"
#import "XKSNetworkLog.h"
#import <objc/runtime.h>
#import "XKSLogSetting.h"
#import "XKSNotificationPoster.h"
#import "XKSNetworkLogger.h"

static NSMutableDictionary *bodyValue;

#pragma mark - extension
//@interface NSMutableURLRequest (BodyHack)
//
//+ (void)httpBodyHackSwizzle;
//+ (void)httpBodyHackSetHttpBody:(NSData *)body;
//
//@end
//
//@implementation NSMutableURLRequest
//
//+ (void)httpBodyHackSwizzle {
//    Method originalMethod = class_getInstanceMethod(self, @selector(setHTTPBody:));
//    Method swizzledMethod = class_getInstanceMethod(self, @selector(httpBodyHackSetHttpBody:));
//    method_exchangeImplementations(originalMethod, swizzledMethod);
//}
//
//+ (void)httpBodyHackSetHttpBody:(NSData *)body {
//    NSString *keyString = @"hashValue";
//    if (body && bodyValue[keyString] == nil) {
//        bodyValue[keyString] = body;
//    }
//
//    [self httpBodyHackSetHttpBody:body];
//}
//@end

#pragma mark - XKSRequestProtocol
@interface XKSRequestProtocol () <NSURLSessionDataDelegate, NSURLSessionTaskDelegate>

@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionTask *sessionTask;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLResponse *response;
@property (nonatomic, strong) NSMutableURLRequest *nRequest;
@property (nonatomic, strong) NSOperationQueue *operationQueue;

@property (nonatomic, strong) XKSNetworkLog *requestLog;

@end


@implementation XKSRequestProtocol

#pragma mark - override

// 是否处理该Request
+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    NSLog(@"Init Request");
    // 使用 propertyForKey:inRequest 防止一个Request被多次拦截处理
    if ([self propertyForKey:@"MyURLProtocolHandledKey" inRequest:request] != nil ||
        ![XKSLogSetting sharedSetting].networkLogEnable) {
        return NO;
    }
    return YES;
}

// 可以在这里修改Request, 比如添加header, 修改host重定向等等
+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

// 判断两个request是否相同,如果相同的话可以使用缓存数据
+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b {
    return [super requestIsCacheEquivalent:a toRequest:b];
}

// 开始请求Request, 可以标示已经请求的Request
- (void)startLoading {
    NSLog(@"Start Loading");
    NSMutableURLRequest *request = [self.request mutableCopy];
    if (!request || _nRequest != nil) {
        return;
    }
    [XKSRequestProtocol setProperty:@(YES) forKey:@"MyURLProtocolHandledKey" inRequest:request];
    [XKSRequestProtocol setProperty:[NSDate date] forKey:@"MyURLProtocolDateKey" inRequest:request];
    self.nRequest = request;
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:self.operationQueue];
    self.sessionTask = [_session dataTaskWithRequest:request];
    [self.sessionTask resume];
    
    self.responseData = [NSMutableData data];
    self.requestLog = [XKSNetworkLog logWithRequest:request];
//    [XKSNotificationPoster postNotificationType:XKSNotiType_NewRequest];
}

// 取消请求Request, 可以标示已经请求的Request
- (void)stopLoading {
    NSLog(@"Stop Loading");
    [_sessionTask cancel];
    if (!self.requestLog) {
        return;
    }
    NSData *data = [self bodyFromRequest:self.request];
    self.requestLog.httpBody = data;
    
    NSDate *startDate = [XKSRequestProtocol propertyForKey:@"MyURLProtocolDateKey" inRequest:_nRequest];
    double duration = fabs(startDate.timeIntervalSinceNow);
    self.requestLog.duration = duration;

    [XKSNetworkLogger requestProtocol:self requestCompletion:self.requestLog];
}

- (NSData *)bodyFromRequest:(NSURLRequest *)request {
    if (request.HTTPBody) {
        return request.HTTPBody;
    }
    
    NSInputStream *stream = request.HTTPBodyStream;
    NSMutableData *data = [NSMutableData data];
    
    [stream open];
    NSInteger result;
    uint8_t buffer[1024];
    
    while (stream.hasBytesAvailable) {
        result = [stream read:buffer maxLength:1024];
        if (result > 0) {
            [data appendBytes:buffer length:result];
        } else {
            NSLog(@"no buffer...!");
        }
    }
    [stream close];
    return data;
}

#pragma mark - NSURLSessionDelegate
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error {
    NSLog(@"session: task: didCompleteWithError");
    if (!error) {
        [self.client URLProtocolDidFinishLoading:self];
        return;
    }
    [self.client URLProtocol:self didFailWithError:error];
    NSString *description = error.localizedDescription;
    self.requestLog.errorClientDescription = description;
}

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error {
    if (error) {
        NSString *description = error.localizedDescription;
        self.requestLog.errorClientDescription = description;
    }
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    NSLog(@"session: dataTask: didReceiveResponse");
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    completionHandler(NSURLSessionResponseAllow);
    
    [self.requestLog codeFromResponse:response];
    if (self.responseData) {
        self.requestLog.dataResponse = self.responseData;
    }
}

// Session处理授权，证书等问题
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    
    // 如果是请求证书信任，我们再来处理，其他的不需要处理
    if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
    }
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    NSLog(@"session: dataTask: didReceiveData");
    [self.client URLProtocol:self didLoadData:data];
    [self.responseData appendData:data];
}


#pragma mark - public
// 是否进行网络请求拦截
+ (void)enableRequestIntercept:(BOOL)intercept {
    if (intercept) {
        [NSURLProtocol registerClass:[XKSRequestProtocol class]];
        return;
    }
    [NSURLProtocol unregisterClass:[XKSRequestProtocol class]];
}

#pragma mark - getter
- (NSOperationQueue *)operationQueue {
    if (!_operationQueue) {
        _operationQueue = [NSOperationQueue new];
        _operationQueue.name = @"com.netlogger.queue";
        _operationQueue.maxConcurrentOperationCount = 1;
    }
    return _operationQueue;
}

@end
