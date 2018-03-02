//
//  XKSLogListViewController.h
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/25.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKSLog.h"

@interface XKSLogListViewController : UIViewController

- (void)resetLogType:(XKSLogType)logType;

- (void)clearLogs;

@end
