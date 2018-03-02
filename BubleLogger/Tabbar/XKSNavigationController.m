//
//  XKSNavigationController.m
//  XKSBubleLogger
//
//  Created by SuperMario@lvhan on 2018/1/29.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import "XKSNavigationController.h"
#import "UIColor+Buble.h"
#import "XKSBubleFunction.h"
#import "XKSLogListViewController.h"

@interface XKSNavigationController ()

@end

@implementation XKSNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.tintColor = UIColor.mainColor;
    self.navigationBar.titleTextAttributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:20],
                                               NSForegroundColorAttributeName: UIColor.mainColor
                                               };
    UIImage *image = bubleExternalBundleImage(BubleBundleName, @"xks_close");
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
    if ([self.topViewController isKindOfClass:[XKSLogListViewController class]]) {
        self.topViewController.navigationItem.rightBarButtonItem = item;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - func
- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
