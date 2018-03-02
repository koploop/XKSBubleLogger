//
//  XKSBubleManager.h
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/22.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKSBubleManager : NSObject

@property (nonatomic, assign) BOOL displayedList;

+ (nonnull instancetype)sharedManager;

- (void)addNetworkLoggerSessionConfig:(NSURLSessionConfiguration* _Nonnull )configuration;

- (void)enable;
- (void)disable;

@end
