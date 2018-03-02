//
//  XKSNetDetailTableController.m
//  XKSBubleLogger
//
//  Created by SuperMario@lvhan on 2018/2/5.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import "XKSNetDetailTableController.h"

@interface XKSNetDetailTableController ()
@property (weak, nonatomic) IBOutlet UITextView *headerTextView;

@property (weak, nonatomic) IBOutlet UITextView *urlTextView;
@property (weak, nonatomic) IBOutlet UITextView *latencyTextView;
@property (weak, nonatomic) IBOutlet UITextView *bodyTextView;

@property (weak, nonatomic) IBOutlet UITextView *responseTextView;

@end

@implementation XKSNetDetailTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self paramterInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)paramterInit {
    
    self.tableView.estimatedRowHeight = 80;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.headerTextView.text = [NSString stringWithFormat:@"Header: %@", self.log.headers];
    
    self.urlTextView.text = [NSString stringWithFormat:@"Url: %@", self.log.url];
    double mSecond = ((NSInteger)(self.log.duration * 1000) % 1000) / 1000.0;
    self.latencyTextView.text = [NSString stringWithFormat:@"Latency: %.f ms", mSecond];
    self.bodyTextView.text = [NSString stringWithFormat:@"Parameters/Body: %@", data2String(self.log.httpBody)];
    
    self.responseTextView.text = [NSString stringWithFormat:@"Response: %@", data2String(self.log.dataResponse)];
}

NSString *data2String(NSData *data) {
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
