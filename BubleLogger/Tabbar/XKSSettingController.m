//
//  XKSSettingController.m
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/25.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import "XKSSettingController.h"
#import "XKSStoreManager.h"
#import "XKSLogListViewController.h"
#import "XKSBubleFunction.h"
#import "XKSLogSetting.h"

@interface XKSSettingController ()

@property (weak, nonatomic) IBOutlet UISwitch *resetLogAtStart;
@property (weak, nonatomic) IBOutlet UISwitch *overridePrint;

@property (weak, nonatomic) IBOutlet UISwitch *logInvoker;
@property (weak, nonatomic) IBOutlet UISwitch *displayDate;
@property (weak, nonatomic) IBOutlet UISwitch *monitorNetwork;

@end

@implementation XKSSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self subViewInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)subViewInit {
    self.tabBarItem.title = @"Setting";
    [self.tabBarItem setImage:bubleExternalBundleImage(BubleBundleName, @"xks_tabbar_setting")];
    [self.tabBarItem setSelectedImage:bubleExternalBundleImage(BubleBundleName, @"xks_tabbar_setting")];
}

#pragma mark - func
- (IBAction)valueDidChanged:(UISwitch *)sender {
    switch (sender.tag) {
        case 101:
            [self resetLogAtStart:sender.isOn];
            break;
        case 102:
            [self overridePrint:sender.isOn];
            break;
        case 103:
            [self logInvoker:sender.isOn];
            break;
        case 104:
            [self displayDate:sender.isOn];
            break;
        case 105:
            [self monitorNetwork:sender.isOn];
            break;
        default:
            break;
    }
}

- (void)resetLogAtStart:(BOOL)value {
    [XKSLogSetting sharedSetting].resetLogsStart = value;
}

- (void)overridePrint:(BOOL)value {
    [XKSLogSetting sharedSetting].overrideSysLog = value;
}

- (void)logInvoker:(BOOL)value {
    [XKSLogSetting sharedSetting].fileNameEnable = value;
}

- (void)displayDate:(BOOL)value {
    [XKSLogSetting sharedSetting].logDateEnable = value;
}

- (void)monitorNetwork:(BOOL)value {
    [XKSLogSetting sharedSetting].networkLogEnable = value;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != 2) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    
    // 清空日志
    [XKSStoreManager clearAllTypeLogs];
    XKSLogListViewController *logListVC = [self.navigationController.tabBarController viewControllers][0];
    [logListVC resetLogType:XKSLogType_Log];
}

@end
