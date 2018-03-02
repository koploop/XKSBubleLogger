//
//  XKSLogListDataSource.h
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/25.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XKSGeneralLog.h"
#import "XKSStoreManager.h"

@interface XKSLogListDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, strong) NSArray<XKSGeneralLog*> *dataSource;


- (void)reloadData;
- (void)clearData;

- (void)scrollViewDidEnd:(UITableView *)tableView;


@end
