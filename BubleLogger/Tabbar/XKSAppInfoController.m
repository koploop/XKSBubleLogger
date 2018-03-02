//
//  XKSAppInfoController.m
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/25.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import "XKSAppInfoController.h"
#import "XKSBubleFunction.h"

@interface XKSAppInfoController ()

@property (weak, nonatomic) IBOutlet UILabel *crashCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *bundleID;
@property (weak, nonatomic) IBOutlet UILabel *versionNumber;
@property (weak, nonatomic) IBOutlet UILabel *buildNumber;

@property (weak, nonatomic) IBOutlet UILabel *authorName;
@property (weak, nonatomic) IBOutlet UILabel *blogLabel;
@property (weak, nonatomic) IBOutlet UILabel *refrenceLabel;

@end

@implementation XKSAppInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self subViewInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)subViewInit {
    self.tabBarItem.title = @"AppInfo";
    [self.tabBarItem setImage:bubleExternalBundleImage(BubleBundleName, @"xks_info")];
    [self.tabBarItem setSelectedImage:bubleExternalBundleImage(BubleBundleName, @"xks_info")];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [@[@1, @3, @3][section] integerValue];
}

@end
