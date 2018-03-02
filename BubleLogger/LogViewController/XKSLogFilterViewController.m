//
//  XKSLogFilterViewController.m
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/25.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import "XKSLogFilterViewController.h"
#import "XKSBubleMacro.h"
#import "XKSBubleFunction.h"
#import "XKSFilterTableViewCell.h"

@interface XKSLogFilterViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@end

@implementation XKSLogFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self paramterInit];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [UIView animateWithDuration:0.5 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
//        self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
//    } completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)paramterInit {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 50;
    [self.tableView registerNib:[UINib nibWithNibName:@"XKSFilterTableViewCell" bundle:bubleExternalBundle(BubleBundleName)] forCellReuseIdentifier:@"filterCell"];
}

#pragma mark - action
- (IBAction)closeFilter:(id)sender {
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

#pragma mark - tableView delegate & dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XKSFilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"filterCell" forIndexPath:indexPath];
    [cell configureCellWithIndexPath:indexPath taped:^(BOOL tap) {
        
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = [UITableViewHeaderFooterView new];
    header.textLabel.text = @"FILTER DISPLAY LOG LEVEL";
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}


@end
