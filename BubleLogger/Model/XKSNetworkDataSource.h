//
//  XKSNetworkDataSource.h
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/25.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XKSNetworkLog.h"

@interface XKSNetworkDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, strong) NSArray<XKSNetworkLog*> *dataSource;

- (void)reloadData;
- (void)clearData;

@end
