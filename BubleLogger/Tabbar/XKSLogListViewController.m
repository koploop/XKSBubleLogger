//
//  XKSLogListViewController.m
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/25.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import "XKSLogListViewController.h"
#import "XKSNotificationPoster.h"
#import "XKSNotificationObserver.h"
#import "XKSLogListDataSource.h"
#import "XKSNetworkDataSource.h"
#import "UIColor+Buble.h"
#import "XKSStoreManager.h"
#import "XKSNetDetailTableController.h"
#import "XKSLogFilterViewController.h"
#import "XKSBubleFunction.h"

@interface XKSLogListViewController () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UILabel *emptyStateLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@property (nonatomic, assign) XKSLogType logType;
@property (nonatomic, strong) XKSLogListDataSource  *logDataSource;
@property (nonatomic, strong) XKSNetworkDataSource  *networkDataSource;
@property (nonatomic, strong) XKSNotificationObserver *logObserver;
@property (nonatomic, strong) XKSNotificationObserver *settingObserver;
@property (nonatomic, strong) XKSNotificationObserver *networkObserver;

@end

@implementation XKSLogListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self paramterinit];
    [self subViewsInit];
    [self resetLogType:XKSLogType_Log];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [XKSNotificationPoster postNotificationType:XKSNotiType_ResetCountBadge];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [XKSNotificationPoster postNotificationType:XKSNotiType_ResetCountBadge];
}

#pragma mark - func
- (void)paramterinit {
    self.logDataSource = [XKSLogListDataSource new];
    self.networkDataSource = [XKSNetworkDataSource new];
    [_logDataSource reloadData];
    [_networkDataSource reloadData];
    [self observerInit];
}

- (void)subViewsInit {
    
    self.segment.tintColor = UIColor.mainColor;
    self.emptyStateLabel.hidden = YES;
    [self.tableview registerNib:[UINib nibWithNibName:@"XKSLogTableViewCell" bundle:bubleExternalBundle(BubleBundleName)] forCellReuseIdentifier:@"logCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"XKSNetworkListCell" bundle:bubleExternalBundle(BubleBundleName)] forCellReuseIdentifier:@"networkCell"];
    self.tableview.dataSource = _logDataSource;
    self.tableview.delegate = self;
    
    self.tableview.separatorInset = UIEdgeInsetsZero;
    self.tableview.tableFooterView = [UIView new];
}

- (void)resetLogType:(XKSLogType)logType {
    self.logType = logType;
    NSUInteger count = 0;
    if (logType == XKSLogType_Log) {
        self.tableview.estimatedRowHeight = 80;
        self.tableview.rowHeight = UITableViewAutomaticDimension;
        self.tableview.dataSource = self.logDataSource;
        [self.logDataSource reloadData];
        count = self.logDataSource.dataSource.count;
    } else {
        self.tableview.rowHeight = 75;
        self.tableview.dataSource = self.networkDataSource;
        [self.networkDataSource reloadData];
        count = self.logDataSource.dataSource.count;
    }
    [self.tableview reloadData];
    self.emptyStateLabel.hidden = count > 0;
}

- (void)observerInit {
    XKSNotificationPoster *logPoster = [XKSNotificationPoster posterWithNotificationType:XKSNotiType_RefreshLogs];
    self.logObserver = [XKSNotificationObserver observerWithMessageType:XKSMessageType_Void notification:logPoster notificationBlock:^(NSString * _Nullable content) {
        if (self.logType != XKSLogType_Log) {
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self resetLogType:XKSLogType_Log];
        });
    }];
    XKSNotificationPoster *netPoster = [XKSNotificationPoster posterWithNotificationType:XKSNotiType_StopRequest];
    self.networkObserver = [XKSNotificationObserver observerWithMessageType:XKSMessageType_Void notification:netPoster notificationBlock:^(NSString * _Nullable content) {
        if (self.logType != XKSLogType_Network) {
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self resetLogType:XKSLogType_Network];
        });
    }];
    XKSNotificationPoster *settingPoster = [XKSNotificationPoster posterWithNotificationType:XKSNotiType_SettingsChanged];
    self.settingObserver = [XKSNotificationObserver observerWithMessageType:XKSMessageType_Void notification:settingPoster notificationBlock:^(NSString * _Nullable content) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableview reloadData];
        });
    }];
}

- (void)clearLogs {
    [self.logDataSource clearData];
    [self.networkDataSource clearData];
    [XKSStoreManager clearAllTypeLogs];
    self.emptyStateLabel.hidden = NO;
    [self.tableview reloadData];
}

#pragma mark - actions
- (IBAction)didChangeIndex:(UISegmentedControl *)sender {
    [self resetLogType:sender.selectedSegmentIndex];
}

- (IBAction)logFilterAction:(UIBarButtonItem *)sender {
    UIStoryboard *storyboard = bubleExternalStoryBoard(BubleBundleName, @"XKSLogs");
    XKSLogFilterViewController *filter = [storyboard instantiateViewControllerWithIdentifier:@"filterViewController"];
    [self addChildViewController:filter];
    filter.view.frame = self.view.bounds;
    [self.view addSubview:filter.view];
    [filter didMoveToParentViewController:self];
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.logType != XKSLogType_Network) {
        return;
    }
    XKSNetworkLog *netLog = self.networkDataSource.dataSource[indexPath.row];
    if (netLog) {
        [self performSegueWithIdentifier:@"netDetailSegue" sender:netLog];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.logType == XKSLogType_Log) {
        [self.logDataSource scrollViewDidEnd:self.tableview];
    }
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UIViewController *viewController = [segue destinationViewController];
    if ([viewController isKindOfClass:[XKSNetDetailTableController class]]) {
        [(XKSNetDetailTableController*)viewController setLog:sender];
        return;
    }
    //
}

@end
