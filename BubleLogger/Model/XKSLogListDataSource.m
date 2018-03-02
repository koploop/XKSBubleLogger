//
//  XKSLogListDataSource.m
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/25.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import "XKSLogListDataSource.h"
#import "XKSLogTableViewCell.h"

@interface XKSLogListDataSource ()

@property (nonatomic, strong) XKSStoreManager *store;

@end

@implementation XKSLogListDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        self.store = [XKSStoreManager storeLog:XKSLogType_Log];
    }
    return self;
}

#pragma mark - public
- (void)reloadData {
    self.dataSource = [self.store typeLogs];
}

- (void)clearData {
    [self.store clearLogs];
}

- (void)scrollViewDidEnd:(UITableView *)tableView {
    for (XKSLogTableViewCell *cell in tableView.visibleCells) {
        NSIndexPath *indexPath = [tableView indexPathForCell:cell];
        [cell configureCell:self.dataSource[indexPath.row]];
    }
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XKSLogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"logCell" forIndexPath:indexPath];
    if (tableView.dragging == NO && tableView.decelerating == NO) {
        [cell configureCell:self.dataSource[indexPath.row]];
    }
    return cell;
}

@end
