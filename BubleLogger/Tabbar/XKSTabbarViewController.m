//
//  XKSTabbarViewController.m
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/25.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import "XKSTabbarViewController.h"
#import "UIColor+Buble.h"
#import "XKSCrashLogger.h"

@interface XKSTabbarViewController ()

@end

@implementation XKSTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor = [UIColor mainColor];
    
    NSInteger count = XKSCrashLogger.sharedLogger.crashCount;
    if (count > 0) {
        self.tabBar.items[1].badgeValue = [NSString stringWithFormat:@"%d", count];
    }
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    item.badgeValue = nil;
}

@end
