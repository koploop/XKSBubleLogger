//
//  XKSNetworkDataSource.m
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/25.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import "XKSNetworkDataSource.h"
#import "XKSNetworkListCell.h"
#import "XKSStoreManager.h"

@interface XKSNetworkDataSource ()

@property (nonatomic, strong) XKSStoreManager *store;

@end

@implementation XKSNetworkDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        self.store = [XKSStoreManager storeLog:XKSLogType_Network];
    }
    return self;
}

- (void)reloadData {
    self.dataSource = [self.store typeLogs];
}

- (void)clearData {
    [self.store clearLogs];
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XKSNetworkListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"networkCell" forIndexPath:indexPath];
    [cell configureCell:self.dataSource[indexPath.row]];
    return cell;
}

@end
